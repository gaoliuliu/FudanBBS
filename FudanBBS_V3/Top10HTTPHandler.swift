//
//  Top10HTTPHandler.swift
//  FudanBBS_V3
//
//  Created by gaowei on 14/12/21.
//  Copyright (c) 2014年 gaowei. All rights reserved.
//

import Foundation


public class Top10HTTPHandler {
    
    
    func getLoginList()
    {
        
        var isU:Bool = UserInfoHandler().isUserInfoAvailable()
        
        if isU {
             getLogOutList()
             var user:UserInfo = UserInfoHandler().fetchUserInfo()
             var id = user.userId
             var pw = user.passwd
             var params1 = ["id":id,"pw":pw]
            
             var xmlToParse:NSString  = postTopPost("/login",params:params1)
             var len = xmlToParse.rangeOfString("错误").location
            
             if(len>xmlToParse.length){
                
                UserInfoHandler().saveUserInfo(id, pw:pw,flag:true)
            }

        }
    }
    
    func ifLogin()->String
    {
    
        var result = ""
        var isU:Bool = UserInfoHandler().isUserInfoAvailable()
        
        if isU {
            var user:UserInfo = UserInfoHandler().fetchUserInfo()
            if user.login == true
            {
                result = user.userId
            }
            
        }
        return result
            
    }
    func postRePost(bid:String,fid:String,title:String, text: String)->Bool{
        var result = false
        
        var params1 = ["title":title,"sig":"1","text":text]
        var xmlToParse:NSString  = postTopPost("/snd?bid="+bid+"&f="+fid+"&utf8=1",params:params1)
        
        var len = xmlToParse.rangeOfString("成功").location
        
        if(len<=xmlToParse.length){
            result = true
            
            
        }
        
        return result

    
    
    }
    func postNewPost(bid:String,title:String, text: String)->Bool{
        var result = false
        
        var params1 = ["title":title,"sig":"1","text":text]
        var xmlToParse:NSString  = postTopPost("/snd?bid="+bid+"&f=&e=0&utf8=1",params:params1)
        
        var len = xmlToParse.rangeOfString("成功").location
        
        if(len<=xmlToParse.length){
            result = true
            
            
        }
        
        return result

    
    }
    
    
    func postNewMail(recv:String,title:String, text: String)->Bool{
        var result = false
        var encode:NSStringEncoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue))
        var params1 = ["ref":"/bbs/mail","recv":recv,"title":title,"backup":"backup","text":text]
        var xmlToParse:NSString  = postTopPost("/sndmail",params:params1)
        
        var len = xmlToParse.rangeOfString("成功").location
        
        if(len<=xmlToParse.length){
            result = true
            
            
        }
        
        return result
        
        
    }
    
    
    
    
    func getFromLogin(id:String,pw:String)->Bool
    {
        var result = false
        getLogOutList()
        var params1 = ["id":id,"pw":pw]
        var xmlToParse:NSString  = postTopPost("/login",params:params1)
        
        var len = xmlToParse.rangeOfString("错误").location
        
        if(len>xmlToParse.length){
            result = true
            
            UserInfoHandler().saveUserInfo(id, pw:pw,flag:true)
        }
        
        return result
    
    }
    
    func getLogOutList()
    {
        
        var xmlToParse:NSString  = getResponse("/logout",params:nil)
        var isU:Bool = UserInfoHandler().isUserInfoAvailable()
        
        if isU {
            var user:UserInfo = UserInfoHandler().fetchUserInfo()
            UserInfoHandler().saveUserInfo(user.userId, pw:user.passwd,flag:false)

        }

        
    }
    func getMailList()->[Mail]
    {
        var returnList:[Mail] = []
        
        var xmlToParse2:NSString  = getResponse("/mail",params:nil)
        
        
        var len = xmlToParse2.rangeOfString("<bbsmail").location
        var newstr = ""
        if(len>xmlToParse2.length){
            return []
        }
        newstr = xmlToParse2.substringFromIndex(len)
        
        var start:Int! = 0
        var counter:Int! = 0
        let xml = SWXMLHash.parse(newstr)
        for elem in xml["bbsmail"] {
            
            start = elem.element?.attributes["start"]?.toInt()
            counter = start + 19
        }
        for elem in xml["bbsmail"]["mail"] {
            var tmp = Mail()
            tmp.text = elem.element?.text
            tmp.name = elem.element?.attributes["name"]
            tmp.start = start
            tmp.num = counter
            counter = counter - 1
            returnList.append(tmp)
        }
        
        return returnList
    
    
    }
    
    func getMailRecevier(n:String)->PstMail{
        var returnString:PstMail = PstMail()
        
        var xmlToParse2:NSString  = getResponse("/pstmail?n="+n,params:nil)
        println("/pstmail?n="+n)
        
        var len = xmlToParse2.rangeOfString("<bbspstmail").location
        var newstr = ""
        if(len>xmlToParse2.length){
            return returnString
        }
        newstr = xmlToParse2.substringFromIndex(len)
        
        let xml = SWXMLHash.parse(newstr)
        for elem in xml["bbspstmail"] {
            returnString.ref = elem.element?.attributes["ref"]
            returnString.recv  = elem.element?.attributes["recv"]
            
        }
        for elem in xml["bbspstmail"]["t"] {
            returnString.title = elem.element?.text
            
        }
        for elem in xml["bbspstmail"]["m"] {
            returnString.text = elem.element?.text
            
        }
        
        return returnString
    
    
    
    }
    
    
    
    
    
    
    func getMailPost(name:String,num:Int)->MailDetail
    {
        var returnString:MailDetail = MailDetail()
        
        var xmlToParse2:NSString  = getResponse("/mailcon?f="+name+"&n="+String(num),params:nil)
        
        println("/mailcon?f="+name+"&n="+String(num))
        var len = xmlToParse2.rangeOfString("<bbsmailcon").location
        var newstr = ""
        if(len>xmlToParse2.length){
            return returnString
        }
        newstr = xmlToParse2.substringFromIndex(len)
        
        let xml = SWXMLHash.parse(newstr)
        for elem in xml["bbsmailcon"]["t"] {
            returnString.title = elem.element?.text
            
        }
        for elem in xml["bbsmailcon"]["mail"] {
            returnString.text = elem.element?.text
            returnString.n = elem.element?.attributes["n"]!.toInt()
        }
        
        return returnString
        
        
    }
    
    
    func getMailListStart(start:Int)->[Mail]
    {
        var returnList:[Mail] = []
        
        var xmlToParse2:NSString  = getResponse("/mail?start="+String(start),params:nil)
        
        
        var len = xmlToParse2.rangeOfString("<bbsmail").location
        var newstr = ""
        if(len>xmlToParse2.length){
            return []
        }
        newstr = xmlToParse2.substringFromIndex(len)
        
        var start:Int! = 0
        var counter:Int! = 0
        let xml = SWXMLHash.parse(newstr)
        for elem in xml["bbsmail"] {
            
            start = elem.element?.attributes["start"]?.toInt()
            counter = start + 19
        }
        for elem in xml["bbsmail"]["mail"] {
            var tmp = Mail()
            tmp.text = elem.element?.text
            tmp.name = elem.element?.attributes["name"]
            tmp.start = start
            tmp.num = counter
            counter = counter - 1
            returnList.append(tmp)
        }
        
        return returnList
        
        
    }

    
    
    func getFavList() ->[String!]
    {
        var returnList:[String!] = []
        
        var xmlToParse2:NSString  = getResponse("/sec",params:nil)
       
        
        var len = xmlToParse2.rangeOfString("<f>").location
        var newstr = ""
        if(len>xmlToParse2.length){
            return []
        }
        newstr = xmlToParse2.substringFromIndex(len)
        //println(newstr)
        let xml = SWXMLHash.parse(newstr)
        for elem in xml["f"]["b"] {
            
            
            returnList.append(elem.element?.text)
        }
        
        return returnList
    }
    func getFavPostList(board:String) ->[Post]
    {
        var resultList:[Post] = []
        var xmlToParse:NSString  = getResponse("/tdoc?board="+board,params:nil)
        
        var len = xmlToParse.rangeOfString("<bbsdoc>").location
        //println(len)
        var newstr = ""
        if(len>xmlToParse.length){
            return resultList
        }
        newstr = xmlToParse.substringFromIndex(len)
        //println(newstr)
        let xml = SWXMLHash.parse(newstr)
        var bid:String! = ""
        var start:Int! = 0
        for elem in xml["bbsdoc"]["brd"] {
            bid = elem.element?.attributes["bid"]
            start = elem.element?.attributes["start"]?.toInt()
        }
        for elem in xml["bbsdoc"]["po"] {
            var tmp = Post()
            tmp.text = elem.element?.text
            tmp.fid = elem.element?.attributes["id"]
            tmp.bid = bid
            tmp.start = start
            resultList.append(tmp)
        }
        
        
        
        
        return resultList.reverse()

    
    }
    
    func getFavPostListStart(bid:String,start:Int) ->[Post]
    {
        var resultList:[Post] = []
        var xmlToParse:NSString  = getResponse("/tdoc?bid="+bid+"&start="+String(start),params:nil)
        
        var len = xmlToParse.rangeOfString("<bbsdoc>").location
        //println(len)
        var newstr = ""
        if(len>xmlToParse.length){
            return resultList
        }
        newstr = xmlToParse.substringFromIndex(len)
        //println(newstr)
        let xml = SWXMLHash.parse(newstr)
        var bid:String! = ""
         var start:Int! = 0
        for elem in xml["bbsdoc"]["brd"] {
            bid = elem.element?.attributes["bid"]
            start = elem.element?.attributes["start"]?.toInt()
        }
        for elem in xml["bbsdoc"]["po"] {
            var tmp = Post()
            tmp.text = elem.element?.text
            tmp.fid = elem.element?.attributes["id"]
            tmp.bid = bid
            tmp.start = start
            resultList.append(tmp)
        }
        
        
        
        
        return resultList.reverse()
        
        
    }

    
    
    
    

    func getTop10List() -> [Top10]{
        var top10s:[Top10] = []
        
        
        var xmlToParse:NSString  = getResponse("/top10",params:nil)
        
        var len = xmlToParse.rangeOfString("<bbstop10>").location
        //println(len)
        var newstr = ""
        if(len>xmlToParse.length){
            return top10s
        }
        newstr = xmlToParse.substringFromIndex(len)
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
        
        //let userInfoHandler = UserInfoHandler()
        //userInfoHandler.saveUserInfo()
        //var userInfo:UserInfo? = userInfoHandler.fetchUserInfo()
        //println(userInfo!.userId)
        
        
        return top10s
        
    }
    
    
    func getPostPA(new1:String,board:String,f:String) -> bbstcon{
        
        
        var bbs = bbstcon()
        
        var params1 = ["new":new1,"bid":board,"f":f]
        var xmlToParse:NSString  = getResponse("/tcon",params:params1)
        
        var len = xmlToParse.rangeOfString("<bbstcon").location
        var newstr = ""
        if(len>xmlToParse.length){
            return bbs
        }
        newstr = xmlToParse.substringFromIndex(len)
        
        let xml = SWXMLHash.parse(newstr)
        
        bbs.bid = xml["bbstcon"].element?.attributes["bid"]
        bbs.gid = f
        
        
        for elem in xml["bbstcon"]["po"] {
            var tmp = Post_PA()
            var img:[String!] = []
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
                        for elemps2 in elemps["a"]
                        {
                            //println(elemps2.element?.attributes["href"])
                            img.append(elemps2.element?.attributes["href"])
                        }

                        
                        
                    }
                    
                    
                    tmp.images = img
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

    func getTop10PostPA(new1:String,board:String,f:String) -> bbstcon{
        
        
        var bbs = bbstcon()
        
        var params1 = ["new":new1,"board":board,"f":f]
        var xmlToParse:NSString  = getResponse("/tcon",params:params1)
        
        var len = xmlToParse.rangeOfString("<bbstcon").location
        var newstr = ""
        if(len>xmlToParse.length){
            return bbs
        }
        newstr = xmlToParse.substringFromIndex(len)
        
        let xml = SWXMLHash.parse(newstr)
        
        bbs.bid = xml["bbstcon"].element?.attributes["bid"]
        bbs.gid = f
        
        
        for elem in xml["bbstcon"]["po"] {
            var tmp = Post_PA()
            var img:[String!] = []
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
                        for elemps2 in elemps["a"]
                        {
                            //println(elemps2.element?.attributes["href"])
                            img.append(elemps2.element?.attributes["href"])
                        }
                    }
                     tmp.images = img

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
    
        var xmlToParse:NSString  = getResponse("/tcon",params:params1)
        
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
            var img:[String!] = []
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
                        for elemps2 in elemps["a"]
                        {
                            //println(elemps2.element?.attributes["href"])
                            img.append(elemps2.element?.attributes["href"])
                        }
                    }
                    tmp.images = img
                    
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
        
        var xmlToParse:NSString  = getResponse("/tcon",params:params1)
        
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
            var img:[String!] = []
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
                            for elemps2 in elemps["a"]
                            {
                                //println(elemps2.element?.attributes["href"])
                                img.append(elemps2.element?.attributes["href"])
                            }
                        }
                        tmp.images = img
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
    
    func getResponse2(url:String, params:Dictionary<String, AnyObject>?)-> NSString {
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
        
        
        while(true)
        {
            if str != "" {
                break
            }
        }
        
        return str
        
    }
    
    func getResponse(url:String, params:Dictionary<String, AnyObject>?)-> NSString {
        var request = HTTPTask()
        var str = ""
        var err = ""
        request.baseURL = "http://bbs.fudan.edu.cn/bbs"
        request.GET(url, parameters: params, success: {(response: HTTPResponse) in
            if let data = response.responseObject as? NSData {
                
                var encode:NSStringEncoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue))
                
                str  = NSString(data: data, encoding: encode) as! String
                
                
                
            }
            },failure: {(error: NSError, response: HTTPResponse?) in
               
                    
                    
                err = error.description
        })
        
        
       
        while(true)
        {
            if str != "" {
                 break
            }else if err != ""{
                break
            }
            
        }
        
        return str
        
        
    }
    
    
    func postTopPost(url:String, params:Dictionary<String, AnyObject>?)-> NSString {
        var request = HTTPTask()
        var str = ""
        var err = ""
        request.baseURL = "http://bbs.fudan.edu.cn/bbs"
        request.POST(url, parameters: params, success: {(response: HTTPResponse) in
            if let data = response.responseObject as? NSData {
                
                var encode:NSStringEncoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue))
                
                str  = NSString(data: data, encoding: encode) as! String
                
                
                
            }
            },failure: {(error: NSError, response: HTTPResponse?) in
                
                
                 err = error.description
        })
        
        
        while(true)
        {
            if str != "" {
                break
            }else if err != ""{
                break
            }
            
        }
        
        return str

        
    }

    
}