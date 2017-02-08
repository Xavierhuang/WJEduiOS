//
//  QesListViewController.swift
//  Winsharesapp
//
//  Created by samson on 29/11/2016.
//  Copyright © 2016 samson. All rights reserved.
//

import UIKit
import WebKit
class QesListViewController: UIViewController,UIWebViewDelegate,WKNavigationDelegate {
    var productUrl:String?{
        didSet{
            showWebView.tg_width.equal(.fill)
            showWebView.tg_height.equal(.fill)
//            webView.tg_width.equal(.fill)
//            webView.tg_height.equal(.fill)
            
            //            showWebView.tg_top.equal(5)
            if(productUrl != nil)
            {
                let urlRequest = URLRequest.init(url: URL(string: productUrl!)!)
                showWebView.loadRequest(urlRequest as URLRequest)
                webView.load(urlRequest as URLRequest)
            }
            rootLayout.addSubview(showWebView)
//            rootLayout.addSubview(webView)
        }
    }
    
    override func loadView() {
        let scrollView = UIScrollView()
        self.view = scrollView
        scrollView.backgroundColor = AppPlist.mainDackViewBgColor
        rootLayout = TGLinearLayout(.vert)
        rootLayout.backgroundColor = AppPlist.mainViewBgColor
        rootLayout.tg_width.equal(.fill)
        rootLayout.tg_height.equal(.wrap)
        rootLayout.tg_height.min(scrollView.tg_height) //默认虽然高度包裹，但是最小的高度要和滚动视图相等。
        rootLayout.tg_vspace = 0
        scrollView.addSubview(rootLayout)
        
    }
    var rootLayout:TGLinearLayout!
    var showWebView = UIWebView()
    var webView = WKWebView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showWebView.delegate = self
        // Do any additional setup after loading the view.
        //将url换成baidu的就可以了
         self.productUrl = AppConfiguration.WinsharesApp.appBaseUrl+(NSString(format: "%@", "prolist") as String)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
         self.changeBackButton(#selector(self.rightBarButtonAction(_:)), title: AppPlist.UserViewConfigText.questListTitleText,viewController: self)
    }

    // MARK: - delegate
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
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
extension QesListViewController:NavigationP{
    /**
     导航栏右键
     */
    func rightBarButtonAction(_ sender: AnyObject){
        self.navigationController!.popViewController(animated: true)
    }
    
}
