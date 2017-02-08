//
//  SuggestionViewController.swift
//  Winsharesapp
//
//  Created by samson on 29/11/2016.
//  Copyright © 2016 samson. All rights reserved.
//

import UIKit

class SuggestionViewController: UIViewController {
    override func loadView() {
        
        
        let scrollView = UIScrollView()
        self.view = scrollView
        scrollView.backgroundColor = AppPlist.mainViewBgColor
        
        rootLayout = TGLinearLayout(.vert)
        rootLayout.tg_width.equal(.fill)
        rootLayout.tg_height.equal(.wrap)
        rootLayout.tg_height.min(scrollView.tg_height) //默认虽然高度包裹，但是最小的高度要和滚动视图相等。
        rootLayout.tg_vspace = 0
        scrollView.addSubview(rootLayout)
        
        let yhcodeInputField = UITextField()
        //        yhcodeInputField.borderStyle = .none
        //        yhcodeInputField.background = UIImage(named: "vcodefieldbg")
        yhcodeInputField.backgroundColor = .white
        yhcodeInputField.placeholder = NSLocalizedString("感谢您的意见和建议，帮助我们改进产品", comment:"")
        yhcodeInputField.textAlignment = .left
        yhcodeInputField.font = CFTool.fontCustomer(AppPlist.appPingFangRegularFontString, size: 12)
        yhcodeInputField.tg_left.equal(2)
//        yhcodeInputField
        yhcodeInputField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        yhcodeInputField.leftViewMode = .always
        yhcodeInputField.tg_width.equal(.fill)
        yhcodeInputField.tg_top.equal(15)
        yhcodeInputField.tg_height.equal(TGDimeAdapter.height(140))
        rootLayout.addSubview(yhcodeInputField)
        
        
        let toCartViewButton = UIButton()
        toCartViewButton.tg_width.equal(.fill)
        toCartViewButton.tg_height.equal(TGDimeAdapter.height(57))
        toCartViewButton.tg_top.equal(30)
        toCartViewButton.tag = 1002
        toCartViewButton.tg_left.equal(10)
        //toCartViewButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        toCartViewButton.tg_right.equal(10)
        toCartViewButton.setBackgroundImage(UIImage(named:"submitbuttonbg"), for: .normal)
        toCartViewButton.contentMode = UIViewContentMode.scaleToFill
        rootLayout.addSubview(toCartViewButton)
        
        
        
    }
    
    //  var eventHandler : HomeModuleInterface?
    // var topScrollView:UIScrollView?
    var rootLayout : TGLinearLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
        self.changeBackButton(#selector(self.rightBarButtonAction(_:)), title: AppPlist.UserViewConfigText.UserViewConfigTextTop[3],viewController: self)
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
extension SuggestionViewController:NavigationP{
    /**
     导航栏右键
     */
    func rightBarButtonAction(_ sender: AnyObject){
        self.navigationController!.popViewController(animated: true)
    }
    
}
