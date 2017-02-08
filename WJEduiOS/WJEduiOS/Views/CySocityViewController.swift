//
//  CySocityViewController.swift
//  WJEduiOS
//
//  Created by samson on 1/1/2017.
//  Copyright © 2017 samson. All rights reserved.
//

import UIKit
import Foundation
import SVProgressHUD

protocol CySocityViewInterface: class,BaseViewInterface {
    
}
class CySocityViewController: UIViewController {

    override func loadView() {
        loadMainView()
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
        if (self.tabBarController?.tabBar.isHidden)! {
            self.tabBarController?.tabBar.isHidden = false
        }
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named:"navbarbg"), for: .default)
        self.navigationController?.navigationBar.barStyle = .blackOpaque
        self.navigationItem.title = "创客社区"
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

extension CySocityViewController:CySocityViewInterface{
    
    func httpErrorCallback(msg: String) {
        SVProgressHUD.dismiss()
        SVProgressHUD.showInfo(withStatus: msg)
    }
    
    func httpSuccessCallback(msg: String) {
        SVProgressHUD.dismiss()
    }
    
    func loadMainView(){
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
        self.createTopLayout(rootLayout)

        self.createHorzMenuListLayout(rootLayout, imagesNameList: ["cktranningicon","ckrateing"], menuNameList: ["创客训练营","创客大赛"], imageHeight: 32,LayoutHeight: 100, action: #selector(self.handleTap(sender:)))
        
        self.createArticleInfoLayout(rootLayout, imageName: "topscrollimage", title: "上期创客训练营精彩回顾", subtitle: "最快的方式，让你了解Java")
        
        self.createArticleInfoLayout(rootLayout, imageName: "topscrollimage", title: "深圳南山区创业大赛正式落幕", subtitle: "下期的精彩内容，敬请期待")
    }
    
    func handleTap(sender:TGBaseLayout)
    {
       
    }
    /**
     * 顶部方块视图
     *
     *
     */
    func createTopLayout(_ rootLayout:TGLinearLayout)
    {
        //浮动布局的一个缺点是居中对齐难以实现，所以这里需要对子视图做一些特殊处理。
        
        let contentLayout = TGLinearLayout(.horz)
        contentLayout.backgroundColor = AppPlist.mainThemeColor
        contentLayout.tg_height.equal(TGDimeAdapter.height(228))
        contentLayout.tg_left.equal(0)
        contentLayout.tg_right.equal(0)
        rootLayout.addSubview(contentLayout)
        
        let imageView = UIImageView(image: UIImage(named: "950"))
        //        imageView.tg_height.equal(100%)   //图片视图占用剩余的高度。
        imageView.tg_width.equal(.fill)
        imageView.tg_height.equal(.fill)
        contentLayout.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
    }

    /**
     * 文章内容区块视图
     *
     *
     */
    func createArticleInfoLayout(_ rootLayout:TGLinearLayout,imageName:String,title:String,subtitle:String)
    {
        
        let contentLayout = TGLinearLayout(.vert)
        contentLayout.backgroundColor = .white
        contentLayout.tg_height.equal(TGDimeAdapter.height(240))
        contentLayout.tg_left.equal(0)
        contentLayout.tg_right.equal(0)
        contentLayout.tg_top.equal(10)
        rootLayout.addSubview(contentLayout)
        
        let imageView = UIImageView()
        //        imageView.tg_height.equal(100%)   //图片视图占用剩余的高度。
        imageView.tg_width.equal(100%)
        imageView.tg_height.equal(.wrap)
        imageView.tg_left.equal(10)
        imageView.tg_top.equal(10)
        imageView.tg_right.equal(10)
        contentLayout.addSubview(imageView)
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFill
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont(name: AppPlist.appPingFangMediumFontString, size: 13)
        titleLabel.textColor = .black
        titleLabel.textAlignment = NSTextAlignment.left
        titleLabel.adjustsFontSizeToFitWidth = true
        
        titleLabel.sizeToFit()
        titleLabel.tg_left.equal(5)
        titleLabel.tg_top.equal(10)
        contentLayout.addSubview(titleLabel)
        
        let remarkLabel = UILabel()
        remarkLabel.text = subtitle
        remarkLabel.font = UIFont(name: AppPlist.appPingFangRegularFontString, size: 10)
        remarkLabel.textColor = CFTool.color(4)
        remarkLabel.textAlignment = NSTextAlignment.left
        remarkLabel.adjustsFontSizeToFitWidth = true
        remarkLabel.tg_top.equal(5)
        remarkLabel.sizeToFit()
        remarkLabel.tg_left.equal(5)
        contentLayout.addSubview(remarkLabel)


    }
    
}
