//
//  MailDetailViewController.swift
//  FudanBBS_V3
//
//  Created by gaowei on 15/8/13.
//  Copyright (c) 2015年 gaowei. All rights reserved.
//

import UIKit

class MailDetailViewController: UITableViewController ,UITableViewDelegate, UITableViewDataSource {

    var name:String = ""
    var num:Int = 0
    var mailDetail:MailDetail = MailDetail()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mailDetail = Top10HTTPHandler().getMailPost(name, num: num)
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    
    
    @IBAction func repost2345(sender: AnyObject){
        let optionMenu = UIAlertController(title: nil, message: "回复信件",
            preferredStyle: .Alert)
        // Add actions to the menu
        
        var tmp:PstMail = Top10HTTPHandler().getMailRecevier(String(self.mailDetail.n))
        
        optionMenu.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
            textField.text = tmp.recv
        }
        optionMenu.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
            //textField.placeholder = "信件标题"
            textField.text = "Re:" + tmp.title
        }
        
        optionMenu.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
            textField.text = "   "+tmp.text
        }
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        let okAction = UIAlertAction(title: "确定", style: .Default, handler: {(action:UIAlertAction!) -> Void in
            var receiver:UITextField = optionMenu.textFields?.first as! UITextField
            var title:UITextField = optionMenu.textFields?[1] as! UITextField
            var text:UITextField = optionMenu.textFields?.last as! UITextField
            var flag:Bool =  Top10HTTPHandler().postNewMail(receiver.text,title:title.text,text:text.text)
            var res = "失败"
            if (flag){
                res = "成功"
                
                
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath:
            indexPath) as! UITableViewCell
        // Configure the cell...
        cell.textLabel?.text = self.mailDetail.text
        
        return cell
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
