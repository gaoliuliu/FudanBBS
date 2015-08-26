//
//  UserInfoHandler.swift
//  FudanBBS_V3
//
//  Created by gaowei on 15/5/14.
//  Copyright (c) 2015年 gaowei. All rights reserved.
//


import CoreData
import UIKit

public class UserInfoHandler{
    
    var userInfo:UserInfo!
    
    

    required public init() {
        
    }

   
    
    func saveUserInfo(id:String, pw:String,flag:Bool)
    {
        resetUserInfo()
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as!
            AppDelegate).managedObjectContext {
            userInfo = NSEntityDescription.insertNewObjectForEntityForName("UserInfo", inManagedObjectContext: managedObjectContext) as! UserInfo
            userInfo.userId = id
            userInfo.passwd = pw
            userInfo.login = flag
            var e: NSError?
            if managedObjectContext.save(&e) != true {
            println("insert error: \(e!.localizedDescription)")
            return
            } }
    }
    
    func resetUserInfo()
    {
        var userInfos:[UserInfo]!
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as!
            AppDelegate).managedObjectContext {
                let fetchRequest = NSFetchRequest(entityName: "UserInfo")
                var e: NSError?
                userInfos = managedObjectContext.executeFetchRequest(fetchRequest, error: &e) as! [UserInfo]
                for tmp in userInfos{
                    managedObjectContext.deleteObject(tmp)
                }
                
                if managedObjectContext.save(&e) != true {
                    println("reset error: \(e!.localizedDescription)")
                    return
                } }
    }
    
    func fetchUserInfo() -> UserInfo {
        
            var userInfos:[UserInfo]!
            if let managedObjectContext = (UIApplication.sharedApplication().delegate as!
                AppDelegate).managedObjectContext
                {
                    let fetchRequest = NSFetchRequest(entityName: "UserInfo")
                    var e: NSError?
                    userInfos = managedObjectContext.executeFetchRequest(fetchRequest, error: &e) as! [UserInfo]
                
                    if e != nil {
                    println("Failed to retrieve record: \(e!.localizedDescription)")
                        
                    }
                }
        
         if userInfos.count != 0{
             return userInfos.first!
         } else{
             return UserInfo()
         }
     }
    
    func isUserInfoAvailable() -> Bool {
        
        var userInfos:[UserInfo]!
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as!
            AppDelegate).managedObjectContext
        {
            let fetchRequest = NSFetchRequest(entityName: "UserInfo")
            var e: NSError?
            userInfos = managedObjectContext.executeFetchRequest(fetchRequest, error: &e) as! [UserInfo]
            
            if e != nil {
                println("Failed to retrieve record: \(e!.localizedDescription)")
                
            }
        }
        
        if userInfos.count != 0{
            return true
        } else{
            return false
        }
    }
    
    
    
    
}




