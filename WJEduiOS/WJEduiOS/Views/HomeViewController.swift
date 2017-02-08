//
//  HomeViewController.swift
//  Winsharesapp
//
//  Created by samson on 29/11/2016.
//  Copyright © 2016 samson. All rights reserved.
//

import UIKit
import Foundation
import SVProgressHUD

protocol HomeViewInterface: class,BaseViewInterface {
    
}
private let sBaseTag:NSInteger = 100000
class HomeViewController: UIViewController,HomeViewInterface {
    
    
    override func loadView() {
        self.loadHomeView()
    }
    
    var eventHandler : HomeModuleInterface?
    var topScrollView:UIScrollView?
    var topScrollPageControll:UIPageControl?
    var rootLayout : TGLinearLayout!
    let GoodDetailViewControllerSegue = "homeToGoodDetail"
    var timerForlabel: Timer?
    var timeScrollViewBeginScroll:TimeInterval = 2
    var HomeTopImageNameList = ["courseicon","woricon","careericon"]
    var HomeTopTitleList = ["课程","实战","就业"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        SVProgressHUD.show()
//        eventHandler?.loadMainData()
        
        showTopAdData()
        var courseTitleList = ["名师推荐","直播频道","免费好课"]
        for i in 0..<courseTitleList.count{
            let courseTopLayout = createCourseLayout(title: courseTitleList[i],viewTag:i*sBaseTag)
            courseTopLayout.tg_top.equal(20)
            self.rootLayout.addSubview(courseTopLayout)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.isNavigationBarHidden = true
        if (self.tabBarController?.tabBar.isHidden)! {
            self.tabBarController?.tabBar.isHidden = false
        }
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(named:"navbarbg"), for: .default)
        self.navigationController?.navigationBar.barStyle = .blackOpaque
        self.navigationItem.title = "东方在线"
    }
    
}

extension HomeViewController:UIScrollViewDelegate{
    
    func loadHomeView(){
        
        let rootScrollView = UIScrollView()
        self.view = rootScrollView
        rootScrollView.backgroundColor = AppPlist.mainViewBgColor
        
        rootLayout = TGLinearLayout(.vert)
        rootLayout.tg_width.equal(.fill)
        rootLayout.tg_height.equal(.wrap)
        rootLayout.tg_height.min(rootScrollView.tg_height)
        rootLayout.tg_vspace = 0
        rootScrollView.addSubview(rootLayout)
        
        topScrollView = UIScrollView()
        topScrollView?.tg_width.equal(.fill)
        topScrollView?.tg_height.equal(TGDimeAdapter.height(210))
        
        topScrollView?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        topScrollView?.isPagingEnabled = true
        topScrollView?.delegate = self
        rootLayout.addSubview(topScrollView!)
    }
    
    func httpErrorCallback(msg: String) {
        SVProgressHUD.dismiss()
        SVProgressHUD.showInfo(withStatus: msg)
    }
    
    func httpSuccessCallback(msg: String) {
        SVProgressHUD.dismiss()
    }
    
    /**
     * 顶部轮播视图
     * 下面的三个功能模块的按钮
     */

