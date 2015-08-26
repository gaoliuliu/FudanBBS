//
//  MyFavouriteListTableViewController.swift
//  FudanBBS_V3
//
//  Created by gaowei on 15/5/23.
//  Copyright (c) 2015年 gaowei. All rights reserved.
//

import UIKit

class MyFavouriteListTableViewController: UITableViewController,UITableViewDelegate, UITableViewDataSource {
    var board = ""
    var favoriteNames:[Post] = []
    let handler = Top10HTTPHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteNames = handler.getFavPostList(board)
        self.navigationItem.title = board
        self.setupRefresh()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    

    @IBAction func postNewTip(sender: AnyObject){
        let optionMenu = UIAlertController(title: nil, message: self.board,
            preferredStyle: .Alert)
        // Add actions to the menu
        
        optionMenu.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
            textField.placeholder = "标题"
        }
        optionMenu.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
            textField.placeholder = "正文"
            
        }
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        let okAction = UIAlertAction(title: "确定", style: .Default, handler: {(action:UIAlertAction!) -> Void in
            var title:UITextField = optionMenu.textFields?.first as! UITextField
            var text:UITextField = optionMenu.textFields?.last as! UITextField
            var flag:Bool =  Top10HTTPHandler().postNewPost(self.favoriteNames[0].bid,title:title.text,text:text.text)
            var res = "失败"
            if (flag){
                res = "成功"
                
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

    func setupRefresh(){
        
        self.tableView.addHeaderWithCallback({
            /*self.fakeData!.removeAllObjects()
            for (var i:Int = 0; i<15; i++) {
            var text:String = "内容"+String( arc4random_uniform(10000))
            self.fakeData!.addObject(text)
            }*/
            var tempbbs = self.handler.getFavPostListStart(self.favoriteNames[0].bid,start: self.favoriteNames[0].start+20)
            if(tempbbs.count != 0)
            {
                self.favoriteNames = tempbbs
            }
            
            
            
            let delayInSeconds:Int64 =  100000000  * 2
            
            
            var popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds)
            dispatch_after(popTime, dispatch_get_main_queue(), {
                self.tableView.reloadData()
                self.tableView.headerEndRefreshing()
                self.tableView.setContentOffset(CGPointMake(0,0), animated:false)
            })
            
        })
        
        
        self.tableView.addFooterWithCallback({
            /* for (var i:Int = 0; i<10; i++) {
            var text:String = "内容"+String( arc4random_uniform(10000))
            
            self.fakeData!.addObject(text)
            }*/
             var tempbbs = self.handler.getFavPostListStart(self.favoriteNames[0].bid,start: self.favoriteNames[0].start-20)
            if(tempbbs.count != 0)
            {
                self.favoriteNames = tempbbs
            }
            let delayInSeconds:Int64 = 100000000 * 2
            var popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds)
            dispatch_after(popTime, dispatch_get_main_queue(), {
                self.tableView.reloadData()
                self.tableView.footerEndRefreshing()
                self.tableView.setContentOffset(CGPointMake(0,0), animated:false)
                
                //self.tableView.setFooterHidden(true)
            })
        })

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
        return favoriteNames.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath:
    indexPath) as! UITableViewCell
        // Configure the cell...
        cell.textLabel?.text = favoriteNames[indexPath.row].text
        
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "showPostDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let destinationController = segue.destinationViewController as! TopDetailTableViewController
                
                destinationController.new1 = "1"
                destinationController.board = favoriteNames[indexPath.row].bid
                destinationController.f = favoriteNames[indexPath.row].fid
                destinationController.p = true
                println(destinationController.new1)
                println(destinationController.board)
                println(destinationController.f)
            } }
    }

    

}
