//
//  CourseListViewController.swift
//  WJEduiOS
//
//  Created by samson on 14/1/2017.
//  Copyright © 2017 samson. All rights reserved.
//
import UIKit
protocol CourseListViewInterface: class {
    
    //    func showNoContentScreen()
}

class CourseListViewController: UIViewController,CourseListViewInterface {

   
    var rootLayout : TGLinearLayout!
    
    override func loadView() {
        loadInitView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
        self.changeBackButton(#selector(self.rightBarButtonAction(_:)), title: AppPlist.UserViewConfigText.myCouponTitleText,viewController: self)
        
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
extension CourseListViewController:NavigationP{
    /**
     导航栏右键
     */
    func rightBarButtonAction(_ sender: AnyObject){
        self.navigationController!.popViewController(animated: true)
    }
    
    func loadInitView()  {
        let scrollView = UIScrollView()
        self.view = scrollView
        scrollView.backgroundColor = AppPlist.mainViewBgColor
        
        rootLayout = TGLinearLayout(.vert)
        rootLayout.tg_width.equal(.fill)
        rootLayout.tg_height.equal(.wrap)
        rootLayout.tg_height.min(scrollView.tg_height)
        rootLayout.tg_vspace = 0
        scrollView.addSubview(rootLayout)
        
        
        let imageView = UIImageView()
        //        imageView.tg_height.equal(100%)   //图片视图占用剩余的高度。
        imageView.tg_width.equal(100%)
       
        imageView.tg_height.equal(TGDimeAdapter.height(180))
      
        imageView.image = UIImage(named: "coursebg.png")
        imageView.contentMode = .scaleToFill
        //        let url = URL(string: imageUrl)
        //        imageView.kf.setImage(with: url)

        rootLayout.addSubview(imageView)
        var couresList:[CourseModel] = [CourseModel]()
        for _ in 0..<6
        {
            let courseItemModel = CourseModel()
            courseItemModel.imageurl = "coursebg"
            courseItemModel.title = "React Native 贯穿全栈"
            courseItemModel.subtitle = "让你了解Java实战课程"
            courseItemModel.prize = 598.00
            courseItemModel.viewnum = 5
            couresList.append(courseItemModel)
        }
        
        self.createCourseListCellLayout(dataArray: couresList, rootLayout: self.rootLayout, action: #selector(self.handleCellLayoutTap(_:)), sBaseTag: 1, moduleid: 1)
       
    }
    
    //课程item点击事件执行
    func handleCellLayoutTap(_ sender:UIView)-> Void {
        
    }
}
