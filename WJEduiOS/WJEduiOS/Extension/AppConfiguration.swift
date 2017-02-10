//
//  AppConfiguration.swift
//  Winsharesapp
//
//  Created by samson on 1/12/2016.
//  Copyright © 2016 samson. All rights reserved.
//

import Foundation

struct AppConfiguration {
    struct WXShare {
        static let AppId = "wxe01b724d893262bd"
        static let AppSecret = "910db17db91c1fb3c863ef9d579c5212"
    }
    
    
    struct QQShare {
        static var AppId = "1105088820"
        static var AppSecret = "JK7xzerbrrD6TfDU"
    }
    
    struct WXPay {
        static let AppId = "wxe01b724d893262bd"
        static let AppSecret = "910db17db91c1fb3c863ef9d579c5212"
        static let parnnerId = "1311884501"
        static let WXPartnerKey = "213FDFdd899920030333UH76SE9825JH"
        static let wechat_notifyUrl = "http://api.hhl.enterkey.com.cn/pay/wechat/notify.php"
        
    }
    
    struct AliPay {
        static let alipay_notifyUrl = "http://api.hhl.enterkey.com.cn/pay/aliwap/notify.php"
    }
    
    struct CrashReporter {
        static let AppId = "900016505"
    }
    
    struct UMessage {
        static let AppKey = "568e61c767e58ebe1a000a05"
    }
    
    struct MobClick {
        static let AppKey = "56efcd9367e58ea59e001862"
    }
    
    struct YWIM {
        static let Appkey = "23266647"
    }
    
    struct WinsharesApp {
        static let serviceBaseUrl = "http://47.90.92.155"//"https://api.winshares.cn/api/"
        static let desKey = "api.winshares.cn/pego?#@"
        static let baseImageUrl = "http://qapi.winshares.cn/"
        static let appBaseUrl = "http://m.winshares.cn/app.html?#/"
        static let goodDetaiBaseUrl = appBaseUrl+"goodsdetail/"
        static let invitationUrl = "http://api.hhl.enterkey.com.cn/share/Invitation.php"
        static let shareUrl = "http://api.hhl.enterkey.com.cn/share/shareinfo.php?momentid="
    }
    
}
