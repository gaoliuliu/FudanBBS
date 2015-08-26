//
//  MyFavouritePostDetailCell.swift
//  FudanBBS_V3
//
//  Created by gaowei on 15/5/23.
//  Copyright (c) 2015年 gaowei. All rights reserved.
//

import UIKit

class MyFavouritePostDetailCell: UITableViewCell,UIWebViewDelegate {
    
    @IBOutlet weak var webview:UIWebView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        //self.tableView.beginUpdates()
        //self.tableView.endUpdates()
        println("test");
    }

}
