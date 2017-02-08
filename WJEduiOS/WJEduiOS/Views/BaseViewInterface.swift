//
//  BaseViewInterface.swift
//  Winsharesapp
//
//  Created by samson on 5/12/2016.
//  Copyright © 2016 samson. All rights reserved.
//

import Foundation

protocol BaseViewInterface {
    func httpSuccessCallback(msg:String)
    func httpErrorCallback(msg:String)
}
