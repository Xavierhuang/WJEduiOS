//
//  AppExtension.swift
//  Winsharesapp
//
//  Created by samson on 1/12/2016.
//  Copyright © 2016 samson. All rights reserved.
//

//
//  Extension.swift
//  HhliOS
//
//  Created by Noverre on 15/11/27.
//  Copyright © 2015年 EnterKey. All rights reserved.
//

import Foundation
import UIKit
//import CryptoSwift

var factorOfDevice = CGFloat(1)
let screenBounds = UIScreen.main.bounds
//var currentUser = UserModel()

let statusBarHeight = UIApplication.shared.statusBarFrame.height

public let NavigationH: CGFloat = 64
public let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.size.width
public let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.size.height
public let MainBounds: CGRect = UIScreen.main.bounds
public var goodDetailIdSelect:Int64 = 0
public func percentWidth(_ width: CGFloat) -> CGFloat{
    return width * screenBounds.width / 414
}

//var currentUser:UserModel? = UserModel()

struct AppPlist {
    
    
    static let mainViewBgColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
    static let mainTabBarBgColor = UIColor(red: 52/255, green: 57/255, blue: 75/255, alpha: 1)
    static let mainDackViewBgColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1)
    static let backButtonTintColor = UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1)
    static let loginTextColor = UIColor(red: 184/255, green: 184/255, blue: 184/255, alpha: 1)
  
    static let mainThemeColor = UIColor(red: 52/255, green: 57/255, blue: 75/255, alpha: 1)
    static let userNameColor = UIColor(red: 163/255, green: 163/255, blue: 170/255, alpha: 1)
    static let lineColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
    
    static let disTributeViewTextDefaultColor = UIColor(red: 70/255, green: 70/255, blue: 70/255, alpha: 1)
    static let disTributeViewButtonDefaultColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
    static let deleteBottomBgColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1)

    static let loginViewBgColor = UIColor(patternImage: UIImage(named: "logobgcolor")!)
    static let genderFontSize = 16 / factorOfDevice

    static var appPingFangRegularFontString = "STHeitiTC-Medium"
    static var appPingFangLightFontString = "STHeitiTC-Light"
    static var appPingFangMediumFontString = "STHeitiTC-Medium"
   
    struct key{
        static let timeline = "GuideViewTimeline"
        static let im = "GuideViewIM"
        static let makeOrder = "GuideViewMakeOrder"
        static let grabOrder = "GuideViewGrabOrder"
        //        static let myAccount = "GuideViewMyAccount"
    }
    
    

    struct UserViewConfigText{
        static let UserViewConfigTextTop = ["优惠券","关于我们","常见问题","意见反馈"]
        static let UserViewConfigImageNameTop = ["mycouponicon","jiaicon","quectionicon","suggestionicon"]
        static let UserViewConfigTextBottom = ["设置"]
        static let LogoutTextBottom = ["退出登陆"]
        static let UserViewConfigImageNameBottom = ["mysettingicon"]
        static let courseDetailTitleText = "课程详情"
        static let myCouponTitleText = "优惠券"
        static let aboutUsTitleText = "关于我们"
        static let questListTitleText = "常见问题"
        static let orderListTitle = "我的订单"

    }

    
    struct CourseTextList{
        static let SessionTitleList = ["第一章  基本工具","第二章  基本工具"]
        static let CourseTitleList = [["1-1  PS之窗口菜单","1-2 PS之视图菜单","1-3 PS之设置图像、画布的大小","1-4 PS之图像的裁剪"],["1-1  PS之窗口菜单","1-2 PS之视图菜单","1-3 PS之设置图像、画布的大小","1-4 PS之图像的裁剪"]]
        static let CourseTimeList = [["11:55","12:32","15:57","12:32"],["11:55","12:32","15:57","12:32"]]
    }

    
    struct TabbarConfigText{
        static let homeText = "东方在线"
        static let discoverText = "创业社区"
        static let myText = "我的"
    }

    static let noUserData = "用户不存在！"
    struct UserLoginViewText{
        static let phoneFormatError = "手机号码格式不正确，请重新输入！"
        static let phoneOrVcodeNeetInput = "手机号码或验证码不能为空"
        static let phoneNeetInput = "请输入手机号码"
        static let getVcodeSuccess = "获取验证码成功！"
        static let netWorkError = "网络错误，请稍后再试！"
        
        static let vcodeExpired = "验证码过期！"
        static let vcodeError = "验证码错误！"
        static let vcodeNoData = "没有验证码数据！"
    
    }

  
    struct OrderViewConfigText{
        static let orderDetailViewTitle = "订单详情"
        static let goodDrawbackViewTitle = "申请退款"
        static let goodCommentViewTitle = "订单评价"
    }

    
    struct CourseDetailTab{
        static let courseDetailTabNameList = ["章节","详情","评论","问答"]
    }
    struct OrderListViewConfigText{
        static let orderListViewTabNameList = ["全部","待付款","待发货","待评价","已完成"]
    }
    struct PayViewConfigText{
        static let viewTitle = "确认支付"
    }
    static let goodDetailTitleText = "商品详情"
    
    
    struct notificationKey {
        static let newMeassageOfSys = "newMeassageOfSys"
    }
}

protocol SonControllerPassParametersToParentController{
    func passAction(_ parameter:AnyObject, sonControllerName:String, parentControllerName:String)
}

enum ScreenType{
    case w414h736
    case w375h667
    case w320h568
}

