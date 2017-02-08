//
//  UIKitExtension.swift
//  Winsharesapp
//
//  Created by samson on 1/12/2016.
//  Copyright © 2016 samson. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

protocol NavigationP {
    func changeBackButton(_ action: Selector, title bartitle:String, viewController:UIViewController)
}
protocol TabIndexClick {
    func tabClickAtIndex(index:Int)
}
protocol TabIndexSelect {
    func tabIndexSelect(index:Int)
}
extension NavigationP {
    
    func changeBackButton(_ action: Selector, title bartitle:String, viewController:UIViewController) {
        viewController.navigationItem.hidesBackButton = true
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"leftbackicon"), style: .plain, target: self, action: action)
        viewController.navigationItem.leftBarButtonItem?.tintColor = .white
    viewController.navigationController?.navigationBar.setBackgroundImage(UIImage(named:"navbarbg"), for: .default)
        viewController.navigationController?.navigationBar.barStyle = .blackOpaque
        viewController.navigationItem.title = bartitle
        }
    
}


extension UIViewController{
   
    //创建单元格容器布局视图，并指定每行的数量。
    func createCellContainerLayout(arrangedCount:NSInteger) -> TGFlowLayout
    {
        let containerLayout = TGFlowLayout(.vert, arrangedCount:arrangedCount)
        containerLayout.tg_height.equal(.wrap)
        containerLayout.tg_averageArrange = true //平均分配里面每个子视图的宽度或者拉伸子视图的宽度以便填充满整个布局。
        containerLayout.tg_hspace = 5
        containerLayout.tg_vspace = 5
        containerLayout.tg_padding = UIEdgeInsetsMake(5, 5, 5, 5)
        
        return containerLayout
    }
    
    
    /**
     * 创建课程列表页面的单个课程信息
     *
     *
     */
    func courseItemLayout(imageName:String, title:String, remark:String, price:Float64,marketprice:Float64,action: Selector) -> TGBaseLayout
    {
        let cellLayout = TGLinearLayout(.vert)
        cellLayout.tg_gravity = TGGravity.horz.fill  //里面所有子视图的宽度都跟父视图保持一致，这样子视图就不需要设置宽度了。
        //       sbv.tg_height.equal(superview.tg_height, multiple:0.5)  //父视图比例方式
        cellLayout.tg_width.equal(50%)
        cellLayout.tg_height.equal(TGDimeAdapter.height(190))
        //        cellLayout.tg_height.min(cellLayout.tg_width, multiple:0.5)
        cellLayout.tg_space = 5  //设置布局视图里面子视图之间的间距为5个点。
        cellLayout.tg_top.equal(TGDimeAdapter.height(10))
        cellLayout.backgroundColor = .white
//        cellLayout.tg_left.equal(TGDimeAdapter.width(tg_left))
        cellLayout.tg_setTarget(self, action:action, for:.touchUpInside)
        cellLayout.tg_highlightedOpacity = 0.3; //设置触摸事件按下时的不透明度，来响应按下状态。
        
        let imageView = UIImageView()
        //        imageView.tg_height.equal(100%)   //图片视图占用剩余的高度。
        imageView.tg_width.equal(100%)
        imageView.tg_height.equal(imageView.tg_width,multiple:100/192)
        cellLayout.addSubview(imageView)
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFill
        //        let url = URL(string: imageUrl)
        //        imageView.kf.setImage(with: url)
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont(name: AppPlist.appPingFangMediumFontString, size: 14)
        titleLabel.textColor = .black
        titleLabel.textAlignment = NSTextAlignment.left
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.tg_top.equal(TGDimeAdapter.height(10))
        titleLabel.sizeToFit()
        titleLabel.tg_left.equal(5)
        cellLayout.addSubview(titleLabel)
        
        let remarkLabel = UILabel()
        remarkLabel.text = remark
        remarkLabel.font = UIFont(name: AppPlist.appPingFangRegularFontString, size: 12)
        remarkLabel.textColor = CFTool.color(4)
        remarkLabel.textAlignment = NSTextAlignment.left
        remarkLabel.adjustsFontSizeToFitWidth = true
        remarkLabel.tg_top.equal(-5)
        remarkLabel.sizeToFit()
        remarkLabel.tg_left.equal(5)
        cellLayout.addSubview(remarkLabel)
        
        let bottomLayout = TGLinearLayout(.horz)
        bottomLayout.tg_width.equal(.fill)
        //       sbv.tg_height.equal(superview.tg_height, multiple:0.5)  //父视图比例方式
        bottomLayout.tg_height.equal(.wrap)
        //        bottomLayout.tg_height.min(cellLayout.tg_width, multiple:0.5)
        bottomLayout.tg_space = 5  //设置布局视图里面子视图之间的间距为5个点。
        bottomLayout.tg_top.equal(-2)
        cellLayout.addSubview(bottomLayout)
        
        let priceLabel = UILabel()
        priceLabel.text = NSString(format: "￥%.02f元", price) as String
        priceLabel.font = UIFont(name: AppPlist.appPingFangRegularFontString, size: 12)
        priceLabel.textColor = .red
        priceLabel.textAlignment = NSTextAlignment.left
        priceLabel.adjustsFontSizeToFitWidth = true
        
        priceLabel.sizeToFit()
        priceLabel.tg_left.equal(2)
        bottomLayout.addSubview(priceLabel)
        
        let marketPriceString = NSString(format: "￥%.02f", marketprice) as String
        let marketPriceLabel = UILabel()
        marketPriceLabel.text = marketPriceString
        marketPriceLabel.font = UIFont(name: AppPlist.appPingFangRegularFontString, size: 12)
        marketPriceLabel.textColor = .black
        marketPriceLabel.textAlignment = NSTextAlignment.left
        marketPriceLabel.adjustsFontSizeToFitWidth = true
        marketPriceLabel.sizeToFit()
        marketPriceLabel.tg_left.equal(4)
        
        let text = NSMutableAttributedString(string: marketPriceString)
        text.addAttribute(NSStrikethroughStyleAttributeName, value: NSUnderlineStyle.styleSingle.rawValue, range: NSMakeRange(0, text.length))
        marketPriceLabel.attributedText = text
        bottomLayout.addSubview(marketPriceLabel)
        
        return cellLayout
    }

