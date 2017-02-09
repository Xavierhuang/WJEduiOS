//
//  LoginViewController.swift
//  WJEduiOS
//
//  Created by samson on 25/11/2016.
//  Copyright © 2016 samson. All rights reserved.
//

import Foundation
import UIKit

//   VIPER

//mody
//
/*
 * Protocol that defines the view input methods.
 */

let screenHeightScare = UIScreen.main.bounds.height / 1334
let buttonImageArray = ["wechatlogin","qqiconlogin","weiboiconlogin"]


protocol LoginViewInterface: class {
    func showUserDetail(user: User)
//    func showNoContentScreen()
}

class LoginViewController: UIViewController,LoginViewInterface {
   
    // Reference to the Presenter's interface.
    var presenter:LoginModuleInterface!
    
    override func loadView() {
        
        let rootScrollView = UIView()
        self.view = rootScrollView
        rootScrollView.backgroundColor = AppPlist.mainViewBgColor
        
        let rootLayout = TGLinearLayout(.vert)
        rootLayout.backgroundColor = AppPlist.mainViewBgColor
        rootLayout.tg_width.equal(.fill)
        rootLayout.tg_height.equal(.fill)
        rootLayout.tg_height.min(view.tg_height) //默认虽然高度包裹，但是最小的高度要和滚动视图相等。
        rootLayout.tg_vspace = 0
        rootScrollView.addSubview(rootLayout)
        
        let itemLayout = TGLinearLayout(.vert)
        itemLayout.tg_width.equal(.fill)
        itemLayout.tg_height.equal(.wrap)
        itemLayout.tg_top.equal(100)
        rootLayout.addSubview(itemLayout)
        
        let nameLabel = UILabel()
        nameLabel.text = "欢迎登陆伟佳教育"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 28)
        nameLabel.textAlignment = .center
        nameLabel.tg_width.equal(100%)
        //        nameLabel.tg_centerY.equal(0)x
        nameLabel.textColor = AppPlist.userNameColor
        nameLabel.sizeToFit()
        itemLayout.addSubview(nameLabel)
        
        let buttonLayout = TGLinearLayout(.horz)
        buttonLayout.tg_top.equal(20)
        buttonLayout.tg_width.equal(.fill)
        buttonLayout.tg_height.equal(TGDimeAdapter.height(90))
        rootLayout.addSubview(buttonLayout)
        
        for i in 0..<3 {
            let innerButtonLayout = TGLinearLayout(.vert)
            innerButtonLayout.tg_height.equal(90)
            innerButtonLayout.tg_width.equal(TGWeight(100.0/(CGFloat(3))))
            innerButtonLayout.tag = 1000+i
            buttonLayout.addSubview(innerButtonLayout)
            
            let button = UIButton()
            button.tg_top.equal(10)
            button.tg_width.equal(.fill)
            button.tg_height.equal(.fill)
            button.setImage(UIImage.init(named: buttonImageArray[i]), for: .normal)
            button.setTitleColor(AppPlist.userNameColor, for: .normal)
            innerButtonLayout.addSubview(button)
        }
        
        let textFeildLayout = TGLinearLayout(.vert);
        textFeildLayout.tg_top.equal(40)
        textFeildLayout.tg_height.equal(100)
        textFeildLayout.tg_width.equal(.fill)
        rootLayout.addSubview(textFeildLayout)
        
