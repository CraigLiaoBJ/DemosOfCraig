//
//  AddressManager.swift
//  AddressBookSwift
//
//  Created by Craig Liao on 15/8/21.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

import UIKit

class AddressManager: NSObject {
    
    let array : NSMutableArray? = NSMutableArray()
    
    var count : Int {
        get{
            return array!.count
        }
    }
    
    private static var manager : AddressManager? = nil
    static func shareManager() -> AddressManager{
        
        if (manager == nil){
            manager = AddressManager()
        }
        
        return manager!
    }
    
    func addObjectOnArray(newObject: AddressModel) {
        if count != 0{
            self.array?.insertObject(newObject, atIndex: count - 1)
        } else {
            self.array?.insertObject(newObject, atIndex: 0)
        }
    }
    
    func changeObjcetOnArray(newObject : AddressModel, Index : Int) {
        self.array?.replaceObjectAtIndex(Index, withObject: newObject)
    }
    
    func objectAtIndex(index : Int) -> AddressModel {
        return self.array![index] as! AddressModel
    }

}