    /**
    * 创建首页单个课程视图
    *
    *
    */
    func createItemCourseLayout(imageName:String, title:String, remark:String, price:Float64,marketprice:Float64,viewtag:Int,action: Selector) -> TGBaseLayout
    {
        let cellLayout = TGLinearLayout(.vert)
        cellLayout.tg_gravity = TGGravity.horz.fill  //里面所有子视图的宽度都跟父视图保持一致，这样子视图就不需要设置宽度了。
//       sbv.tg_height.equal(superview.tg_height, multiple:0.5)  //父视图比例方式
        cellLayout.tg_width.equal(192)
        cellLayout.tg_height.equal(TGDimeAdapter.height(210))
//        cellLayout.tg_height.min(cellLayout.tg_width, multiple:0.5)
//        cellLayout.tg_space = 5  //设置布局视图里面子视图之间的间距为5个点。
        cellLayout.tag = viewtag
        cellLayout.tg_setTarget(self, action:action, for:.touchUpInside)
        cellLayout.tg_highlightedOpacity = 0.3; //设置触摸事件按下时的不透明度，来响应按下状态。
        
        let imageView = UIImageView()
//        imageView.tg_height.equal(100%)   //图片视图占用剩余的高度。
        imageView.tg_width.equal(100%)
        imageView.tg_left.equal(TGDimeAdapter.width(15))
        imageView.tg_height.equal(TGDimeAdapter.height(120))
        cellLayout.addSubview(imageView)
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFill
//        let url = URL(string: imageUrl)
//        imageView.kf.setImage(with: url)
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont(name: AppPlist.appPingFangMediumFontString, size: 14)
        titleLabel.textColor = .black
        titleLabel.textAlignment = NSTextAlignment.left
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.tg_top.equal(5)
        titleLabel.sizeToFit()
        titleLabel.tg_left.equal(TGDimeAdapter.width(15))
        cellLayout.addSubview(titleLabel)
        
        let remarkLabel = UILabel()
        remarkLabel.text = remark
        remarkLabel.font = UIFont(name: AppPlist.appPingFangRegularFontString, size: 13)
        remarkLabel.textColor = CFTool.color(4)
        remarkLabel.textAlignment = NSTextAlignment.left
        remarkLabel.adjustsFontSizeToFitWidth = true
        remarkLabel.tg_top.equal(5)
        remarkLabel.sizeToFit()
        remarkLabel.tg_left.equal(TGDimeAdapter.width(15))
        cellLayout.addSubview(remarkLabel)
        
        let bottomLayout = TGLinearLayout(.horz)
        bottomLayout.tg_width.equal(.fill)
        //       sbv.tg_height.equal(superview.tg_height, multiple:0.5)  //父视图比例方式
        bottomLayout.tg_height.equal(.wrap)
//        bottomLayout.tg_height.min(cellLayout.tg_width, multiple:0.5)
        bottomLayout.tg_space = 5  //设置布局视图里面子视图之间的间距为5个点。
        bottomLayout.tg_top.equal(5)
        cellLayout.addSubview(bottomLayout)
        
        let priceLabel = UILabel()
        priceLabel.text = NSString(format: "￥%.02f元", price) as String
        priceLabel.font = UIFont(name: AppPlist.appPingFangRegularFontString, size: 15)
        priceLabel.textColor = .red
        priceLabel.textAlignment = NSTextAlignment.left
        priceLabel.adjustsFontSizeToFitWidth = true
      
        priceLabel.sizeToFit()
        priceLabel.tg_left.equal(TGDimeAdapter.width(10))
        bottomLayout.addSubview(priceLabel)

        let marketPriceString = NSString(format: "￥%.02f", marketprice) as String
        let marketPriceLabel = UILabel()
        marketPriceLabel.text = marketPriceString
        marketPriceLabel.font = UIFont(name: AppPlist.appPingFangRegularFontString, size: 12)
        marketPriceLabel.textColor = .black
        marketPriceLabel.textAlignment = NSTextAlignment.left
        marketPriceLabel.adjustsFontSizeToFitWidth = true
        marketPriceLabel.sizeToFit()
        marketPriceLabel.tg_left.equal(TGDimeAdapter.width(10))
        
        let text = NSMutableAttributedString(string: marketPriceString)
        text.addAttribute(NSStrikethroughStyleAttributeName, value: NSUnderlineStyle.styleSingle.rawValue, range: NSMakeRange(0, text.length))
        marketPriceLabel.attributedText = text
        bottomLayout.addSubview(marketPriceLabel)
        
        return cellLayout
    }
    
