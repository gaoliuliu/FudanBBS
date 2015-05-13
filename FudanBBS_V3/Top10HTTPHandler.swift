//
//  Top10HTTPHandler.swift
//  FudanBBS_V3
//
//  Created by gaowei on 14/12/21.
//  Copyright (c) 2014年 gaowei. All rights reserved.
//

import Foundation


public class Top10HTTPHandler {
    
    func getTop10List(username:String,password:String) -> [Top10]{
        var top10s:[Top10] = []
        
        
        var xmlToParse:NSString  = getResponse("/top10",params:nil)
        
        var len = xmlToParse.rangeOfString("<bbstop10>").location
        //println(len)
        var newstr = xmlToParse.substringFromIndex(len)
        //println(newstr)
        let xml = SWXMLHash.parse(newstr)
        
        
        for elem in xml["bbstop10"]["top"] {
            var tmp = Top10()
            tmp.text = elem.element?.text
            tmp.count = elem.element?.attributes["count"]
            tmp.gid = elem.element?.attributes["gid"]
            tmp.owner = elem.element?.attributes["owner"]
            tmp.board = elem.element?.attributes["board"]
            
            
            top10s.append(tmp)
        }
        
        return top10s
        
    }
    
    func getTop10PostPA(new1:String,board:String,f:String) -> bbstcon{
        
        
        var bbs = bbstcon()
        
        var params1 = ["new":new1,"board":board,"f":f]
        var xmlToParse:NSString  = getTopPost("/tcon",params:params1)
        
        var len = xmlToParse.rangeOfString("<bbstcon").location
        
        var newstr = xmlToParse.substringFromIndex(len)
        
        let xml = SWXMLHash.parse(newstr)
        
        bbs.bid = xml["bbstcon"].element?.attributes["bid"]
        bbs.gid = f
        
        
        for elem in xml["bbstcon"]["po"] {
            var tmp = Post_PA()
            tmp.fid = elem.element?.attributes["fid"]
            tmp.owner1 = elem.element?.attributes["owner"]
            tmp.owner2 = elem["owner"].element?.text
            tmp.nick = elem["nick"].element?.text
            tmp.title = elem["title"].element?.text
            tmp.board = elem["board"].element?.text
            tmp.date = elem["date"].element?.text
            tmp.pa = ""
            tmp.quote = ""
            tmp.tail = ""
            let isQ = elem["pa"].all.count
            
            
            for elems in elem["pa"]
            {
                
                if(elems.element?.attributes["m"] == "t")
                {
                    for elemps in elems["p"]
                    {
                        let tmppa = elemps.element?.text
                        if (tmppa?.isEmpty != nil){
                            tmp.pa.extend(tmppa!)
                            tmp.pa.extend("\n")
                        }
                    }
                    

                }
                else if(elems.element?.attributes["m"] == "q")
                {
                    for elemps in elems["p"]
                    {
                        let tmppa = elemps.element?.text
                        if (tmppa?.isEmpty != nil){
                            tmp.quote.extend(tmppa!)
                            tmp.quote.extend("\n")
                        }
                    }

                }else if(elems.element?.attributes["m"] == "s")
                {
                    for elemps in elems["p"]
                    {
                        let tmppa = elemps.element?.text
                        //println(tmppa)
                        if (tmppa?.isEmpty != nil){
                            tmp.tail.extend(tmppa!)
                            tmp.tail.extend("\n")
                        }
                    }
                }
        
            }

            
            bbs.paList.append(tmp)
        }
        bbs.fid = bbs.paList.last?.fid
        return bbs
        
    }
    
    func getTop10PostPA_NEXT(new1:String,bid:String,gid:String,fid:String,a:String) -> bbstcon{
        
        
        var bbs = bbstcon()
        
        var params1 = ["new":new1,"bid":bid,"g":gid,"f":fid,"a":a]
    
        var xmlToParse:NSString  = getTopPost("/tcon",params:params1)
        
        var len = xmlToParse.rangeOfString("<bbstcon").location
        var newstr = ""
        if(len>xmlToParse.length){
           return bbs
        }
        newstr = xmlToParse.substringFromIndex(len)
        let xml = SWXMLHash.parse(newstr)
        
        bbs.bid = xml["bbstcon"].element?.attributes["bid"]
        bbs.gid = gid
        
        for elem in xml["bbstcon"]["po"] {
            var tmp = Post_PA()
            tmp.fid = elem.element?.attributes["fid"]
            tmp.owner1 = elem.element?.attributes["owner"]
            tmp.owner2 = elem["owner"].element?.text
            tmp.nick = elem["nick"].element?.text
            tmp.title = elem["title"].element?.text
            tmp.board = elem["board"].element?.text
            tmp.date = elem["date"].element?.text
            tmp.pa = ""
            tmp.quote = ""
            tmp.tail = ""
            let isQ = elem["pa"].all.count
            
            
            for elems in elem["pa"]
            {
                
                if(elems.element?.attributes["m"] == "t")
                {
                    for elemps in elems["p"]
                    {
                        let tmppa = elemps.element?.text
                        if (tmppa?.isEmpty != nil){
                            tmp.pa.extend(tmppa!)
                            tmp.pa.extend("\n")
                        }
                    }
                    
                    
                }
                else if(elems.element?.attributes["m"] == "q")
                {
                    for elemps in elems["p"]
                    {
                        let tmppa = elemps.element?.text
                        if (tmppa?.isEmpty != nil){
                            tmp.quote.extend(tmppa!)
                            tmp.quote.extend("\n")
                        }
                    }
                    
                }else if(elems.element?.attributes["m"] == "s")
                {
                    for elemps in elems["p"]
                    {
                        let tmppa = elemps.element?.text
                        //println(tmppa)
                        if (tmppa?.isEmpty != nil){
                            tmp.tail.extend(tmppa!)
                            tmp.tail.extend("\n")
                        }
                    }
                }
                
            }
            
            
            bbs.paList.append(tmp)
        }
        bbs.fid = bbs.paList.last?.fid
        return bbs
        
    }

