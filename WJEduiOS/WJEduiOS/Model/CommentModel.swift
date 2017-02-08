//
//  CommentModel.swift
//  WJEduiOS
//
//  Created by samson on 25/1/2017.
//  Copyright © 2017 samson. All rights reserved.
//

import Foundation
import SwiftyJSON
class CommentModel: NSObject, Mapable {
    var userAvaterImageName: String = ""                       //微信openid
    var userName: String  = ""                         //用户ID
    var likeNum: Int = 0                       //邮箱
    var likeIconImageName: String = ""                            //手机
    var timeStreing: String = ""
    var commentString: String = ""
    required init?(jsonData: JSON) {
        self.userAvaterImageName = jsonData["userAvaterImageName"].string!
        self.userName = jsonData["userName"].string!
        self.likeIconImageName = jsonData["likeIconImageName"].string!
        self.timeStreing = jsonData["timeStreing"].string!
        self.commentString = jsonData["commentString"].string!
        self.likeNum = jsonData["likeNum"].int!
    }
    
    override init() {
        super.init()
    }
}
