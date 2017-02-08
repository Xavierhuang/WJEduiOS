//
//  HomePresenter.swift
//  Winsharesapp
//
//  Created by samson on 1/12/2016.
//  Copyright © 2016 samson. All rights reserved.
//

import Foundation
protocol HomeModuleInterface:class {
    func loadMainData()
    func toGoodsDetailViewController(modulid:Int, goodsPos:Int)
    func toCourseListViewController()
}
/*
 * Protocol that defines the commands sent from the Interactor to the Presenter.
 */
protocol  HomeInteractorOutput:class,BaseP {
    func returnCourseIdFormSelect(courseId:Int64)
}

class HomePresenter: HomeModuleInterface,HomeInteractorOutput {
    
    weak var view:HomeViewInterface!
    
    // Reference to the Interactor's interface
    var interactor: HomeInteractorInput!
    var mainWireframe : HomeWireframe?
    
    func loadMainData() {
        interactor.loadMainData()
    }
    
    func toCourseListViewController() {
        mainWireframe?.presentCourseListInterfaceFromViewController(self.view as! HomeViewController)
    }
    
    func toGoodsDetailViewController(modulid:Int, goodsPos:Int) {
         interactor.getGoodsIdFormCellClick(modulid: modulid, cellPos: goodsPos)
    }
}

extension HomePresenter{
    
    func HTTP_Api_Error(msg: String) {
        view.httpErrorCallback(msg: msg)
    }
    
    func HTTP_Api_Success(msg: String) {
        view.httpSuccessCallback(msg: msg)
    }
    func HTTP_Api_Success_DataReturn<T: Mapable>(data:Any,type:T.Type) {
//        if type == AdModel.self{
//            view.showTopAdData(dataArray: data as! [[AdModel]])
//        }else if type == PHomeModel.self {
//            view.showHomeModulData(dataArray: data as! [PHomeModel])
//        }
    }
    
    func returnCourseIdFormSelect(courseId:Int64) {
//         goodDetailIdSelect = goodsid
         mainWireframe?.presentCourseDetailInterfaceFromViewController(self.view as! HomeViewController)
    }
}
