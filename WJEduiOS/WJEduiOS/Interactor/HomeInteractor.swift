//
//  HomeInteractor.swift
//  Winsharesapp
//
//  Created by samson on 1/12/2016.
//  Copyright © 2016 samson. All rights reserved.
//

import RxSwift
import RxCocoa
import Moya
import SwiftyJSON
/*
 * Protocol that defines the Interactor's use case.
 */
protocol HomeInteractorInput: class {
    func loadMainData()
    func getGoodsIdFormCellClick(modulid:Int,cellPos:Int)
}

/*
 * The Interactor responsible for implementing
 * the business logic of the module.
 */
class HomeInteractor : HomeInteractorInput
{
    internal func loadMainData() {
        
    }

    
    
    // Reference to the Presenter's output interface.
    weak var output: HomeInteractorOutput!
    private var disposeBag = DisposeBag()
//    private var homeModulDataSets:[HomeModel] = [HomeModel]()
//    private var AdModulDataSets:[AdModel] = [AdModel]()
//    func loadMainData() {
//        apiProvider.request(.getHomeAdListData(openid: (currentUser?.openid)!))
//            .mapResponseToObjArrayToArray(type: AdModel.self)
//            .subscribe(
//                onNext: { items in
//                   //返回的为顶部导航栏的数组
//                    self.output.HTTP_Api_Success_DataReturn(data: items, type:AdModel.self)
//                    
//                    apiProvider.request(.homeModulGoodsData(size: 10, openid: (currentUser?.openid)!))
//                        .mapResponseToObjArray(type: PHomeModel.self)
//                        .subscribe(
//                            onNext: { items in
//                                //返回的为顶部导航栏的数组
//                                for item in items {
//                                    if item.homemodule_type == 1{
//                                        self.AdModulDataSets.append(item.data as! AdModel)
//                                    }
//                                    if item.homemodule_type == 2{
//                                        self.homeModulDataSets.append(item.data as! HomeModel)
//                                    }
//                                }
//                                self.output.HTTP_Api_Success_DataReturn(data: items,type:PHomeModel.self)
//                            },
//                            onError: { error in
//                                print(error)
//                                let oRMBizError = error as! ORMError
//                                var responseString = ""
//                                switch oRMBizError {
//                                case .ORMSign_WrontError:
//                                    responseString = AppPlist.UserLoginViewText.netWorkError
//                                    break
//                                case .ORMBizError( _, let msg):
//                                    responseString = msg
//                                    break
//                                default:
//                                    self.output.HTTP_Api_Error(msg: AppPlist.UserLoginViewText.netWorkError)
//                                    break
//                                }
//                                    self.output.HTTP_Api_Error(msg: responseString)
//                            }
//                        )
//                        .addDisposableTo(self.disposeBag)
//
//                },
//                onError: { error in
//                    print(error)
//                    let oRMBizError = error as! ORMError
//                    var responseString = ""
//                    switch oRMBizError {
//                    case .ORMSign_WrontError:
//                        responseString = AppPlist.UserLoginViewText.netWorkError
//                        break
//                    case .ORMBizError( _, let msg):
//                        responseString = msg
//                        break
//                    default:
//                        self.output.HTTP_Api_Error(msg: AppPlist.UserLoginViewText.netWorkError)
//                        break
//                    }
//                    self.output.HTTP_Api_Error(msg: responseString)
//                }
//            )
//            .addDisposableTo(disposeBag)
//
//    }
    
    func getGoodsIdFormCellClick(modulid: Int, cellPos: Int) {
        let courseId = 0
        self.output.returnCourseIdFormSelect(courseId: Int64(courseId))
    }
    

}
