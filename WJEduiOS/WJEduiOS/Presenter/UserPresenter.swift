//
//  UserPresenter.swift
//  Winsharesapp
//
//  Created by samson on 15/12/2016.
//  Copyright © 2016 samson. All rights reserved.
//

import Foundation
protocol UserModuleInterface:class {
    func toNextViewController(sessionIndex:Int,rowIndex:Int)
}
/*
 * Protocol that defines the commands sent from the Interactor to the Presenter.
 */
protocol  UserInteractorOutput:class,BaseP {
    //    func returnGoodIdFormSelect(goodsid:Int64)
}

class UserPresenter: UserModuleInterface,UserInteractorOutput {
    
    weak var view:UserViewInterface!
    var mainWireframe : UserWireframe?
    
    func toNextViewController(sessionIndex:Int,rowIndex:Int) {
        mainWireframe?.presentPayInterfaceFromViewController(view as! UserViewController,sessionIndex:sessionIndex,rowIndex:rowIndex)
    }
    
}

extension UserPresenter{
    
    func HTTP_Api_Error(msg: String) {
//        view.httpErrorCallback(msg: msg)
    }
    
    func HTTP_Api_Success(msg: String) {
//        view.httpSuccessCallback(msg: msg)
    }
    func HTTP_Api_Success_DataReturn<T: Mapable>(data:Any,type:T.Type) {
      
    }
    
}

