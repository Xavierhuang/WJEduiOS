//
//  CourseDetailController.swift
//  WJEduiOS
//
//  Created by fengzhongqian123 on 2/8/17.
//  Copyright © 2017 samson. All rights reserved.
//

import UIKit

class CourseDetailController: UIViewController {
    var rootLayout : TGLinearLayout!
    var eventHandler : UserModuleInterface?
    var userViewCellIdentifier = "userview_cell"
    
    var orderCollectionView:UICollectionView!

    
    override func loadView() {
        
        /**
         *  这个例子用浮动布局来实现各种用户个人信息的页面布局，当然浮动布局不是万能的，这里只是为了强调用浮动布局实现的机制。
         *  在很多界面中，有人诟病用线性布局来实现时会要嵌套很多的子布局，因此在一些场景中其实您不必全部都用线性布局，可以用浮动布局、流式布局或者相对布局来实现一些复杂一点的界面布局。
         */
        let scrollView = UIScrollView()
        self.view = scrollView
        scrollView.backgroundColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1)
        
        let rootLayout = TGLinearLayout(.vert)
        rootLayout.backgroundColor = AppPlist.mainViewBgColor
        
        rootLayout.tg_width.equal(.fill)
        rootLayout.tg_height.equal(.wrap)
        rootLayout.tg_height.min(scrollView.tg_height) //默认虽然高度包裹，但是最小的高度要和滚动视图相等。
        rootLayout.tg_vspace = 0
        scrollView.addSubview(rootLayout)
        
        //Create Second User Profile type.
        self.createUserProfile2Layout(rootLayout)
        
        self.createHorzMenuListLayout(rootLayout, imagesNameList: ["mycourse","mystore","myhuncunicon"], menuNameList: ["全部","基础","案例"], imageHeight: 25,LayoutHeight: 70, action: #selector(self.handleTap(sender:)))
        
        let layoutView =  UICollectionViewLayout.init()
        orderCollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layoutView)
        orderCollectionView.tg_height.equal(.fill)
        orderCollectionView.tg_width.equal(.fill)
        orderCollectionView.tg_top.equal(TGDimeAdapter.height(15))
        orderCollectionView.backgroundColor = AppPlist.mainViewBgColor
        rootLayout.addSubview(orderCollectionView)
        orderCollectionView.delegate = self
        orderCollectionView.dataSource = self
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeBackButton(#selector(self.rightBarButtonAction(_:)), title:"课程" ,viewController: self)
        orderCollectionView .register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CourseDetailController:NavigationP{
    /**
     导航栏右键
     */
    func rightBarButtonAction(_ sender: AnyObject){
        self.navigationController!.popViewController(animated: true)
    }
}

extension CourseDetailController
{
    
    /**
     * 用户界面的顶部视图
     *
     *
     */
    func createUserProfile2Layout(_ rootLayout:TGLinearLayout)
    {
        //浮动布局的一个缺点是居中对齐难以实现，所以这里需要对子视图做一些特殊处理。
        
        let contentLayout = TGLinearLayout(.horz)
        contentLayout.backgroundColor = AppPlist.mainThemeColor
        contentLayout.tg_height.equal(TGDimeAdapter.height(205))
        contentLayout.tg_left.equal(0)
        contentLayout.tg_right.equal(0)
        rootLayout.addSubview(contentLayout)
        
        let contentLeftLayout = TGLinearLayout(.horz)
        contentLeftLayout.tg_width.equal(100)
        contentLeftLayout.tg_height.equal(TGDimeAdapter.height(205))
        contentLeftLayout.tg_right.equal(0)
        contentLayout.addSubview(contentLeftLayout)
        
        let headImageView = UIImageView(image:UIImage(named:"nouserheadimg"))
        headImageView.contentMode = .center
        headImageView.tg_width.equal(70) //占据全部宽度。
        headImageView.tg_height.equal(70)
        headImageView.tg_left.equal(30)
        headImageView.tg_centerY.equal(0)
        
        headImageView.layer.masksToBounds = true
        headImageView.layer.cornerRadius = 35.0
        
        headImageView.contentMode = .scaleAspectFill
        contentLeftLayout.addSubview(headImageView)
        
        
        let contentRightLayout = TGLinearLayout(.horz)
        contentRightLayout.tg_width.equal(.fill)
        contentRightLayout.tg_height.equal(TGDimeAdapter.height(205))
        contentRightLayout.tg_right.equal(0)
        contentLayout.addSubview(contentRightLayout)
        
        let itemLayout = TGLinearLayout(.vert)
        itemLayout.tg_width.equal(.fill)
        itemLayout.tg_height.equal(.wrap)
        itemLayout.tg_centerY.equal(0)
        itemLayout.tg_left.equal(15)
        contentRightLayout.addSubview(itemLayout)
        
        let nameLabel = UILabel()
        nameLabel.text = "罗迪尔"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        nameLabel.textAlignment = .left
        nameLabel.tg_width.equal(100%)
        //        nameLabel.tg_centerY.equal(0)
        nameLabel.textColor = AppPlist.userNameColor
        nameLabel.sizeToFit()
        itemLayout.addSubview(nameLabel)
        
        let remarkLabel = UILabel()
        remarkLabel.text = "天道酬勤，继续努力"
        remarkLabel.font = UIFont.boldSystemFont(ofSize: 14)
        remarkLabel.textAlignment = .left
        remarkLabel.tg_top.equal(18)
        remarkLabel.tg_width.equal(100%)
        remarkLabel.textColor = AppPlist.userNameColor
        remarkLabel.sizeToFit()
        itemLayout.addSubview(remarkLabel)
    }
    
}

extension CourseDetailController:UICollectionViewDelegate,UICollectionViewDataSource
{
    
    func handleTap(sender:TGBaseLayout)
    {
        print(sender.tag)
        //        eventHandler?.toNextViewController(viewTag:sender.tag)
    }
    
    func handleTapSegue(sender:TGBaseLayout,Identifier identifier:String)
    {
        
    }
    
    func orderTypeTab(sender:TGBaseLayout)
    {
        print(sender.tag)
        //        eventHandler?.toNextViewController(viewTag:sender.tag)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)
        return cell
    }
    
    
    
}

