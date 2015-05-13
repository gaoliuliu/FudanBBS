//
//  TopDetailTableViewController.swift
//  FudanBBS_V3
//
//  Created by gaowei on 14/12/23.
//  Copyright (c) 2014年 gaowei. All rights reserved.
//

import UIKit

class TopDetailTableViewController: UITableViewController,UITableViewDelegate, UITableViewDataSource {

    var bbs = bbstcon()
    var new1:String! = ""
    var board:String! = ""
    var f:String! = ""
    let handler = Top10HTTPHandler()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 10.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        bbs = handler.getTop10PostPA(new1, board: board, f: f)
        self.setupRefresh()

    }
    
    func setupRefresh(){
        self.tableView.addHeaderWithCallback({
            /*self.fakeData!.removeAllObjects()
            for (var i:Int = 0; i<15; i++) {
                var text:String = "内容"+String( arc4random_uniform(10000))
                self.fakeData!.addObject(text)
            }*/
            var tempbbs = self.handler.getTop10PostPA_PREV(self.new1,bid: self.bbs.bid,gid: self.bbs.gid,fid: self.bbs.fid,a: "p")
            if(tempbbs.paList.count != 0)
            {
                self.bbs = tempbbs
            }
            
            
            
            let delayInSeconds:Int64 =  100000000  * 2
            
            
            var popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds)
            dispatch_after(popTime, dispatch_get_main_queue(), {
                self.tableView.reloadData()
                self.tableView.headerEndRefreshing()
            })
            
        })
        
        
        self.tableView.addFooterWithCallback({
           /* for (var i:Int = 0; i<10; i++) {
                var text:String = "内容"+String( arc4random_uniform(10000))
                
                self.fakeData!.addObject(text)
            }*/
            var tempbbs = self.handler.getTop10PostPA_NEXT(self.new1,bid: self.bbs.bid,gid: self.bbs.gid,fid: self.bbs.fid,a: "n")
            if(tempbbs.paList.count != 0)
            {
                self.bbs = tempbbs
            }
            let delayInSeconds:Int64 = 100000000 * 2
            var popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds)
            dispatch_after(popTime, dispatch_get_main_queue(), {
                self.tableView.reloadData()
                self.tableView.footerEndRefreshing()
                
                //self.tableView.setFooterHidden(true)
            })
        })
    }

    override func viewDidAppear(animated: Bool) {
        //println("reload")

        //self.tableView.reloadData()
        
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
        return bbs.paList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TopDetailTableViewCell
        let top = bbs.paList[indexPath.row]
            //top10s[indexPath.row]
        
        // Configure the cell...
        cell.senderLabel?.text = "发信人： \(top.owner1)"
        cell.titleLabel?.text = "标题： \(top.title)"
        cell.dateLabel?.text = "时间： \(top.date)\n"
        cell.articleLabel?.text = top.pa
        cell.quoteLabel?.text = top.quote
        cell.tailLabel?.text = top.tail
        
        cell.contentView.userInteractionEnabled = true
        
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
