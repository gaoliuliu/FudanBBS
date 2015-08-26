//
//  UserInfo.swift
//  FudanBBS_V3
//
//  Created by gaowei on 15/5/14.
//  Copyright (c) 2015年 gaowei. All rights reserved.
//

import Foundation
import CoreData

@objc(UserInfo)class UserInfo: NSManagedObject {

    @NSManaged var userId: String
    @NSManaged var passwd: String
    @NSManaged var login:Bool

}