        let accountTextFeild = UITextField()
        accountTextFeild.tg_width.equal(.fill)
        accountTextFeild.tg_height.equal(50)
        accountTextFeild.leftViewMode = .always
        let iconIV = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 15))
        iconIV.image =  UIImage.init(named: "text_icon")
        iconIV.contentMode = .scaleAspectFit
        accountTextFeild.leftView = iconIV
        accountTextFeild.borderStyle = .none;
        accountTextFeild.placeholder = "手机／账号"
        accountTextFeild.backgroundColor = UIColor.white
        
        //text_icon
        textFeildLayout.addSubview(accountTextFeild)
        let passwordTextFeild = UITextField()
        passwordTextFeild.tg_width.equal(.fill)
        passwordTextFeild.tg_height.equal(50)
        let lockIV = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 15))
        lockIV.contentMode = .scaleAspectFit
        lockIV.image =  UIImage.init(named: "text_lock")
        passwordTextFeild.leftView = lockIV
        passwordTextFeild.leftViewMode = .always
        passwordTextFeild.borderStyle = .none;
        passwordTextFeild.placeholder = "密码"
        passwordTextFeild.backgroundColor = UIColor.white
        textFeildLayout.addSubview(passwordTextFeild)
        
        let spacing = (screenBounds.width-300)*0.5
        let logoutButtonLayout = TGLinearLayout(.vert);
        logoutButtonLayout.tg_top.equal(20)
        logoutButtonLayout.tg_height.equal(50)
        logoutButtonLayout.tg_width.equal(.fill)
        rootLayout.addSubview(logoutButtonLayout)
        
        let loginButton = UIButton()
        loginButton.tg_left.equal(spacing)
        loginButton.tg_width.equal(300)
        loginButton.tg_height.equal(50)
        loginButton.setBackgroundImage(UIImage.init(named: "button_bg_bule"), for: .normal)
        loginButton.setTitle("登陆", for: .normal)
        loginButton.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        logoutButtonLayout.addSubview(loginButton)
        
        let twoButtonLayout = TGRelativeLayout();
        twoButtonLayout.tg_top.equal(10)
        twoButtonLayout.tg_height.equal(30)
        twoButtonLayout.tg_width.equal(.fill)
        rootLayout.addSubview(twoButtonLayout)
        
        let forgetPassWordBtn = UIButton()
        forgetPassWordBtn.tg_left.equal(spacing)
        forgetPassWordBtn.tg_width.equal(.wrap)
        forgetPassWordBtn.tg_top.equal(0)
        forgetPassWordBtn.tg_height.equal(30)
        forgetPassWordBtn.setTitle("忘记密码     ", for: .normal)
        forgetPassWordBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        forgetPassWordBtn.setTitleColor(AppPlist.loginTextColor, for: .normal)
        forgetPassWordBtn.addTarget(self, action: #selector(forgetPswClick), for: .touchUpInside)
        twoButtonLayout.addSubview(forgetPassWordBtn)
        
        let registerButton = UIButton()
        registerButton.tg_right.equal(twoButtonLayout.tg_right,offset:spacing)
        registerButton.addTarget(self, action: #selector(registerClick), for: .touchUpInside)
        registerButton.tg_width.equal(.wrap)
        registerButton.tg_top.equal(0)
        registerButton.tg_height.equal(30)
        registerButton.setTitle("     注册", for: .normal)
        registerButton.setTitleColor(AppPlist.loginTextColor, for: .normal)
        registerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        twoButtonLayout.addSubview(registerButton)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.presenter = LoginPresenter()
        self.presenter.updateView()
         WHC_KeyboardManager.share.addMonitorViewController(self)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named:"navbarbg"), for: .default)
        self.navigationController?.navigationBar.barStyle = .blackOpaque
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //跳转时，将导航拦显示
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //隐藏导航栏
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func showUserDetail(user: User) {
        print(user.username ?? "nodata")
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK:Actions
    
    func buttonClick(sender:UIButton)
    {
        
//        let mainTabbarViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainTabbarViewController") as! MainTabbarViewController
//        
//        let window = UIApplication.shared.delegate?.window
//
//        window!!.rootViewController = mainTabbarViewController
        
    
        
        //eventHandler?.toNextViewController(viewTag:sender.tag)
        let appDependencies = AppDependencies()
        TGDimeAdapter.template(CGSize(width: 414, height: 736))
        let window = UIApplication.shared.delegate?.window
        appDependencies.installRootViewControllerIntoWindow(window!!)
    }
    
    func registerClick(sender:UIButton) {
        let registerVC = RegisterViewController.init(nibName:"RegisterViewController",bundle:nil)
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    func forgetPswClick(sender:UIButton) -> Void {
        let forgotPwdVC = ForgetPwdViewController.init(nibName:"ForgetPwdViewController",bundle:nil)
         self.navigationController?.pushViewController(forgotPwdVC, animated: true)
    }
}

