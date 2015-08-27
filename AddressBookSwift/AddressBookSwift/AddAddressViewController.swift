//
//  AddAddressViewController.swift
//  AddressBookSwift
//
//  Created by Craig Liao on 15/8/21.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

import UIKit

typealias BLOCK = () -> Void

class AddAddressViewController: UIViewController {
    
    var myBlock : BLOCK? = nil
    
    var nameLabel : UILabel?
    var phoneLabel : UILabel?
    var nameTextField : UITextField?
    var phoneTextField : UITextField?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.nameLabel = UILabel(frame: CGRectMake(10, 100, 100, 30))
        self.nameLabel?.text = "姓名"
        self.view.addSubview(self.nameLabel!)
        
        self.nameTextField = UITextField(frame: CGRectMake(120, 100, self.view.frame.size.width - 140, 30))
        self.nameTextField?.placeholder = "请输入姓名"
        self.nameTextField?.layer.borderWidth = 0.5
        self.view.addSubview(self.nameTextField!)
        
        
        self.phoneLabel = UILabel(frame: CGRectMake(10, 140, 100, 30))
        self.phoneLabel?.text = "手机号码"
        self.view.addSubview(self.phoneLabel!)
        
        self.phoneTextField = UITextField(frame: CGRectMake(120, 140, self.view.frame.size.width - 140, 30))
        self.phoneTextField?.placeholder = "请输入手机号码"
        self.phoneTextField?.layer.borderWidth = 0.5
        self.view.addSubview(self.phoneTextField!)
        
        var button : UIButton?
        
        button = UIButton.buttonWithType(UIButtonType.Custom) as? UIButton
        button?.frame =  CGRectMake(10, 190, self.view.frame.size.width - 20, 30)
        button?.backgroundColor = UIColor.blueColor()
        button?.addTarget(self, action: Selector("buttonClicked"), forControlEvents: UIControlEvents.TouchUpInside)
        button?.setTitle("保存", forState: UIControlState.Normal)
        self.view.addSubview(button!)

    }
    
    func buttonClicked() {
        
        var newModel : AddressModel = AddressModel(name: self.nameTextField!.text, phone: self.phoneTextField!.text)
        AddressManager.shareManager().addObjectOnArray(newModel)
        
        self.myBlock!()

        
        self.navigationController?.popViewControllerAnimated(true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