    /**
     * 创建联系模块按钮视图
     *
     *
     */
    func createHorzMenuListLayout(_ rootLayout:TGLinearLayout,imagesNameList:[String],menuNameList:[String],imageHeight:CGFloat,LayoutHeight:CGFloat, action: Selector)
    {
        
        let contentLayout = TGFloatLayout(.vert)
        contentLayout.backgroundColor = .white
        contentLayout.tg_height.equal(TGDimeAdapter.height(LayoutHeight))
        contentLayout.tg_left.equal(0)
        contentLayout.tg_right.equal(0)
        contentLayout.tg_padding = UIEdgeInsetsMake(5, 5, 5, 5);
        rootLayout.addSubview(contentLayout)
        
        //        let values = ["140","5","0","0"];
        
        //三个小图标均分宽度。
        for i in 0 ..< imagesNameList.count
        {
            let itemContentLayout = TGFloatLayout(.vert)
            itemContentLayout.backgroundColor = .white
            itemContentLayout.tg_height.equal(TGDimeAdapter.height(LayoutHeight))
            itemContentLayout.tg_width.equal(TGWeight(100.0/(CGFloat(imagesNameList.count-i))))
            
            contentLayout.addSubview(itemContentLayout)
            itemContentLayout.tag = 10001+i
            itemContentLayout.tg_setTarget(self, action:action, for:.touchUpInside)
            itemContentLayout.tg_highlightedOpacity = 0.3; //设置触摸事件按下时的不透明度，来响应按下状态。
            
            let imageView = UIImageView(image:UIImage(named:imagesNameList[i]))
            imageView.contentMode = .center
            imageView.tg_height.equal(imageHeight)
            imageView.tg_width.equal(.fill) //这里三个，第一个占用全部的1/3，第二个占用剩余的1/2，第三个占用剩余的1/1。这样就实现了均分宽度的效果。
            imageView.tg_top.equal(TGDimeAdapter.height(18))
            itemContentLayout.addSubview(imageView)
            
            
            let menuLabel = UILabel()
            menuLabel.text = menuNameList[i];
            menuLabel.textColor = UIColor.black
            menuLabel.textAlignment = .center
            menuLabel.font = UIFont(name: AppPlist.appPingFangMediumFontString, size: 12)
            menuLabel.tg_width.equal(.fill)
            menuLabel.tg_top.equal(TGDimeAdapter.height(5))
            menuLabel.sizeToFit()
            itemContentLayout.addSubview(menuLabel)
            
        }
        
        
        
        
    }

    func createSupplementaryLayout(sectionTitle: String) -> TGRelativeLayout {
        //建立一个相对布局
        let supplementaryLayout = TGRelativeLayout()
        supplementaryLayout.tg_padding = UIEdgeInsetsMake(5, 5, 5, 5)
        supplementaryLayout.tg_height.equal(40)
//        supplementaryLayout.tg_top.equal(10)
        //        supplementaryLayout.tg_boundBorderline = TGLayoutBorderline(color: UIColor.lightGray) //设置底部边界线。
        supplementaryLayout.backgroundColor = .white
        
        let sectionTitleLabel = UILabel()
        sectionTitleLabel.text = sectionTitle
        sectionTitleLabel.adjustsFontSizeToFitWidth = true
        sectionTitleLabel.textColor = .black
        sectionTitleLabel.font = UIFont(name: AppPlist.appPingFangMediumFontString, size: 16)
        sectionTitleLabel.minimumScaleFactor = 0.7
        sectionTitleLabel.lineBreakMode = .byTruncatingMiddle
        sectionTitleLabel.tg_centerY.equal(supplementaryLayout.tg_centerY)  //垂直居中
        sectionTitleLabel.tg_centerX.equal(supplementaryLayout.tg_centerX)
        sectionTitleLabel.tg_left.equal(-10)       //左边和父视图左对齐
        //        sectionTitleLabel.tg_right.equal(imageView.tg_right)                //右边是图标的左边。
        sectionTitleLabel.sizeToFit()
        supplementaryLayout.addSubview(sectionTitleLabel)
        
        let imageView = UIImageView(image:UIImage(named:"downtriangle"))
        imageView.tg_centerY.equal(supplementaryLayout.tg_centerY)  //垂直居中
        imageView.tg_left.equal(sectionTitleLabel.tg_right,offset:5)      //和父视图右对齐。
        supplementaryLayout.addSubview(imageView);
        
        return supplementaryLayout
    }

 
    
//    func createHomeModulLayout(dataArray:[HomeModel],rootLayout:TGLinearLayout,action:Selector, sBaseTag:Int)
//    {
//        let CollerctRootLayout = TGLinearLayout(.vert)
//        CollerctRootLayout.tg_gravity = TGGravity.horz.fill //设置垂直线性布局的水平填充值表明布局视图里面的所有子视图的宽度都和布局视图相等。
//        CollerctRootLayout.tg_width.equal(.fill)
//        CollerctRootLayout.tg_height.equal(.wrap)
//        CollerctRootLayout.tg_top.equal(10)
//        rootLayout.addSubview(CollerctRootLayout)
//        var containerLayouts : [TGFlowLayout]! = [TGFlowLayout]()
//        //        self.containerLayouts = [TGFlowLayout]()
//        
//        for index in 0..<dataArray.count {
//            //添加单元格视图
//            CollerctRootLayout.addSubview(self.createSupplementaryLayout(sectionTitle: dataArray[index].name))
//            let cellContainerLayout = self.createCellContainerLayout(arrangedCount:  2)
//            cellContainerLayout.tg_bottom.equal(10)
//            containerLayouts.append(cellContainerLayout)
//            CollerctRootLayout.addSubview(cellContainerLayout)
//            cellContainerLayout.backgroundColor = .white
//            let cellCount = dataArray[index].goodModelList.count //随机数量，最少8个最多16个
//            for index2 in 0..<cellCount
//            {
//                let cellLayout = self.createCellLayout1(imageUrl:  AppConfiguration.WinsharesApp.baseImageUrl+dataArray[index].goodModelList[index2].original_img, title:dataArray[index].goodModelList[index2].goods_name,remark: dataArray[index].goodModelList[index2].goods_remark, price: dataArray[index].goodModelList[index2].shop_price,marketprice: dataArray[index].goodModelList[index2].market_price, action: action)
//                cellLayout.tag = (sBaseTag * index) + (NSInteger)(index2) //用于确定所在的辅助编号和单元格编号。
//                cellContainerLayout.addSubview(cellLayout)
//            }
//        }
//    }
//    
    