    func showTopAdData() {
        let pointLayout = TGFrameLayout()
        pointLayout.tg_width.equal(.fill)
        pointLayout.tg_height.equal(.wrap)
        pointLayout.tg_height.min(TGDimeAdapter.height(20)) //默认虽然高度包裹，但是最小的高度要和滚动视图相等。
        pointLayout.tg_vspace = 0
    
        topScrollPageControll = UIPageControl()
        topScrollPageControll?.numberOfPages = 4
        topScrollPageControll?.currentPage = 0
        topScrollPageControll?.tg_centerY.equal(0)
        topScrollPageControll?.tg_centerX.equal(0)
        topScrollPageControll?.tintColor = CFTool.color(6)
        NSLog("screenBounds.width === %f", screenBounds.width)
        topScrollView?.contentSize = CGSize(width: screenBounds.width*4, height: TGDimeAdapter.height(210))
        for i in 0 ..< 4
        {
            let image1 = UIImageView(frame: CGRect(x: 0+screenBounds.width*CGFloat(i), y: 0, width: screenBounds.width, height: TGDimeAdapter.height(210)))
            image1.contentMode = UIViewContentMode.scaleAspectFill
            image1.image = UIImage(named: "topscrollimage.png")
//            let url = URL(string: AppConfiguration.WinsharesApp.baseImageUrl+dataArray[0][i].ad_imageurl!)
//            image1.kf.setImage(with: url)
            topScrollView?.addSubview(image1)
        }
        pointLayout.tg_top.equal(TGDimeAdapter.height(-20))
        pointLayout.addSubview(topScrollPageControll!)
        rootLayout.addSubview(pointLayout)
        timerForlabel = Timer.scheduledTimer(timeInterval: timeScrollViewBeginScroll, target: self, selector: #selector(self.countdown(_:)), userInfo: nil, repeats: true)
        
        
        /**
         *  顶部下面的三个按钮控件
         *
         */
        let contentLayout = TGLinearLayout(.horz)
        contentLayout.backgroundColor = .white
        contentLayout.tg_height.equal(TGDimeAdapter.height(90))
        contentLayout.tg_width.equal(.fill)
        //        contentLayout.tg_top.equal(TGDimeAdapter.height(210))
        rootLayout.addSubview(contentLayout)
//        let images = ["thcap","zhekouicon", "couponicon"];
        
        for i in 0 ..< 3
        {
            
            let imageButtonLayout = TGLinearLayout(.vert)
            imageButtonLayout.tg_height.equal(TGDimeAdapter.height(90))
            imageButtonLayout.tg_width.equal(TGWeight(100.0/(CGFloat(3))))
            imageButtonLayout.tag = 1002+i
            imageButtonLayout.tg_setTarget(self, action:#selector(CoursLayoutTap(_:)), for:.touchUpInside)
            imageButtonLayout.tg_highlightedOpacity = 0.3; //设置触摸事件按下时的不透明度，来响应按下状态。
            let imageView = UIImageView(image: UIImage(named: HomeTopImageNameList[i]))
            imageView.contentMode = .center
            imageView.tg_width.equal(30)
            imageView.tg_height.equal(30)
            imageView.tg_centerX.equal(0)
            imageView.tg_top.equal(TGDimeAdapter.height(15))
            
//            let url = URL(string: AppConfiguration.WinsharesApp.baseImageUrl+dataArray[1][i].ad_imageurl!)
//            imageView.kf.setImage(with: url)
            imageView.contentMode = .scaleAspectFit
            
            imageButtonLayout.addSubview(imageView)
            
            let infoLable = UILabel()
            infoLable.text =  HomeTopTitleList[i]
            infoLable.font = CFTool.fontCustomer(AppPlist.appPingFangMediumFontString, size: 13)
            infoLable.textColor = AppPlist.disTributeViewTextDefaultColor
            infoLable.sizeToFit()
            infoLable.tg_top.equal(5)
            infoLable.tg_centerX.equal(0) //水平线性布局通过相对间距来实现左右分开排列。
            imageButtonLayout.addSubview(infoLable)

//          imageButton.setBackgroundImage(UIImage(named: images[i]),for: UIControlState.normal)
            contentLayout.addSubview(imageButtonLayout)
        }
        
    }
    
    /**
     * 教程模块视图，包含了标题，更多标签还有课程的信息
     *
     */
    
    func createCourseLayout(title:String,viewTag:Int) -> TGLinearLayout {
        let rootlayout = TGLinearLayout(.vert)
        rootlayout.tg_width.equal(.fill)
        rootlayout.tg_height.equal(.wrap)
        rootlayout.tg_height.min(TGDimeAdapter.height(280))
        
        let itemTopLayout = TGRelativeLayout()
        itemTopLayout.tg_width.equal(.fill)
        itemTopLayout.tg_height.equal(TGDimeAdapter.height(60))
        itemTopLayout.backgroundColor = .white
        itemTopLayout.tg_setTarget(self, action:#selector(CoursLayoutTap(_:)), for:.touchUpInside)
        itemTopLayout.tg_highlightedOpacity = 0.3; //设置触摸事件按下时的不透明度，来响应按下状态。
        itemTopLayout.tag = 1001
        rootlayout.addSubview(itemTopLayout)
        
        let sectionTitleLabel = UILabel()
        sectionTitleLabel.text = title
        sectionTitleLabel.adjustsFontSizeToFitWidth = true
        sectionTitleLabel.textColor = .black
        sectionTitleLabel.font = UIFont(name: AppPlist.appPingFangMediumFontString, size: 16)
        sectionTitleLabel.minimumScaleFactor = 0.7
        sectionTitleLabel.lineBreakMode = .byTruncatingMiddle
        sectionTitleLabel.tg_centerY.equal(itemTopLayout.tg_centerY)  //垂直居中
        sectionTitleLabel.tg_centerX.equal(itemTopLayout.tg_centerX)
        sectionTitleLabel.tg_left.equal(-10)       //左边和父视图左对齐
        //        sectionTitleLabel.tg_right.equal(imageView.tg_right)                //右边是图标的左边。
        sectionTitleLabel.sizeToFit()
        itemTopLayout.addSubview(sectionTitleLabel)
    
        
        let imageView = UIImageView(image:UIImage(named:"morerighticon"))
        imageView.tg_centerY.equal(itemTopLayout.tg_centerY)  //垂直居中
        imageView.tg_right.equal(itemTopLayout.tg_right,offset:10)      //和父视图右对齐。
        itemTopLayout.addSubview(imageView);

        let bottomScrollView = UIScrollView()
        bottomScrollView.tg_width.equal(.fill)
        bottomScrollView.tg_height.equal(TGDimeAdapter.height(220))
        bottomScrollView.backgroundColor = .white
        bottomScrollView.delegate = self
//        bottomScrollView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        bottomScrollView.contentSize = CGSize(width: 192*5, height: TGDimeAdapter.height(220))
//        bottomScrollView.isPagingEnabled = true
//        bottomScrollView.delegate = self
        rootlayout.addSubview(bottomScrollView)
        
        //创建课程模块信息视图
        for i in 0..<5{
            let view = UIView(frame: CGRect(x: 0+192*CGFloat(i), y: 0, width: 192, height: TGDimeAdapter.height(220)))
            
            let itemCourseLayout = self.createItemCourseLayout(imageName: "coursebg", title: "React Native 贯穿全栈", remark: "让你了解Java实战课程", price: 598.00, marketprice: 598.00,viewtag:viewTag+i, action: #selector(handleCellLayoutTap(_:)))
            view.addSubview(itemCourseLayout)
            bottomScrollView.addSubview(view)
        }
        
        return rootlayout
    }
    
    
    func countdown(_ sender: Any){
        
        var currentPage = self.topScrollPageControll?.currentPage
        var offset = self.topScrollView?.contentOffset
        
        if currentPage! >= (self.topScrollPageControll?.numberOfPages)!-1 {
            currentPage = 0
            offset?.x = 0
        }else{
            currentPage = currentPage! + 1
            offset?.x = (offset?.x)! + (self.topScrollView?.frame.width)!
        }
        
        self.topScrollPageControll?.currentPage = currentPage!
        self.topScrollView?.setContentOffset(offset!, animated: true)
    }
    
    //重置timer和smsVerifyCodeLabel
    func resetSmsVerifyCodeLabelAndTimer(){
        timerForlabel?.invalidate()
        timerForlabel = nil
    }

    func CoursLayoutTap(_ sender:UIView) -> Void {
        switch sender.tag {
        case 1001:
            eventHandler?.toCourseListViewController()
            break
        case 1002:
            // 顶部三个功能按钮 “课程” 按钮点击事件
            let courseTypeVC = CourseTypeViewController()
            self.navigationController?.pushViewController(courseTypeVC, animated: true)
            NSLog("1002")
            break
        case 1003:
             // 顶部三个功能按钮 “实战” 按钮点击事件
            NSLog("1003")
            break
        case 1004:
            // 顶部三个功能按钮 “就业” 按钮点击事件
            NSLog("1004")   
            break
        default:
            break
        }
    }

    //模块课程点击事件执行
    func handleCellLayoutTap(_ sender:UIView) -> Void {
        let supplementaryIndex = sender.tag / sBaseTag
        let cellIndex = sender.tag % sBaseTag
        eventHandler?.toGoodsDetailViewController(modulid:supplementaryIndex,goodsPos:cellIndex)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        resetSmsVerifyCodeLabelAndTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //获取偏移量
        let offset = scrollView.contentOffset
        let currentPage = offset.x / (self.topScrollView?.frame.width)!
        self.topScrollPageControll?.currentPage = Int(currentPage)
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        timerForlabel = Timer.scheduledTimer(timeInterval: timeScrollViewBeginScroll, target: self, selector: #selector(self.countdown(_:)), userInfo: nil, repeats: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == GoodDetailViewControllerSegue{
//            
//            if let desController = segue.destination as? UINavigationController{
//                if let goodsDetailViewController = desController.viewControllers[0] as?     GoodDetailViewController{
//                    goodsDetailViewController.setValue(goodDetailIdSelect, forKey: "goodsIdSelect")
//                }
//            }
//        }
    }
}
