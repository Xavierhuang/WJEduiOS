//
//  RegisterCodeViewController.swift
//  WJEduiOS
//
//  Created by fengzhongqian123 on 2/7/17.
//  Copyright © 2017 samson. All rights reserved.
//

import UIKit

class RegisterCodeViewController: UIViewController {

    let codeButton = UIButton()
    
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
        
        let passwordTextFeild = UITextField()
        passwordTextFeild.backgroundColor = UIColor.white
        passwordTextFeild.tg_top.equal(20)
        passwordTextFeild.tg_width.equal(.fill)
        passwordTextFeild.tg_height.equal(50)
        passwordTextFeild.placeholder = "输入密码"
        passwordTextFeild.leftViewMode = .always
        let phoneIV = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 50))
        passwordTextFeild.leftView = phoneIV
        rootViewLayout.addSubview(passwordTextFeild)

        let conformTextFeild = UITextField()
        conformTextFeild.backgroundColor = UIColor.white
        conformTextFeild.tg_top.equal(0)
        conformTextFeild.tg_width.equal(.fill)
        conformTextFeild.tg_height.equal(50)
        conformTextFeild.placeholder = "确认密码"
        conformTextFeild.leftViewMode = .always
        let conformView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 50))
        conformTextFeild.leftView = conformView
        rootViewLayout.addSubview(conformTextFeild)

        let codeLayout = TGLinearLayout(.horz)
        codeLayout.backgroundColor = UIColor.white
        codeLayout.tg_top.equal(20)
        codeLayout.tg_width.equal(.fill)
        codeLayout.tg_height.equal(50)
        rootViewLayout.addSubview(codeLayout)
        
        let codeTextFeild = UITextField()
        codeTextFeild.backgroundColor = UIColor.white
        codeTextFeild.tg_width.equal(.fill)
        codeTextFeild.tg_height.equal(.fill)
        codeTextFeild.placeholder = "输入验证码"
        codeTextFeild.leftViewMode = .always
        let codeView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 50))
        codeTextFeild.leftView = codeView
        codeLayout.addSubview(codeTextFeild)
        
        codeButton.tg_right.equal(0)
        codeButton.tg_width.equal(100)
        codeButton.tg_height.equal(.fill)
        codeButton.setTitle("发送验证码", for: .normal)
        codeButton.setTitleColor(UIColor.black, for: .normal)
        codeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        codeButton.addTarget(self, action: #selector(sendCodeClick), for: .touchUpInside)
        codeLayout.addSubview(codeButton)
        
        let nextStepButton = UIButton()
        nextStepButton.tg_top.equal(30)
        nextStepButton.tg_height.equal(50)
        nextStepButton.tg_left.equal((MainBounds.width-300)*0.5)
        nextStepButton.tg_width.equal(300)
        nextStepButton.setTitle("注册", for: .normal)
        nextStepButton.setTitleColor(UIColor.white, for: .normal)
        nextStepButton.setBackgroundImage(UIImage.init(named: "button_bg_bule"), for: .normal)
        nextStepButton.addTarget(self, action: #selector(registerClick), for: .touchUpInside)
        rootViewLayout.addSubview(nextStepButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeBackButton(#selector(self.rightBarButtonAction(_:)), title: "注册",viewController: self)
        WHC_KeyboardManager.share.addMonitorViewController(self)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    //MARK: Action
    func registerClick(sender:UIButton) -> Void {
        NSLog("register")
    }
    
    func sendCodeClick(sender:UIButton) -> Void {
        codeButton.isEnabled = false
        NSLog("send code ")
    }
}

extension RegisterCodeViewController:NavigationP{
    /**
     导航栏右键
     */
    func rightBarButtonAction(_ sender: AnyObject){
        self.navigationController!.popViewController(animated: true)
    }
    
}