    /**
     * 创建首页单个课程视图
     *
     *
     */
    func createCourseListCellLayout(dataArray:[CourseModel],rootLayout:TGLinearLayout, action:Selector, sBaseTag:Int,moduleid:Int)
    {
        let CollerctRootLayout = TGLinearLayout(.vert)
        CollerctRootLayout.tg_gravity = TGGravity.horz.fill //设置垂直线性布局的水平填充值表明布局视图里面的所有子视图的宽度都和布局视图相等。
        CollerctRootLayout.tg_width.equal(.fill)
        CollerctRootLayout.tg_height.equal(.wrap)
        CollerctRootLayout.tg_top.equal(TGDimeAdapter.height(10))
        CollerctRootLayout.backgroundColor = .white
        rootLayout.addSubview(CollerctRootLayout)
        var containerLayouts : [TGFlowLayout]! = [TGFlowLayout]()
        //        self.containerLayouts = [TGFlowLayout]()
        
        for _ in 0..<1 {
            //添加单元格视图
//            CollerctRootLayout.addSubview(self.createSupplementaryLayout(sectionTitle: dataArray.name))
            let cellContainerLayout = self.createCellContainerLayout(arrangedCount:  2)
            cellContainerLayout.tg_bottom.equal(10)
            containerLayouts.append(cellContainerLayout)
            CollerctRootLayout.addSubview(cellContainerLayout)
            cellContainerLayout.backgroundColor = .white
            let cellCount = dataArray.count //随机数量，最少8个最多16个
            for index2 in 0..<cellCount
            {
                let cellLayout = self.courseItemLayout(imageName: dataArray[index2].imageurl, title: dataArray[index2].title, remark: dataArray[index2].subtitle, price: Float64(dataArray[index2].prize), marketprice: Float64(dataArray[index2].prize), action: action)
                cellLayout.tag = (sBaseTag * moduleid) + (NSInteger)(index2) //用于确定所在的辅助编号和单元格编号。
                cellContainerLayout.addSubview(cellLayout)
            }
        }
    }
//
//    
//    
//    /**
//     *创建商品的条目视图
//     **/
//    func createPayGoodItem(dataUnit:PayViewGoodData) -> TGRelativeLayout {
//        
//        let secRelaLayout = TGRelativeLayout()
//        secRelaLayout.tg_height.equal(TGDimeAdapter.height(80))
//        secRelaLayout.tg_width.equal(.fill)
//        secRelaLayout.backgroundColor  = .white
//        secRelaLayout.tg_bottomBorderline = TGLayoutBorderline(color: AppPlist.lineColor) //设置底部和顶部都有红色的线
//        
//        let imageView =  UIImageView()
//        imageView.tg_centerY.equal(0)
//        imageView.tg_width.equal(TGDimeAdapter.width(60))
//        imageView.tg_height.equal(TGDimeAdapter.width(60))
//        imageView.tg_left.equal(10)
//        let url = URL(string: AppConfiguration.WinsharesApp.baseImageUrl+dataUnit.goods_image)
//        imageView.kf.setImage(with: url)
//        secRelaLayout.addSubview(imageView)
//        
//        
//        
//        let itemLayout1 = TGRelativeLayout()
//        itemLayout1.tg_height.equal(.wrap)
//        itemLayout1.tg_height.min(TGDimeAdapter.height(80))
//        itemLayout1.tg_width.equal(.wrap)
//        itemLayout1.backgroundColor  = .white
//        itemLayout1.tg_left.equal(imageView.tg_right,offset:5)
//        secRelaLayout.addSubview(itemLayout1)
//        
//        let consigneeLabel = UILabel()
//        consigneeLabel.text = dataUnit.goods_name
//        consigneeLabel.font = CFTool.fontCustomer(AppPlist.appPingFangMediumFontString, size: 14)
//        consigneeLabel.textColor = AppPlist.disTributeViewTextDefaultColor
//        consigneeLabel.sizeToFit()
//        consigneeLabel.tg_top.equal(10)
//        consigneeLabel.tg_left.equal(5) //水平线性布局通过相对间距来实现左右分开排列。
//        itemLayout1.addSubview(consigneeLabel)
//        
//        let addressLabel = UILabel()
//        addressLabel.text = dataUnit.goods_remark
//        addressLabel.font = CFTool.fontCustomer(AppPlist.appPingFangMediumFontString, size: 14)
//        addressLabel.textColor = AppPlist.disTributeViewTextDefaultColor
//        addressLabel.sizeToFit()
//        addressLabel.tg_top.equal(consigneeLabel.tg_bottom,offset:10)
//        addressLabel.tg_left.equal(5) //水平线性布局通过相对间距来实现左右分开排列。
//        itemLayout1.addSubview(addressLabel)
//        
//        
//        let itemLayout2 = TGRelativeLayout()
//        itemLayout2.tg_height.equal(.wrap)
//        itemLayout2.tg_height.min(TGDimeAdapter.height(80))
//        itemLayout2.tg_width.equal(.wrap)
//        itemLayout2.backgroundColor  = .white
//        itemLayout2.tg_right.equal(10)
//        secRelaLayout.addSubview(itemLayout2)
//        
//        let priceLabel = UILabel()
//        priceLabel.text =  "￥\(dataUnit.goods_price)元"
//        priceLabel.font = CFTool.fontCustomer(AppPlist.appPingFangMediumFontString, size: 14)
//        priceLabel.textColor = AppPlist.disTributeViewTextDefaultColor
//        priceLabel.sizeToFit()
//        priceLabel.tg_top.equal(10)
//        priceLabel.tg_left.equal(5) //水平线性布局通过相对间距来实现左右分开排列。
//        itemLayout2.addSubview(priceLabel)
//        
//        let goodNumLabel = UILabel()
//        goodNumLabel.text = "x \(dataUnit.goods_num)"
//        goodNumLabel.font = CFTool.fontCustomer(AppPlist.appPingFangMediumFontString, size: 14)
//        goodNumLabel.textColor = AppPlist.disTributeViewTextDefaultColor
//        goodNumLabel.sizeToFit()
//        goodNumLabel.tg_top.equal(priceLabel.tg_bottom,offset:10)
//        goodNumLabel.tg_left.equal(5) //水平线性布局通过相对间距来实现左右分开排列。
//        itemLayout2.addSubview(goodNumLabel)
//        
//        
//        return secRelaLayout
//    }
//    
//    /**
//     *创建地址选择条栏
//     **/
//    
//    
//    func createAddressSelectItem(consignee:String,address:String,mobile:String) -> TGRelativeLayout {
//        let secRelaLayout = TGRelativeLayout()
//        secRelaLayout.tg_height.equal(TGDimeAdapter.height(60))
//        
//        secRelaLayout.tg_width.equal(.fill)
//        secRelaLayout.backgroundColor  = .white
//        secRelaLayout.tg_bottomBorderline = TGLayoutBorderline(color: AppPlist.lineColor) //设置底部和顶部都有红色的线
//        
//        
//        let imageView = UIImageView(image: UIImage(named: "locationIcon"))
//        imageView.tg_centerY.equal(0)
//        imageView.tg_width.equal(15)
//        imageView.tg_height.equal(15)
//        imageView.tg_left.equal(10)
//        secRelaLayout.addSubview(imageView)
//        
//        let itemLayout1 = TGRelativeLayout()
//        itemLayout1.tg_height.equal(.wrap)
//        itemLayout1.tg_height.min(TGDimeAdapter.height(60))
//        itemLayout1.tg_width.equal(.wrap)
//        itemLayout1.backgroundColor  = .white
//        itemLayout1.tg_left.equal(imageView.tg_right,offset:5)
//        secRelaLayout.addSubview(itemLayout1)
//        
//        let consigneeLabel = UILabel()
//        consigneeLabel.text = "收件人：\(consignee)"
//        consigneeLabel.font = CFTool.fontCustomer(AppPlist.appPingFangMediumFontString, size: 14)
//        consigneeLabel.textColor = AppPlist.disTributeViewTextDefaultColor
//        consigneeLabel.sizeToFit()
//        consigneeLabel.tg_top.equal(5)
//        consigneeLabel.tg_left.equal(5) //水平线性布局通过相对间距来实现左右分开排列。
//        itemLayout1.addSubview(consigneeLabel)
//        
//        let addressLabel = UILabel()
//        addressLabel.text = "详细地址：\(address)"
//        addressLabel.font = CFTool.fontCustomer(AppPlist.appPingFangMediumFontString, size: 14)
//        addressLabel.textColor = AppPlist.disTributeViewTextDefaultColor
//        addressLabel.sizeToFit()
//        addressLabel.tg_top.equal(consigneeLabel.tg_bottom,offset:5)
//        addressLabel.tg_left.equal(5) //水平线性布局通过相对间距来实现左右分开排列。
//        itemLayout1.addSubview(addressLabel)
//        
//        
//        let rightImageView = UIImageView(image: UIImage(named: "next"))
//        rightImageView.tg_centerY.equal(0)
//        rightImageView.tg_right.equal(10)
//        secRelaLayout.addSubview(rightImageView)
//        
//        
//        
//        let phoneLabel = UILabel()
//        phoneLabel.text = "\(mobile)"
//        phoneLabel.font = CFTool.fontCustomer(AppPlist.appPingFangMediumFontString, size: 14)
//        phoneLabel.textColor = AppPlist.disTributeViewTextDefaultColor
//        phoneLabel.sizeToFit()
//        phoneLabel.tg_top.equal(5)
//        phoneLabel.tg_right.equal(rightImageView.tg_left,offset:5) //水平线性布局通过相对间距来实现左右分开排列。
//        secRelaLayout.addSubview(phoneLabel)
//        
//        return secRelaLayout;
//    }
//
//    /*
//     *
//     * 创建配送信息的视图
//     */
//    func createLogisticsLayout(shipping_code:String,shipping_name:String,add_time:String) -> TGRelativeLayout {
//        let secRelaLayout = TGRelativeLayout()
//        secRelaLayout.tg_height.equal(TGDimeAdapter.height(60))
//        
//        secRelaLayout.tg_width.equal(.fill)
//        secRelaLayout.backgroundColor  = .white
//        secRelaLayout.tg_bottomBorderline = TGLayoutBorderline(color: AppPlist.lineColor) //设置底部和顶部都有红色的线
//        
//        
//        let imageView = UIImageView(image: UIImage(named: "locationIcon"))
//        imageView.tg_centerY.equal(0)
//        imageView.tg_width.equal(15)
//        imageView.tg_height.equal(15)
//        imageView.tg_left.equal(10)
//        secRelaLayout.addSubview(imageView)
//        
//        let itemLayout1 = TGRelativeLayout()
//        itemLayout1.tg_height.equal(.wrap)
//        itemLayout1.tg_height.min(TGDimeAdapter.height(60))
//        itemLayout1.tg_width.equal(.wrap)
//        itemLayout1.backgroundColor  = .white
//        itemLayout1.tg_left.equal(imageView.tg_right,offset:5)
//        secRelaLayout.addSubview(itemLayout1)
//        
//        let consigneeLabel = UILabel()
//        consigneeLabel.text = "物流单号：\(shipping_code)"
//        consigneeLabel.font = CFTool.fontCustomer(AppPlist.appPingFangMediumFontString, size: 14)
//        consigneeLabel.textColor = AppPlist.disTributeViewTextDefaultColor
//        consigneeLabel.sizeToFit()
//        consigneeLabel.tg_top.equal(5)
//        consigneeLabel.tg_left.equal(5) //水平线性布局通过相对间距来实现左右分开排列。
//        itemLayout1.addSubview(consigneeLabel)
//        
//        let addressLabel = UILabel()
//        addressLabel.text = "物流公司：\(shipping_name)"
//        addressLabel.font = CFTool.fontCustomer(AppPlist.appPingFangMediumFontString, size: 14)
//        addressLabel.textColor = AppPlist.disTributeViewTextDefaultColor
//        addressLabel.sizeToFit()
//        addressLabel.tg_top.equal(consigneeLabel.tg_bottom,offset:5)
//        addressLabel.tg_left.equal(5) //水平线性布局通过相对间距来实现左右分开排列。
//        itemLayout1.addSubview(addressLabel)
//        
//        
//        let rightImageView = UIImageView(image: UIImage(named: "next"))
//        rightImageView.tg_centerY.equal(0)
//        rightImageView.tg_right.equal(10)
//        secRelaLayout.addSubview(rightImageView)
//        
//        
//        
//        let phoneLabel = UILabel()
//        phoneLabel.text = "\(add_time)"
//        phoneLabel.font = CFTool.fontCustomer(AppPlist.appPingFangMediumFontString, size: 14)
//        phoneLabel.textColor = AppPlist.disTributeViewTextDefaultColor
//        phoneLabel.sizeToFit()
//        phoneLabel.tg_top.equal(5)
//        phoneLabel.tg_right.equal(rightImageView.tg_left,offset:5) //水平线性布局通过相对间距来实现左右分开排列。
//        secRelaLayout.addSubview(phoneLabel)
//        
//        return secRelaLayout;
//    }
//    
//    /*
//     *创建横条两个文字的视图，左边标题，右边信息
//     */
//    func createInfoItemLayout(title:String,infotext:String) -> TGLinearLayout {
//        let itemLayoutView = TGLinearLayout(.horz)
//        itemLayoutView.tg_width.equal(.fill);  //设置视图自身的宽度填充父视图的剩余宽度。
//        itemLayoutView.tg_height.equal(TGDimeAdapter.height(45))
//        itemLayoutView.backgroundColor = .white
//        
//        let titleLabel = UILabel()
//        titleLabel.text = title
//        titleLabel.font = CFTool.fontCustomer(AppPlist.appPingFangMediumFontString, size: 14)
//        titleLabel.textColor = .black
//        titleLabel.sizeToFit()
//        titleLabel.tg_centerY.equal(0)
//        titleLabel.tg_left.equal(10) //水平线性布局通过相对间距来实现左右分开排列。
//        itemLayoutView.addSubview(titleLabel)
//        
//        let infoLabel = UILabel()
//        infoLabel.text = infotext
//        infoLabel.font = CFTool.fontCustomer(AppPlist.appPingFangMediumFontString, size: 14)
//        infoLabel.textColor = .black
//        infoLabel.sizeToFit()
//        infoLabel.tg_centerY.equal(0)
//        infoLabel.tg_left.equal(100%) //水平线性布局通过相对间距来实现左右分开排列。
//        infoLabel.tg_right.equal(10)
//        itemLayoutView.addSubview(infoLabel)
//        
//        return itemLayoutView
//        
//    }
//
//    
//
}
//
//extension UIView{
//    /**
//     *创建商品的条目视图
//     **/
//    func createPayGoodItem(dataUnit:PayViewGoodData) -> TGRelativeLayout {
//        
//        let secRelaLayout = TGRelativeLayout()
//        secRelaLayout.tg_height.equal(TGDimeAdapter.height(80))
//        secRelaLayout.tg_width.equal(.fill)
//        secRelaLayout.backgroundColor  = .white
//        secRelaLayout.tg_bottomBorderline = TGLayoutBorderline(color: AppPlist.lineColor) //设置底部和顶部都有红色的线
//        
//        let imageView =  UIImageView()
//        imageView.tg_centerY.equal(0)
//        imageView.tg_width.equal(TGDimeAdapter.width(60))
//        imageView.tg_height.equal(TGDimeAdapter.width(60))
//        imageView.tg_left.equal(10)
//        let url = URL(string: AppConfiguration.WinsharesApp.baseImageUrl+dataUnit.goods_image)
//        imageView.kf.setImage(with: url)
//        secRelaLayout.addSubview(imageView)
//        
//        let itemLayout1 = TGRelativeLayout()
//        itemLayout1.tg_height.equal(.wrap)
//        itemLayout1.tg_height.min(TGDimeAdapter.height(80))
//        itemLayout1.tg_width.equal(.wrap)
//        itemLayout1.backgroundColor  = .white
//        itemLayout1.tg_left.equal(imageView.tg_right,offset:5)
//        secRelaLayout.addSubview(itemLayout1)
//        
//        let consigneeLabel = UILabel()
//        consigneeLabel.text = dataUnit.goods_name
//        consigneeLabel.font = CFTool.fontCustomer(AppPlist.appPingFangMediumFontString, size: 14)
//        consigneeLabel.textColor = AppPlist.disTributeViewTextDefaultColor
//        consigneeLabel.sizeToFit()
//        consigneeLabel.tg_top.equal(10)
//        consigneeLabel.tg_left.equal(5) //水平线性布局通过相对间距来实现左右分开排列。
//        itemLayout1.addSubview(consigneeLabel)
//        
//        let addressLabel = UILabel()
//        addressLabel.text = dataUnit.goods_remark
//        addressLabel.font = CFTool.fontCustomer(AppPlist.appPingFangMediumFontString, size: 14)
//        addressLabel.textColor = AppPlist.disTributeViewTextDefaultColor
//        addressLabel.sizeToFit()
//        addressLabel.tg_top.equal(consigneeLabel.tg_bottom,offset:10)
//        addressLabel.tg_left.equal(5) //水平线性布局通过相对间距来实现左右分开排列。
//        itemLayout1.addSubview(addressLabel)
//        
//        
//        let itemLayout2 = TGRelativeLayout()
//        itemLayout2.tg_height.equal(.wrap)
//        itemLayout2.tg_height.min(TGDimeAdapter.height(80))
//        itemLayout2.tg_width.equal(.wrap)
//        itemLayout2.backgroundColor  = .white
//        itemLayout2.tg_right.equal(10)
//        secRelaLayout.addSubview(itemLayout2)
//        
//        let priceLabel = UILabel()
//        priceLabel.text =  "￥\(dataUnit.goods_price)元"
//        priceLabel.font = CFTool.fontCustomer(AppPlist.appPingFangMediumFontString, size: 14)
//        priceLabel.textColor = AppPlist.disTributeViewTextDefaultColor
//        priceLabel.sizeToFit()
//        priceLabel.tg_top.equal(10)
//        priceLabel.tg_left.equal(5) //水平线性布局通过相对间距来实现左右分开排列。
//        itemLayout2.addSubview(priceLabel)
//        
//        let goodNumLabel = UILabel()
//        goodNumLabel.text = "x \(dataUnit.goods_num)"
//        goodNumLabel.font = CFTool.fontCustomer(AppPlist.appPingFangMediumFontString, size: 14)
//        goodNumLabel.textColor = AppPlist.disTributeViewTextDefaultColor
//        goodNumLabel.sizeToFit()
//        goodNumLabel.tg_top.equal(priceLabel.tg_bottom,offset:10)
//        goodNumLabel.tg_left.equal(5) //水平线性布局通过相对间距来实现左右分开排列。
//        itemLayout2.addSubview(goodNumLabel)
//        
//        return secRelaLayout
//    }
//    
//}

