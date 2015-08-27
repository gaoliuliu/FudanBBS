//
//  ViewController.swift
//  LSFlowView
//
//  Created by  tsou117 on 15/7/6.
//  Copyright (c) 2015年  tsou117. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,WaterFlayoutDelegate,LSImgZoomViewDelegate {

    var testImgArr = [Int]()
    var layout: MyLayout?
    var mycollectionview: UICollectionView?
    var imgList :[String!] = []    //var imgSize = [CGSize]()
    //相对位置
    var content_y =  CGFloat()
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "浏览图片"
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Slide)
        // Do any additional setup after loading the view, typically from a nib.
        
        //讨论按钮
        //let rightItem = UIBarButtonItem(title: "讨论", style: UIBarButtonItemStyle.Plain, target: self, action: "actionOfDiscuss")
        //self.navigationItem.rightBarButtonItem = rightItem
        
        //getImgs()
        //println(imgList.count)
        //
        layout = MyLayout()
        layout!.delegate = self
        
        var cellNib:UINib = UINib(nibName: "MyCollectionViewCell", bundle: nil)
        
        //mycollectionview
        mycollectionview = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout!)
        mycollectionview!.delegate = self
        mycollectionview!.dataSource = self
        mycollectionview!.backgroundColor = UIColor.clearColor()
        mycollectionview!.registerNib(cellNib, forCellWithReuseIdentifier: "MyCollectionViewCell")
        self.view.addSubview(mycollectionview!)
        
        
        
        //play
        //print(NSInteger.max)
    }

    //设置测试数据
    func getTestInfo(){
        
        //
        //在取随机14张图片 1~16 包括1 不包括16
        testImgArr = createGenerator(13)(1,16)

        print(testImgArr)

        
    }
    
    //返回一个随机不重复数组
    func createGenerator(count:Int)->(Int,Int)->[Int]{
        
        //http://stackoverflow.com/questions/24270693/nested-recursive-function-in-swift
        var generator:(Int,Int)->[Int] = {_,_ in return []} // give it a no-op definition
        var total = count
        generator = {min,max in
            if (total <= 0 || min>max) {
                return []
            }else{
                total--;
                var random = Int(arc4random_uniform(UInt32(max-min)))
                var mid = min + random
                return [mid]+generator(min, mid-1)+generator(mid+1, max)
            }
        }
        
        return generator
    }
    
    //讨论
    func actionOfDiscuss(){
        var web_vc = DiscussViewController()
        web_vc.url = "http://www.cocoachina.com/bbs/read.php?tid=310092"
        self.navigationController!.pushViewController(web_vc, animated: true)
    }
    func getImgs()
    
    
    {
        imgList.append("http://bbs.fudan.edu.cn/upload/HomeDeco/1440343082-8236.JPG")
        imgList.append("http://bbs.fudan.edu.cn/upload/HomeDeco/1440343091-0141.JPG")
        imgList.append("http://bbs.fudan.edu.cn/upload/HomeDeco/1440343105-1407.JPG")
        imgList.append("http://bbs.fudan.edu.cn/upload/HomeDeco/1440343125-1420.JPG")
        imgList.append("http://bbs.fudan.edu.cn/upload/HomeDeco/1440343134-1371.JPG")
        imgList.append("http://bbs.fudan.edu.cn/upload/HomeDeco/1440343142-8372.JPG")
        imgList.append("http://bbs.fudan.edu.cn/upload/HomeDeco/1440343151-3698.JPG")
        imgList.append("http://bbs.fudan.edu.cn/upload/HomeDeco/1440343165-1434.JPG")
        imgList.append("http://bbs.fudan.edu.cn/upload/HomeDeco/1440343175-3144.JPG")
        imgList.append("http://bbs.fudan.edu.cn/upload/HomeDeco/1440343186-2031.JPG")
        imgList.append("http://bbs.fudan.edu.cn/upload/HomeDeco/1440343195-8326.JPG")
        imgList.append("http://bbs.fudan.edu.cn/upload/HomeDeco/1440343208-9803.JPG")
        imgList.append("http://bbs.fudan.edu.cn/upload/HomeDeco/1440343221-6979.JPG")
        imgList.append("http://bbs.fudan.edu.cn/upload/HomeDeco/1440343247-7523.JPG")
        imgList.append("http://bbs.fudan.edu.cn/upload/HomeDeco/1440343258-1658.JPG")
        imgList.append("http://bbs.fudan.edu.cn/upload/HomeDeco/1440343285-6372.JPG")
        imgList.append("http://bbs.fudan.edu.cn/upload/HomeDeco/1440343295-3207.JPG")
        imgList.append("http://bbs.fudan.edu.cn/upload/HomeDeco/1440343304-7792.JPG")
    
    
    
    
    
    }
    //WaterFlayoutDelegate
    func collectionView(collectionview: UICollectionView, layout: UICollectionViewLayout, indexPath: NSIndexPath) -> CGSize {
        //
        let item_w = (collectionview.frame.size.width-24)*0.5
        
        //对应图片下标
        let imgIndex = imgList[indexPath.row]
        
        //取出当前图片
        let url = NSURL(string: imgIndex)
        
        //UIImage *imagea = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
        //取出当前图片
        let item_img = UIImage(named: "envelope3")
        
        let imgsize = item_img!.size
        let img_h =  (imgsize.height*item_w)/imgsize.width
        
        return CGSizeMake(item_w, img_h)
    }
    
    //UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //
        return imgList.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MyCollectionViewCell", forIndexPath: indexPath) as! MyCollectionViewCell
        
        //对应图片下标
        let imgIndex = imgList[indexPath.row]
        let url = NSURL(string: imgIndex)
        
        //UIImage *imagea = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
        //取出当前图片
        //let item_img = UIImage(data: NSData(contentsOfURL:url!)!)
        
        //cell.imageview.image = item_img
        //cell.imageview.sd_setImageWithURL(url, placeholderImage: nil,options:.SDWebImageCacheMemoryOnly)
        cell.imageview.sd_setImageWithURL(url, placeholderImage: nil, options: SDWebImageOptions.ProgressiveDownload)
        //self.imgSize[indexPath.row] = cell.imageview.image!.size
        return cell
    }
    
    
    
    //UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! MyCollectionViewCell
        cell.imageview.hidden = true
        
        var baseframe = CGRectMake(cell.frame.origin.x, cell.frame.origin.y-content_y, cell.frame.size.width, cell.frame.size.height)
        
        var zoomv = LSImgZoomView(baseframe: baseframe)
        zoomv.delegate = self
        zoomv.setCurrImg(cell.imageview.image!)
        zoomv.show()
        
        zoomv.blockClose = {(done:Bool) -> Void in
            //
            cell.imageview.hidden = false
        }
    }

    //LSImgZoomViewDelegate
    func lsImgZoomView(close: Bool) {
        //
        if (close){
            
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //
        content_y = scrollView.contentOffset.y
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

