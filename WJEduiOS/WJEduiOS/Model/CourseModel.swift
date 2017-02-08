//
//  CourseModel.swift
//  WJEduiOS
//
//  Created by samson on 14/1/2017.
//  Copyright © 2017 samson. All rights reserved.
//

import Foundation
import SwiftyJSON
class CourseModel: NSObject, Mapable {
    var title: String = ""                       //微信openid
    var subtitle: String  = ""                         //用户ID
    var prize: Float = 0.00                         //邮箱
    var viewnum: Int = 0                          //手机
    var imageurl: String = ""
    required init?(jsonData: JSON) {
        self.title = jsonData["title"].string!
        self.imageurl = jsonData["imageurl"].string!
        self.subtitle = jsonData["subtitle"].string!
        self.prize = jsonData["prize"].floatValue
        self.viewnum = jsonData["viewnum"].int!
        
    }
    
    override init() {
        super.init()
    }
}
