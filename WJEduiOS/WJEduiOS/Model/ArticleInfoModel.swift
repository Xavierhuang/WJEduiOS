//
//  ArticleInfoModel.swift
//  WJEduiOS
//
//  Created by samson on 15/1/2017.
//  Copyright © 2017 samson. All rights reserved.
//

import Foundation
import SwiftyJSON
class ArticleInfoModel: NSObject, Mapable {
    var title: String = ""                       //微信openid
    var subtitle: String  = ""                         //用户ID
    var imageurl: String = ""
    required init?(jsonData: JSON) {
        self.title = jsonData["title"].string!
        self.imageurl = jsonData["imageurl"].string!
        self.subtitle = jsonData["subtitle"].string!
    }
    
    override init() {
        super.init()
    }
}
