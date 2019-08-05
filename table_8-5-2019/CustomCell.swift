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
        nameageContainer.doConstraints(top: contentView.topAnchor, left: contentView.leadingAnchor, bottom: contentView.bottomAnchor, right: nil,
                                       padTop: 20, padLeft: 80, padBottom: -20, padRight: 0, width: 120, height: 0)
        nameDisplay.doConstraints(top: nameageContainer.topAnchor, left: nameageContainer.leadingAnchor, bottom: nil, right: nameageContainer.trailingAnchor,
                                  padTop: 0, padLeft: 20, padBottom: 0, padRight: 0, width: 0, height: 40)
        
        ageDisplay.doConstraints(top: nameDisplay.bottomAnchor, left: nameageContainer.leadingAnchor, bottom: nameageContainer.bottomAnchor, right: nameageContainer.trailingAnchor,
                                  padTop: 5, padLeft: 20, padBottom: 0, padRight: 0, width: 0, height: 0)

        let myButton:UIButton = UIButton()
         myButton.addTarget(self, action: #selector(btnPressed), for: .touchUpInside)
        myButton.setTitle("Hello", for: .normal)
        myButton.backgroundColor = .orange
        myButton.titleLabel?.textAlignment = .center
        myButton.layer.cornerRadius = 10
        contentView.addSubview(myButton)
        myButton.doConstraints(top: contentView.topAnchor, left: nameageContainer.trailingAnchor, bottom: contentView.bottomAnchor, right: nil, padTop: 20, padLeft: 20, padBottom: -20, padRight: -20, width: 0, height: 0)
        

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
            myLandscapeButton!.layer.cornerRadius = 10
            contentView.addSubview(myLandscapeButton!)
            myLandscapeButton!.doConstraints(top: contentView.topAnchor, left: myButton.trailingAnchor, bottom: contentView.bottomAnchor, right: nil, padTop: 20, padLeft: 20, padBottom: -20, padRight: -20, width: 0, height: 0)
             
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
