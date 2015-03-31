//
//  Top10.swift
//  FudanBBS_V3
//
//  Created by gaowei on 14/12/21.
//  Copyright (c) 2014年 gaowei. All rights reserved.
//

import Foundation

public class Top10{

    var board:String! = ""
    var owner:String! = ""
    var count:String! = ""
    var gid:String!  = ""
    var text:String!  = ""
    
    init(){}
    init(board:String, owner:String, count:String, gid:String, text:String){
        self.board = board
        self.owner = owner
        self.count = count
        self.gid = gid
        self.text = text
    }
}
