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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 30.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        let handler = Top10HTTPHandler()
        bbs = handler.getTop10PostPA(new1, board: board, f: f)
        

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
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as TopDetailTableViewCell
        let top = bbs.paList[indexPath.row]
            //top10s[indexPath.row]
        
        // Configure the cell...
        cell.senderLabel?.text = "发信人： \(top.owner1)"
        cell.titleLabel?.text = "标题： \(top.title)"
        cell.dateLabel?.text = "时间： \(top.date)\n"
        cell.articleLabel?.text = top.pa
        cell.quoteLabel?.text = top.quote
        cell.tailLabel?.text = top.tail
        
     /*   var artCGrec = cell.articleLabel.frame
        println(artCGrec.minX)
        println(artCGrec.minY)
        println(artCGrec.maxX)
        println(artCGrec.maxY)
        println("原始高度：\(artCGrec.height)")
        println("原始宽度：\(artCGrec.width)")
        */
        //cell.articleLabel.sizeToFit()
        
        //println(artCGrec.minX)
        //println(artCGrec.minY)
        //println(artCGrec.height)
        //println(artCGrec.width)
       
        //var size:CGSize =
        //cell.articleLabel.sizeThatFits(<#size: CGSize#>)
        
        
     /*   var test: NSString  = top.pa
        
       var font:UIFont = UIFont(name: "Arial", size:12)!
       var size: CGSize = CGSizeMake(300,2000)
        var artSizeRec = test.boundingRectWithSize(size, options:NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:font] ,context: nil)
          println(artSizeRec.height)
          println(artSizeRec.width)
        
        cell.articleLabel.sizeThatFits(CGSizeMake(artSizeRec.width, artSizeRec.height))
        cell.articleLabel.sizeToFit()
        //cell.sizeThatFits(CGSizeMake(300, cell.frame.height+100))
        //cell.sizeToFit()
        
        println("更新高度：\(cell.articleLabel.frame.height)")
        println("更新宽度：\(cell.articleLabel.frame.width)")
        println(cell.articleLabel.frame.minX)
        println(cell.articleLabel.frame.minY)
        println(cell.articleLabel.frame.maxX)
        println(cell.articleLabel.frame.maxY)
        //var artSizeRec2 =test.boundingRectWithSize(<#size: CGSize#>, options: .NSStringDrawingUsesLineFragmentOrigin, attributes: <#[NSObject : AnyObject]!#>, context: <#NSStringDrawingContext!#>)
        //var artSize: CGSize = test.sizeWithAttributes(attrs:[font:font,size:size,lineBreakMode:UILineBreadMode])
        
       // sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap
      //  println(artLabelSize.height)
      //  println(artLabelSize.width)
        */
        cell.contentView.userInteractionEnabled = true
        //cell.userInteractionEnabled = true
        //cell.reButton.userInteractionEnabled = true
        //cell.reButton.addTarget(<#target: AnyObject?#>, action: //, forControlEvents: <#UIControlEvents#>)
        //cell.contentView.addSubview(cell.reButton)
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
