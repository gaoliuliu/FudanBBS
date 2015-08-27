//
//  DiscussViewController.swift
//  LSFlowView
//
//  Created by  tsou117 on 15/7/7.
//  Copyright (c) 2015年  tsou117. All rights reserved.
//

import UIKit

class DiscussViewController: UIViewController,UIWebViewDelegate {
    
    var url: NSString?
    var mywebview: UIWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mywebview = UIWebView(frame: self.view.bounds)
        mywebview!.delegate = self
        self.view.addSubview(mywebview!)
        
        //request
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        //
        self.title = "加载中..."

        mywebview!.loadRequest(NSURLRequest(URL: NSURL(string: self.url! as String)!))

    }

    //UIWebViewDelegate
    func webViewDidFinishLoad(webView: UIWebView) {
        //
        self.title = webView.stringByEvaluatingJavaScriptFromString("document.title")
        
    }
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        //
        self.title = "错误"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
