//
//  MyLayout.swift
//  LSFlowView
//
//  Created by  tsou117 on 15/7/6.
//  Copyright (c) 2015年  tsou117. All rights reserved.
//

import Foundation
import UIKit


@objc protocol WaterFlayoutDelegate{
    
    func collectionView(collectionview:UICollectionView,layout:UICollectionViewLayout,indexPath:NSIndexPath) ->CGSize
    
}

class MyLayout: UICollectionViewLayout {
    //
    var delegate:WaterFlayoutDelegate?
    
    //
    
    var x = CGFloat()
    var leftY = CGFloat()
    var rightY = CGFloat()
    var YY = CGFloat()
    //
    var itemwidth = CGFloat()
    var center = CGPoint()
    var radius = CGFloat()
    var itemcount = NSInteger()
    let sectionInset = UIEdgeInsets(top: 8,left: 8,bottom: 8,right: 8)
    
    
    override func prepareLayout() {
        //
        super.prepareLayout()
        
        var size = self.collectionView!.frame.size
        self.itemwidth = (size.width-24)/2
        self.delegate = self.collectionView!.delegate as! WaterFlayoutDelegate?      // as WaterFlayoutDelegate 在协议protocol前面需要加上@objc
        
        itemcount = self.collectionView!.numberOfItemsInSection(0)
        center = CGPointMake(size.width*0.5, size.height*0.5)
        radius = min(size.width, size.height)/2.5
        
    }
    
    override func collectionViewContentSize() -> CGSize {
        
        var nowH = leftY > rightY ? leftY : rightY
        
        return CGSizeMake(self.collectionView!.frame.size.width, nowH)
    }
    
    
    func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath,index:NSInteger) -> UICollectionViewLayoutAttributes! {
        //
        var itemsize = self.delegate?.collectionView(self.collectionView!, layout: self, indexPath: indexPath)
        var itemheight = floor(itemsize!.height*itemwidth/itemsize!.width)
        
        var attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        
        var nowindex = index + 1
        
        if (nowindex%2 == 0){
            //
            x += (itemwidth + sectionInset.left)
            rightY += sectionInset.top
            attributes.frame = CGRectMake(x, rightY, itemwidth, itemheight)
            rightY += itemheight
            
        }else if (nowindex%2 == 1){
            //
            x = sectionInset.left
            leftY += sectionInset.top
            attributes.frame = CGRectMake(x, leftY, itemwidth, itemheight)
            leftY += itemheight
        }
    
        return attributes
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        //
        x = 0
        leftY = 0
        rightY = 0
        
        var attributes = NSMutableArray()
        for var i = 0; i<itemcount; ++i{
            var indexpath = NSIndexPath(forItem: i, inSection: 0)
            [attributes .addObject(layoutAttributesForItemAtIndexPath(indexpath, index: i))];
        }
        
        return attributes as [AnyObject]
    }
    
    

    
}