    func getTop10PostPA_PREV(new1:String,bid:String,gid:String,fid:String,a:String) -> bbstcon{
        
        
        var bbs = bbstcon()
        
        var params1 = ["new":new1,"bid":bid,"g":gid,"f":fid,"a":"p"]
        
        var xmlToParse:NSString  = getTopPost("/tcon",params:params1)
        
        var len = xmlToParse.rangeOfString("<bbstcon").location
        
        var newstr = xmlToParse.substringFromIndex(len)
        
        let xml = SWXMLHash.parse(newstr)
        
        bbs.bid = xml["bbstcon"].element?.attributes["bid"]
        bbs.gid = gid
        
        for elem in xml["bbstcon"]["po"] {
            var tmp = Post_PA()
            tmp.fid = elem.element?.attributes["fid"]
            tmp.owner1 = elem.element?.attributes["owner"]
            tmp.owner2 = elem["owner"].element?.text
            tmp.nick = elem["nick"].element?.text
            tmp.title = elem["title"].element?.text
            tmp.board = elem["board"].element?.text
            tmp.date = elem["date"].element?.text
            tmp.pa = ""
            tmp.quote = ""
            tmp.tail = ""
            let isQ = elem["pa"].all.count
            
            
            for elems in elem["pa"]
            {
                
                if(elems.element?.attributes["m"] == "t")
                {
                    for elemps in elems["p"]
                    {
                        let tmppa = elemps.element?.text
                        if (tmppa?.isEmpty != nil){
                            tmp.pa.extend(tmppa!)
                            tmp.pa.extend("\n")
                        }
                    }
                    
                    
                }
                else if(elems.element?.attributes["m"] == "q")
                {
                    for elemps in elems["p"]
                    {
                        let tmppa = elemps.element?.text
                        if (tmppa?.isEmpty != nil){
                            tmp.quote.extend(tmppa!)
                            tmp.quote.extend("\n")
                        }
                    }
                    
                }else if(elems.element?.attributes["m"] == "s")
                {
                    for elemps in elems["p"]
                    {
                        let tmppa = elemps.element?.text
                        //println(tmppa)
                        if (tmppa?.isEmpty != nil){
                            tmp.tail.extend(tmppa!)
                            tmp.tail.extend("\n")
                        }
                    }
                }
                
            }
            
            
            bbs.paList.append(tmp)
        }
        bbs.fid = bbs.paList.first?.fid
        return bbs
        
    }
    
    func getResponse(url:String, params:Dictionary<String, AnyObject>?)-> NSString {
        var request = HTTPTask()
        var str = ""
        request.baseURL = "http://bbs.fudan.edu.cn/bbs"
        request.GET(url, parameters: nil, success: {(response: HTTPResponse) in
            if let data = response.responseObject as? NSData {
                
                var encode:NSStringEncoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue))
                
                str  = NSString(data: data, encoding: encode)! as String
                
                
                
            }
            },failure: {(error: NSError, response: HTTPResponse?) in
                
                println("error: \(error)")
        })
        
        sleep(1)
        return str
        
    }
    
    func getTopPost(url:String, params:Dictionary<String, AnyObject>?)-> NSString {
        var request = HTTPTask()
        var str = ""
        
        request.baseURL = "http://bbs.fudan.edu.cn/bbs"
        request.GET("/tcon", parameters: params, success: {(response: HTTPResponse) in
            if let data = response.responseObject as? NSData {
                
                var encode:NSStringEncoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue))
                
                str  = NSString(data: data, encoding: encode) as! String
                
                
                
            }
            },failure: {(error: NSError, response: HTTPResponse?) in
                
                println("error: \(error)")
        })
        
        sleep(1)
        //println("toppost: \(str)")
        return str
        
        
    }
    
}