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

    override func loadView() {
       
        
        let scrollView = UIScrollView()
        self.view = scrollView
        scrollView.backgroundColor = AppPlist.mainViewBgColor
        
        
        rootLayout = TGLinearLayout(.vert)
        rootLayout.tg_width.equal(.fill)
        rootLayout.tg_height.equal(.wrap)
        rootLayout.tg_height.min(scrollView.tg_height)
        rootLayout.tg_vspace = 0
        scrollView.addSubview(rootLayout)
        //
        //
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeBackButton(#selector(self.rightBarButtonAction(_:)), title:"课程" ,viewController: self)
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
