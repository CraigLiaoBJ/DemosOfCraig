//
//  ViewController.swift
//  AddressBookSwift
//
//  Created by Craig Liao on 15/8/21.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView : UITableView?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView = UITableView(frame: view.frame, style: UITableViewStyle.Plain)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.view.addSubview(self.tableView!)
        
        
        self.tableView?.registerClass(AddressTableViewCell.self, forCellReuseIdentifier: "CELL")
        self.tableView?.rowHeight = 100
        
        var barButton = UIBarButtonItem(title: "添加", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("barButtonClicked"))
        
        self.navigationItem.rightBarButtonItem = barButton

    }
    
    func barButtonClicked() {
        var addVC : AddAddressViewController = AddAddressViewController()
        
        addVC.myBlock = { () -> Void in
            self.tableView?.reloadData()
            
        }
        
        self.navigationController?.pushViewController(addVC, animated: true)
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("CELL", forIndexPath: indexPath) as! AddressTableViewCell
        
        let object : AddressModel = AddressManager.shareManager().objectAtIndex(indexPath.row)
        
        cell.nameLabel?.text = "姓名" + object.name!
        cell.phoneLabel?.text = "手机" + object.phone!
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AddressManager.shareManager().count
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

