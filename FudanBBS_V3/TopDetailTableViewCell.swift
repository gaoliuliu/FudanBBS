//
//  TopDetailTableViewCell.swift
//  FudanBBS_V3
//
//  Created by gaowei on 14/12/23.
//  Copyright (c) 2014年 gaowei. All rights reserved.
//

import UIKit

class TopDetailTableViewCell: UITableViewCell {

    
    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var articleLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var tailLabel: UILabel!
    @IBOutlet weak var reButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //println("cell reload")
        //self.reloadInputViews()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//println("回复")
        // Configure the view for the selected state
    }
    
    @IBAction func repost2345(sender: AnyObject){
        println("回复")
    }

}
