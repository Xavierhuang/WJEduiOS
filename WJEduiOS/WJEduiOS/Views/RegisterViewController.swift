//
//  RegisterViewController.swift
//  WJEduiOS
//
//  Created by fengzhongqian123 on 2/7/17.
//  Copyright © 2017 samson. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    override func loadView() {
        
        let rootScrollView = UIScrollView()
        self.view = rootScrollView
        rootScrollView.backgroundColor = AppPlist.mainViewBgColor
        
        let rootViewLayout = TGLinearLayout(.vert)
        rootViewLayout.tg_width.equal(.fill)
        rootViewLayout.tg_height.equal(.fill)
        rootViewLayout.tg_height.min(view.tg_height) //默认虽然高度包裹，但是最小的高度要和滚动视图相等。
        rootViewLayout.tg_vspace = 0
        rootScrollView.addSubview(rootViewLayout)
        
        let registerTextFeild = UITextField()
        registerTextFeild.backgroundColor = UIColor.white
        registerTextFeild.tg_top.equal(20)
        registerTextFeild.tg_width.equal(.fill)
        registerTextFeild.tg_height.equal(50)
        registerTextFeild.placeholder = "输入手机号"
        registerTextFeild.leftViewMode = .always
        let phoneIV = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 15))
        phoneIV.contentMode = .scaleAspectFit
        phoneIV.image = UIImage.init(named: "text_phone")
        registerTextFeild.leftView = phoneIV
        rootViewLayout.addSubview(registerTextFeild)
        
        
        let nextStepButton = UIButton()
        nextStepButton.tg_top.equal(30)
        nextStepButton.tg_height.equal(50)
        nextStepButton.tg_left.equal((MainBounds.width-300)*0.5)
        nextStepButton.tg_width.equal(300)
        nextStepButton.setTitle("下一步", for: .normal)
        nextStepButton.setTitleColor(UIColor.white, for: .normal)
        nextStepButton.setBackgroundImage(UIImage.init(named: "button_bg_bule"), for: .normal)
        nextStepButton.addTarget(self, action: #selector(nextStepClick), for: .touchUpInside)
        rootViewLayout.addSubview(nextStepButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WHC_KeyboardManager.share.addMonitorViewController(self)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.changeBackButton(#selector(self.rightBarButtonAction(_:)), title: "注册",viewController: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:Actions
    func nextStepClick(sender:UIButton) {
        let registerCodeViewController = RegisterCodeViewController.init(nibName:"RegisterCodeViewController" ,bundle:nil)
        self.navigationController?.pushViewController(registerCodeViewController, animated: true)
        NSLog("click")
    }

}

extension RegisterViewController:NavigationP{
    /**
     导航栏右键
     */
    func rightBarButtonAction(_ sender: AnyObject){
        self.navigationController!.popViewController(animated: true)
    }
    
}



