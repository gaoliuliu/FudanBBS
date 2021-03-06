//
//  LoginTableViewController.swift
//  FudanBBS_V3
//
//  Created by gaowei on 15/8/16.
//  Copyright (c) 2015年 gaowei. All rights reserved.
//

import UIKit

class LoginTableViewController: UITableViewController ,UITableViewDelegate, UITableViewDataSource{

    
    var loginList = ["登录"]
    var funList = ["给作者投食","吐槽"]
    var verList = ["关于版本"]
    var logoutList = ["退出登录"]
    var lastList = [" "]
    var resultList:[[String]] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultList.insert(loginList, atIndex: 0)
        resultList.insert(funList,atIndex:1)
        resultList.insert(verList,atIndex:2)
        resultList.insert(logoutList,atIndex:3)
        resultList.insert(lastList,atIndex:4)
        
        //self.tableView.tableFooterView = UIView()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var section :Int = indexPath.section
        var row :Int = indexPath.row
        //LOGIN
        if(section == 0)
        {
            let optionMenu = UIAlertController(title: nil, message: "登录",
                preferredStyle: .Alert)
            // Add actions to the menu
            
            optionMenu.addTextFieldWithConfigurationHandler {
                (textField: UITextField!) -> Void in
                textField.placeholder = "账号"
            }
            optionMenu.addTextFieldWithConfigurationHandler {
                    (textField: UITextField!) -> Void in
                    textField.placeholder = "密码"
                    textField.secureTextEntry = true
            }
            let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
            optionMenu.addAction(cancelAction)
            let okAction = UIAlertAction(title: "确定", style: .Default, handler: {(action:UIAlertAction!) -> Void in
                        var login:UITextField = optionMenu.textFields?.first as! UITextField
                        var password:UITextField = optionMenu.textFields?.last as! UITextField
                        var flag:Bool =  Top10HTTPHandler().getFromLogin(login.text, pw: password.text)
                        var res = "登录失败"
                        if (flag){
                            res = "登录成功"
                            
                            self.tableView.reloadData()
                        }
                    let logResultMenu = UIAlertController(title: nil, message: res,
                    preferredStyle: .Alert)
                    let cAction = UIAlertAction(title: "确定", style: .Cancel, handler: nil)
                    logResultMenu.addAction(cAction)
                // Display the menu
                    self.presentViewController(logResultMenu, animated: true, completion: nil)
                
                        
            })
            optionMenu.addAction(okAction)
            // Display the menu
            self.presentViewController(optionMenu, animated: true, completion: nil)
        
        }
        //FEED
        if(section == 1 && row == 0)
        {
                let optionMenu = UIAlertController(title: nil, message: "这么重要的功能竟然还没开发好！",
                preferredStyle: .Alert)
                // Add actions to the menu
                let cancelAction = UIAlertAction(title: "确定", style: .Cancel, handler: nil)
                optionMenu.addAction(cancelAction)
                // Display the menu
                self.presentViewController(optionMenu, animated: true, completion: nil)

        }
        //TUCAO
        if(section == 1 && row == 1)
        {
            let optionMenu = UIAlertController(title: nil, message: "投条highjoin",
            preferredStyle: .Alert)
            // Add actions to the menu
            let cancelAction = UIAlertAction(title: "确定", style: .Cancel, handler: nil)
            optionMenu.addAction(cancelAction)
            // Display the menu
            self.presentViewController(optionMenu, animated: true, completion: nil)
            
        }
        //version
        if(section == 2)
        {
                let optionMenu = UIAlertController(title: nil, message: "beta V1.1",
                preferredStyle: .Alert)
                // Add actions to the menu
                let cancelAction = UIAlertAction(title: "确定", style: .Cancel, handler: nil)
                optionMenu.addAction(cancelAction)
                // Display the menu
                self.presentViewController(optionMenu, animated: true, completion: nil)
                
        }
        //logout
        if(section == 3)
        {
            let optionMenu = UIAlertController(title: nil, message: "退出登录",
            preferredStyle: .Alert)
            // Add actions to the menu
            let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
            optionMenu.addAction(cancelAction)
            let okAction = UIAlertAction(title: "确定", style: .Default, handler: {(action:UIAlertAction!) -> Void in
                   Top10HTTPHandler().getLogOutList()
                
                   self.tableView.reloadData()
            })
            optionMenu.addAction(okAction)
            // Display the menu
            self.presentViewController(optionMenu, animated: true, completion: nil)
            
        }
        
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return self.resultList.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
       
        return self.resultList[section].count
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath:
            indexPath) as! UITableViewCell
        // Configure the cell...
        var section :Int = indexPath.section
        var row :Int = indexPath.row
        
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.text = self.resultList[section][row]
        
        if (section == 0)
        {
            var tmp:String = Top10HTTPHandler().ifLogin()
            if (tmp != ""){
               cell.textLabel?.text = tmp+"已登陆"
            }
          
        }
        if (section == 3)
        {
            cell.textLabel?.textAlignment = .Center
            
        }
        
        
        return cell

    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