extension UIView{
    /**
     * 创建首页单个课程视图
     *
     *
     */
    func createItemCourseLayout(imageName:String, title:String, remark:String, price:Float64,marketprice:Float64,viewtag:Int,action: Selector) -> TGBaseLayout
    {
        let cellLayout = TGLinearLayout(.vert)
        cellLayout.tg_gravity = TGGravity.horz.fill  //里面所有子视图的宽度都跟父视图保持一致，这样子视图就不需要设置宽度了。
        //       sbv.tg_height.equal(superview.tg_height, multiple:0.5)  //父视图比例方式
        cellLayout.tg_width.equal(192)
        cellLayout.tg_height.equal(TGDimeAdapter.height(210))
        //        cellLayout.tg_height.min(cellLayout.tg_width, multiple:0.5)
        //        cellLayout.tg_space = 5  //设置布局视图里面子视图之间的间距为5个点。
        cellLayout.tag = viewtag
        cellLayout.tg_setTarget(self, action:action, for:.touchUpInside)
        cellLayout.tg_highlightedOpacity = 0.3; //设置触摸事件按下时的不透明度，来响应按下状态。
        
        let imageView = UIImageView()
        //        imageView.tg_height.equal(100%)   //图片视图占用剩余的高度。
        imageView.tg_width.equal(100%)
        imageView.tg_left.equal(TGDimeAdapter.width(15))
        imageView.tg_height.equal(TGDimeAdapter.height(120))
        cellLayout.addSubview(imageView)
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFill
        //        let url = URL(string: imageUrl)
        //        imageView.kf.setImage(with: url)
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont(name: AppPlist.appPingFangMediumFontString, size: 14)
        titleLabel.textColor = .black
        titleLabel.textAlignment = NSTextAlignment.left
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.tg_top.equal(5)
        titleLabel.sizeToFit()
        titleLabel.tg_left.equal(TGDimeAdapter.width(15))
        cellLayout.addSubview(titleLabel)
        
        let remarkLabel = UILabel()
        remarkLabel.text = remark
        remarkLabel.font = UIFont(name: AppPlist.appPingFangRegularFontString, size: 13)
        remarkLabel.textColor = CFTool.color(4)
        remarkLabel.textAlignment = NSTextAlignment.left
        remarkLabel.adjustsFontSizeToFitWidth = true
        remarkLabel.tg_top.equal(5)
        remarkLabel.sizeToFit()
        remarkLabel.tg_left.equal(TGDimeAdapter.width(15))
        cellLayout.addSubview(remarkLabel)
        
        let bottomLayout = TGLinearLayout(.horz)
        bottomLayout.tg_width.equal(.fill)
        //       sbv.tg_height.equal(superview.tg_height, multiple:0.5)  //父视图比例方式
        bottomLayout.tg_height.equal(.wrap)
        //        bottomLayout.tg_height.min(cellLayout.tg_width, multiple:0.5)
        bottomLayout.tg_space = 5  //设置布局视图里面子视图之间的间距为5个点。
        bottomLayout.tg_top.equal(5)
        cellLayout.addSubview(bottomLayout)
        
        let priceLabel = UILabel()
        priceLabel.text = NSString(format: "￥%.02f元", price) as String
        priceLabel.font = UIFont(name: AppPlist.appPingFangRegularFontString, size: 15)
        priceLabel.textColor = .red
        priceLabel.textAlignment = NSTextAlignment.left
        priceLabel.adjustsFontSizeToFitWidth = true
        
        priceLabel.sizeToFit()
        priceLabel.tg_left.equal(TGDimeAdapter.width(10))
        bottomLayout.addSubview(priceLabel)
        
        let marketPriceString = NSString(format: "￥%.02f", marketprice) as String
        let marketPriceLabel = UILabel()
        marketPriceLabel.text = marketPriceString
        marketPriceLabel.font = UIFont(name: AppPlist.appPingFangRegularFontString, size: 12)
        marketPriceLabel.textColor = .black
        marketPriceLabel.textAlignment = NSTextAlignment.left
        marketPriceLabel.adjustsFontSizeToFitWidth = true
        marketPriceLabel.sizeToFit()
        marketPriceLabel.tg_left.equal(TGDimeAdapter.width(10))
        
        let text = NSMutableAttributedString(string: marketPriceString)
        text.addAttribute(NSStrikethroughStyleAttributeName, value: NSUnderlineStyle.styleSingle.rawValue, range: NSMakeRange(0, text.length))
        marketPriceLabel.attributedText = text
        bottomLayout.addSubview(marketPriceLabel)
        
        return cellLayout
    }

}
