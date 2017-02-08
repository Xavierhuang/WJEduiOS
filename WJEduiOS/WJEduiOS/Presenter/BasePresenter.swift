//
//  BasePresenter.swift
//  Winsharesapp
//
//  Created by samson on 3/12/2016.
//  Copyright © 2016 samson. All rights reserved.
//

import Foundation


protocol BaseP {
    func HTTP_Api_Error(msg:String)
    func HTTP_Api_Success(msg:String)
    func HTTP_Api_Success_DataReturn<T: Mapable>(data:Any,type:T.Type)
}

extension BaseP{
   
}
