//
//  CacheManager.swift
//  Winsharesapp
//
//  Created by samson on 1/12/2016.
//  Copyright © 2016 samson. All rights reserved.
//

import UIKit

class CacheManager: NSObject {
    
    static let sharedInstance = CacheManager()
    
    let documentsPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    
    func cachedObjectForKey(_ key:String)->AnyObject?{
        let path = documentsPath + "/" + key + ".cache"
        if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            let object:AnyObject? = NSKeyedUnarchiver.unarchiveObject(with: data) as AnyObject?
            return object!
        }else {
            return nil
        }
        
    }
    
    func cacheObjectForKey(_ object:AnyObject!,key:String!) ->Bool {
        let path = documentsPath + "/" + key + ".cache"
        return NSKeyedArchiver.archiveRootObject(object, toFile: path)
    }
    
    func archiveRootObjectForKey(_ object:AnyObject,key:String) -> Bool {
        let path = documentsPath + "/" + key + ".cache"
        return NSKeyedArchiver.archiveRootObject(object, toFile: path)
    }
    
    func unarchiveObjectWithKey(_ key:String)->AnyObject?{
        let path = documentsPath + "/" + key + ".cache"
        return NSKeyedUnarchiver.unarchiveObject(withFile: path) as AnyObject?
    }
    
    
}

