//
//  AddressModel.swift
//  AddressBookSwift
//
//  Created by Craig Liao on 15/8/21.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

import UIKit

class AddressModel: NSObject {
    
    var name : String?
    
    var phone : String?
    
    init(name : String, phone : String) {
        self.name = name
        self.phone = phone
    }
   
}
