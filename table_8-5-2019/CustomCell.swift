//
//  CustomCell.swift
//  table_8-5-2019
//
//  Created by Nathaniel Mcdowell on 8/5/19.
//  Copyright © 2019 Nathaniel Mcdowell. All rights reserved.
//

import UIKit

class CustomCell:UITableViewCell {
    var delegate:shoutDelegate?
    var isLandscape:Bool?
    var myLandscapeButton:UIButton?
    var cellPersonData:person? {
        didSet{
            nameDisplay.text = cellPersonData!.name
            ageDisplay.text = "\(cellPersonData!.age) yrs old"
            }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
      //configureViews()
    }
    
    func configureViews(){

        let nameageContainer:UIView = UIView()
        
        addSubview(nameageContainer)
        nameageContainer.addSubview(nameDisplay)
        nameageContainer.addSubview(ageDisplay)
        
        contentView.addSubview(txtInput)
        
        nameageContainer.doConstraints(top: contentView.topAnchor, left: contentView.leadingAnchor, bottom: contentView.bottomAnchor, right: nil,
                                       padTop: 20, padLeft: 80, padBottom: -20, padRight: 0, width: 120, height: 0)
        nameDisplay.doConstraints(top: nameageContainer.topAnchor, left: nameageContainer.leadingAnchor, bottom: nil, right: nameageContainer.trailingAnchor,
                                  padTop: 0, padLeft: 20, padBottom: 0, padRight: 0, width: 0, height: 40)
        
        ageDisplay.doConstraints(top: nameDisplay.bottomAnchor, left: nameageContainer.leadingAnchor, bottom: nameageContainer.bottomAnchor, right: nameageContainer.trailingAnchor,
                                  padTop: 5, padLeft: 20, padBottom: 0, padRight: 0, width: 0, height: 0)
        
         txtInput.addTarget(self, action: #selector(updateTxtField), for: UIControl.Event.editingChanged)

        let myButton:UIButton = UIButton()
         myButton.addTarget(self, action: #selector(btnPressed), for: .touchUpInside)
        myButton.setTitle("Hello", for: .normal)
        myButton.backgroundColor = .orange
        myButton.titleLabel?.textAlignment = .center
        myButton.layer.cornerRadius = 10
        contentView.addSubview(myButton)
        myButton.doConstraints(top: contentView.topAnchor, left: nameageContainer.trailingAnchor, bottom: nil, right: nil, padTop: 20, padLeft: 40, padBottom: -5, padRight: 0, width: 100, height: 0)
        
        txtInput.doConstraints(top: myButton.bottomAnchor, left: nameageContainer.trailingAnchor, bottom: contentView.bottomAnchor, right: nil, padTop: 5, padLeft: 20, padBottom: -20, padRight: -20, width: 140, height: 0)

           //if UIDevice.current.orientation.isLandscape == true{
            if isLandscape == true{
            //print("ran special button")
            myLandscapeButton = UIButton()
                
            myLandscapeButton!.setTitle("Landscape Only Button", for: .normal)
            myLandscapeButton!.setTitleColor(.blue, for: .normal)
            myLandscapeButton!.backgroundColor = .white
            myLandscapeButton!.layer.borderWidth = 2
            myLandscapeButton!.layer.borderColor = UIColor.red.cgColor
            myLandscapeButton!.titleLabel?.textAlignment = .center
            myLandscapeButton!.titleEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
            myLandscapeButton!.layer.cornerRadius = 10
            contentView.addSubview(myLandscapeButton!)
            myLandscapeButton!.doConstraints(top: contentView.topAnchor, left: txtInput.trailingAnchor, bottom: contentView.bottomAnchor, right: nil, padTop: 20, padLeft: 20, padBottom: -20, padRight: -20, width: 260, height: 0)
             
        }
        
    }
    
    @objc func btnPressed(sender:UIButton){
       // let fromCell:CustomCell = button.superview?.superclass as! CustomCell
       // print(fromCell.cellPersonData?.name)
        //sender is in Container View, which is in Cell's contentview, which is a CustomCell!!!
        //let cell = sender.superview?.superview as! CustomCell
        //above works, but is unnecessary because THIS IS THE CUSTOMCELL as self!!!
       
        delegate!.shout("\(cellPersonData!.name)", self.indexPath!.row)
        
        /* alternative her works too (without my Magic Extension)
        let tbl = cell.superview as! UITableView
        print("Cell row : \(tbl.indexPath(for: self)!.row)")
      */
        
        print("Magic ext. easy row: \(self.indexPath!.row)")
        //let indexPath = tbl.indexPath(for: cell)
        //let myData = myDataArray[indexPath.row]
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func rotated(){
        self.reloadInputViews()
    }
    
    var nameDisplay:UILabel = {
        let nm = UILabel()
        nm.font = UIFont(name: "GillSans", size: 18)
        nm.translatesAutoresizingMaskIntoConstraints = false
        nm.textColor = .blue
        nm.clipsToBounds = true
        nm.layer.cornerRadius = 5
        nm.backgroundColor = .gray
        nm.textAlignment = .center
        nm.layer.borderColor = UIColor.blue.cgColor
        nm.layer.borderWidth = 3
        return nm
    }()
    
    var ageDisplay:UILabel = {
        let ad = UILabel()
        ad.translatesAutoresizingMaskIntoConstraints = false
        ad.font = UIFont(name: "GillSans", size: 20)
        ad.textColor = .red
        ad.layer.cornerRadius = 5
        ad.layer.masksToBounds = true
        ad.layer.borderWidth = 1
        ad.layer.borderColor = UIColor.red.cgColor
        ad.clipsToBounds = true
        ad.textAlignment = .center
        
        return ad
    }()
    
    var txtInput:UITextField = {
        var txt = UITextField()
       
        txt.placeholder = " Enter here:"
       
        txt.textColor = .gray
        txt.accessibilityValue = txt.text
        txt.accessibilityLabel = txt.placeholder
        txt.layer.borderColor = UIColor.gray.cgColor
        txt.layer.borderWidth = 2
        txt.isUserInteractionEnabled = true
        
        txt.autocapitalizationType = .none
        
        return txt
    }()
    
    @objc func updateTxtField(_ sender:UITextField){
       print("text field changed")
        let pattern = "(?=.*[A-Z])"     //"^[a-z]*[1-2]$" // 0 or more letters, followed by 1 or 2
        var regex:NSRegularExpression?
        do{
        regex = try NSRegularExpression(pattern: pattern)
    
        }catch{
        print("oops")
        }
        let valid = validate(string: sender.text!, withRegex: regex!)
        print(valid)
       let complex = checkTextSufficientComplexity(text: sender.text!)
       print("complex enough? \(complex)\r\r")
    }
    
    func checkTextSufficientComplexity(text : String) -> Bool{
        
        
        let capitalLetterRegEx  = ".*[A-Z]+.*"  //whatever before and after at least one capitol letter
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        let capitalresult = texttest.evaluate(with: text)
        print("cap: \(capitalresult)")
        
        
        let numberRegEx  = ".*[0-9].*[0-9]+.*"//".*[0-9]{2,}.*" //two numbers in a row
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let numberresult = texttest1.evaluate(with: text)
        print("num: \(numberresult)")
        
        
        let specialCharacterRegX  = ".*[!&^%$#@()/]+.*"
        let texttest2 = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegX)
        
        let specialresult = texttest2.evaluate(with: text)
        print("spec: \(specialresult)")
        
        let simple = "^.*(?=.{6,})(?=.*[A-Z]+)(?=.*[a-z]+)(?=.*[0-9]+)(?=.*[!#$%&? “]).*$"
        let simpleresult = NSPredicate(format:"SELF MATCHES %@",simple).evaluate(with: text)
        print("simple: \(simpleresult)")
        return capitalresult && numberresult && specialresult
        
    }
    //////////////////////////////////////////////////////////
    func validate(string:String, withRegex: NSRegularExpression)->Bool{
        let range = NSRange(string.startIndex..., in: string)
        let matchRange = withRegex.rangeOfFirstMatch(
            in: string,
            options: .reportProgress,
            range: range
        )
        return matchRange.location != NSNotFound
    }
    //////////////////////////////////////////////////////
    override func prepareForReuse() {
        //this happens before the viewcontroller sees current device orientation so it is opposite to common sense
        //if isLandscape == true {
        if UIDevice.current.orientation.isPortrait{
        //print("nixed the special landscape button")
        if myLandscapeButton != nil{
           myLandscapeButton?.removeFromSuperview()
            myLandscapeButton = nil
            }
            
        }
    }
}
