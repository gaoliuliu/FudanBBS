//
//  MyFavouritePostTableViewController.swift
//  FudanBBS_V3
//
//  Created by gaowei on 15/5/23.
//  Copyright (c) 2015年 gaowei. All rights reserved.
//

import UIKit

class MyFavouritePostTableViewController: UITableViewController,UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 373.0
        //self.tableView.rowHeight = UITableViewAutomaticDimension
        //self.tableView.beginUpdates()
        //self.tableView.endUpdates()
        //self.tableView.reloadData()
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
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath:
            indexPath) as! MyFavouritePostDetailCell
        // Configure the cell...
        //cell.textLabel?.text = restaurantNames[indexPath.row]
        var newstring="<po fid='3085791351' owner='WBC'><owner>WBC</owner><nick>邮差只敲两次门</nick><board>Marriage</board><title>Re:&#160;明年生小猴子的问题&#160;好难办</title><date>2015年05月22日11:09:24 星期五</date><pa m='t'><p>跟父母沟通一下实际困难</p><p>生小猴子的事情肯定不会是所有4老的主意</p><p>最多是1-2位的主意,其他人默认</p><p>需要集中做做工作.</p><p>以上是一种细致的做法</p><p><br/></p><p><br/></p><p>另一种简单粗暴的,就扔一句:</p><p>经济基础都还没着落呢,生个毛猴子?</p><p>要么你们自己去生.</p><p><br/></p><p><br/></p><p>说实在的,有的外地父母对孩子施加压力太大</p><p>自己既不能帮孩子安排好工作,有没有路子提前确保落户,更没有立身资助孩子买房</p><p><image>http://ww2.sinaimg.cn/bmiddle/44a47a50jw1eursc9sw4nj218g0xc4bv.jpg</image>凭什么要求孩子按照他们制定的目标实现这个实现那个,</p><p>啥时候结婚啥时候生孩子自己做不了主.</p><p>这点上来看一些上海的父母稍微开明一些,但很容易被传统礼教认为是娇惯溺爱</p><p><br/></p><p><br/></p></pa><pa m='q'><p>【&#160;在&#160;syydxf&#160;(fdsyy)&#160;的大作中提到:&#160;】</p><p>:&#160;我自己很迷茫，就想问下大家的看法参考参考。</p><p>:&#160;楼主今年27，明年硕士毕业，加分专业。现在还在人生第一份实习工作，今年十月份才</p><p>:&#160;到期。明年要是能签到个加分单位的正式工作，落户上海基本没有问题。楼主BF外地户</p><p>:&#160;口，也是明年FD硕士毕业，基本落不了户。两人在沪没房没车没户口，基本就是裸婚，</p><p>:&#160;但是决定留在上海发展。</p><p>:&#160;.................（以下省略）</p></pa><pa m='s'><p>--</p><p>天下事有难易乎？</p><p>为之，则难者亦易矣；</p><p>不为，则易者亦难矣。h</p><p><c h='0' f='37' b='40'></c><c h='1' f='35' b='40'>※&#160;来源:·日月光华&#160;bbs.fudan.edu.cn·[FROM:&#160;175.186.128.*]</c><c h='0' f='37' b='40'></c></p><p><c h='0' f='37' b='40'></c><c h='1' f='36' b='40'>※&#160;修改:·WBC&#160;于&#160;2015年05月22日11:19:45·[FROM:&#160;175.186.128.*]</c><c h='0' f='37' b='40'></c></p></pa></po>"

        let url = NSURL(string: "http://bbs.fudan.edu.cn")
        //let request = NSURLRequest(URL: url!)
        cell.webview.loadHTMLString(newstring, baseURL: url)
        //var height = cell.webview.stringByEvaluatingJavaScriptFromString("document.body.scrollHeight")
        //println(height)
        //self.tableView.reloadData()

        
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
