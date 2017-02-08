//
//  UserViewController.swift
//  Winsharesapp
//
//  Created by samson on 29/11/2016.
//  Copyright © 2016 samson. All rights reserved.
//

import UIKit
protocol UserViewInterface: class {
    
    //    func showNoContentScreen()
}

class UserViewController: UIViewController,UserViewInterface {
    
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
        
        self.createHorzMenuListLayout(rootLayout, imagesNameList: ["mycourse","mystore","myhuncunicon"], menuNameList: ["我的课程","我的收藏","我的缓存"], imageHeight: 25,LayoutHeight: 70, action: #selector(self.handleTap(sender:)))
       
        orderTableView = UITableView()
        orderTableView.tg_height.equal(.fill)
        orderTableView.tg_width.equal(.fill)
        orderTableView.tg_top.equal(TGDimeAdapter.height(15))
        orderTableView.backgroundColor = AppPlist.mainViewBgColor
        rootLayout.addSubview(orderTableView)
        
        orderTableView.delegate = self
        orderTableView.dataSource = self
        orderTableView.separatorStyle = .none
        orderTableView.tableHeaderView?.isHidden = true
        orderTableView.tableFooterView?.isHidden = true
        
        orderTableView.register(UserViewCell.self, forCellReuseIdentifier: userViewCellIdentifier)
        

    
    }
    
    var eventHandler : UserModuleInterface?
    var userViewCellIdentifier = "userview_cell"
    
    var orderTableView:UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        if (self.tabBarController?.tabBar.isHidden)! {
           self.tabBarController?.tabBar.isHidden = false
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
//MARK: Layout Construction
extension UserViewController
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

extension UserViewController:UITableViewDelegate,UITableViewDataSource
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
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0{
            return 15
        } else if section == 1 {
            return 15
        }
        return 0

    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        // 注意这里。为了达到动态高度TableViewCell的加载性能最高以及高性能，一定要实现estimatedHeightForRowAtIndexPath这个方法。这个方法用来评估
        //UITableViewCell的高度。如果实现了这个方法，系统会根据数量重复调用这个方法，得出评估的总体高度。然后再根据显示的需要调用heightForRowAtIndexPath方法来确定真实的高度。如果您不实现estimatedHeightForRowAtIndexPath这个方法，加载性能将非常的低下！！！！
        return 50  //这个评估尺寸你可以根据你的cell的一般高度来设置一个最合适的值。
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UserViewCell = tableView.dequeueReusableCell(withIdentifier: userViewCellIdentifier) as! UserViewCell
        if indexPath.section == 0 {
            cell.setModel(infotext: AppPlist.UserViewConfigText.UserViewConfigTextTop[indexPath.row],imageName:AppPlist.UserViewConfigText.UserViewConfigImageNameTop[indexPath.row])
        }else if indexPath.section == 1{
            cell.setModel(infotext: AppPlist.UserViewConfigText.UserViewConfigTextBottom[indexPath.row],imageName:AppPlist.UserViewConfigText.UserViewConfigImageNameBottom[indexPath.row] )
        } else if indexPath.section == 2{
            cell.setModel(infotext: AppPlist.UserViewConfigText.LogoutTextBottom[indexPath.row], imageName: "mysettingicon")
        }
        return cell;
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return AppPlist.UserViewConfigText.UserViewConfigTextTop.count
        }else if section == 1{
            return AppPlist.UserViewConfigText.UserViewConfigTextBottom.count
        }else if section == 2 {
            return AppPlist.UserViewConfigText.LogoutTextBottom.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cell = self.tableView(tableView,cellForRowAt:indexPath) as! UserViewCell
        
    
        let size = cell.rootLayout.tg_sizeThatFits(CGSize(width:tableView.frame.width, height:0))
        return size.height;  //如果使用系统自带的分割线，请返回rect.size.height+1
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        eventHandler?.toNextViewController(sessionIndex:indexPath.section,rowIndex:indexPath.row)
    
        
        
    }

    
}
