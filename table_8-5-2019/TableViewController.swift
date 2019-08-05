//
//  ViewController.swift
//  table_8-5-2019
//
//  Created by Nathaniel Mcdowell on 8/5/19.
//  Copyright © 2019 Nathaniel Mcdowell. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, shoutDelegate{
    
    func shout(_ name:String, _ row:Int){
        print("hit \(name) at row: \(row) whose age is: \(tableData.people[row].age)")
    }

    var isLandscape:Bool?
    let CELL_ID = "CELL_ID"
    var tableData:viewData = viewData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .yellow
        navigationItem.title = "Dinomite!"
        tableView.register(CustomCell.self, forCellReuseIdentifier: CELL_ID)
        fillDataTables()
    }

    func fillDataTables(){
        let me:person = person(name:"Nate",age:41,title:"Programmer")
        tableData.people.append(me)
        tableData.people.append(person(name:"Sylvester",age:63,title:"Actor"))
        tableData.people.append(person(name:"Thomas",age:43,title:"Athlete"))
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.people.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! CustomCell
        
        cell.delegate = self
        cell.cellPersonData = tableData.people[indexPath.row]
        cell.isLandscape = UIDevice.current.orientation.isLandscape
        cell.configureViews()
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
 
        tableView.reloadData()
                    //tableView.setNeedsLayout()
                    //tableView.setNeedsDisplay()
        //print("reloading")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("age at Selected Row is \(tableData.people[indexPath.row].age)")
        
    }
//    func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//
//
//        return UITableViewCell()
//    }
}

