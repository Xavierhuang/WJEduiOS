//
//  RxMoyaResponseMapper.swift
//  Winsharesapp
//
//  Created by samson on 5/12/2016.
//  Copyright © 2016 samson. All rights reserved.
//

//
//  RxMoyaResponseMapper.swift
//
//  Created by Kooze on 16/6/29.
//  Copyright © 2016年 purisen. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON
import Moya

enum ORMError : Swift.Error {
    case ORMNoRepresentor
    case ORMNotSuccessfulHTTP
    case ORMNoData
    case ORMSign_WrontError
    case ORMCouldNotMakeObjectError
    case ORMBizError(resultCode: Int, resultMsg: String)
}

enum BizStatus: Int {
    case BizSuccess = 200
    case BizError
}

public protocol Mapable {
    init?(jsonData:JSON)
}

struct NoDataModel: Mapable {
    init?(jsonData: JSON) {
        //        self.openid = jsonData["openid"].string
    }
}


let RESULT_CODE = "ret"
let RESULT_MSG = "msg"
let RESULT_DATA = "data"
let RESULT_STATUS = "status"
let RESULT_SIGN = "sign"

extension Observable {
    
    private func resultFromJSON<T: Mapable>(jsonData:JSON, classType: T.Type) -> T? {
        return T(jsonData: jsonData)
    }
    
    
    func mapResponseToObj<T: Mapable>(type: T.Type) -> Observable<T?> {
        return map { representor in
            // get Moya.Response
            guard let response = representor as? Moya.Response else {
                throw ORMError.ORMNoRepresentor
            }
            
            // check http status
            guard ((200...209) ~= response.statusCode) else {
                throw ORMError.ORMNotSuccessfulHTTP
            }
            // unwrap biz json shell
            let json = JSON.init(data: response.data)
            
            // check biz status
            if let code = json[RESULT_CODE].int {
                if code == BizStatus.BizSuccess.rawValue {
                    // bizSuccess -> return biz obj
                    let sign = json[RESULT_SIGN].stringValue
                    let dataString = json[RESULT_DATA].stringValue
                    let returnSignString = (NSString(format: "EnterKey%@EnterKey", dataString) as String).md5()
                    
                    if sign == returnSignString {
                        let desReturnDataString = DesSigner.base64String(fromTextDecrypt: dataString, withKey: AppConfiguration.WinsharesApp.desKey)
                        let data = DesSigner.dictionary(withJsonString: desReturnDataString)["data"] as! Dictionary<String,Any>
                        let obj = self.resultFromJSON(jsonData: JSON(data), classType:type)
//                        if type == HomeModel.self{
//                            if let homeItem = obj as? HomeModel{
//                                let itemGoodsList = homeItem.goodlist as! [Dictionary<String,Any>]
//                                for item in itemGoodsList {
//                                    let itemGoodsModul =  self.resultFromJSON(jsonData: JSON(item), classType:GoodsModel.self)
//                                    homeItem.goodModelList.append(itemGoodsModul!)
//                                }
//                            }
//                        }else if type == PayModel.self{
//                            if let payItem = obj as? PayModel{
//                                let addresslist = payItem.addresslist as! [Dictionary<String,Any>]
//                                for item in addresslist{
//                                    let itemModul =  self.resultFromJSON(jsonData: JSON(item), classType:UserAddressModel.self)
//                                    payItem.addressModelList.append(itemModul!)
//                                }
//                                let defaultaddress = payItem.defaultaddress as! Dictionary<String,Any>
//                                let defaultaddressModul =  self.resultFromJSON(jsonData: JSON(defaultaddress), classType:UserAddressModel.self)
//                                payItem.defaultaddressModel = defaultaddressModul
//                                let gdlogiticslist = payItem.gdlogiticsdata as! [Dictionary<String,Any>]
//                                for item in gdlogiticslist{
//                                    let itemModul =  self.resultFromJSON(jsonData: JSON(item), classType:LogiticModel.self)
//                                    payItem.gdlogiticsdataModelData.append(itemModul!)
//                                }
//                                let notlogiticslist = payItem.notlogiticsdata as! [Dictionary<String,Any>]
//                                for item in notlogiticslist{
//                                    let itemModul =  self.resultFromJSON(jsonData: JSON(item), classType:LogiticModel.self)
//                                    payItem.notlogiticsModelData.append(itemModul!)
//                                }
//                            }
//
//                        } else if type == OrderListModel.self{
//                            if let orderListItem = obj as? OrderListModel{
//                                let itemList = orderListItem.ordergoods as! [Dictionary<String,Any>]
//                                for item in itemList {
//                                    let itemModul =  self.resultFromJSON(jsonData: JSON(item), classType:OrderGoodModel.self)
//                                    orderListItem.ordergoodsModelList.append(itemModul!)
//                                }
//                            }
//                        }


                        return obj
                    }else{
                        throw ORMError.ORMSign_WrontError
                    }
                } else {
                    // bizError -> throw biz error
                    throw ORMError.ORMBizError(resultCode: json[RESULT_CODE].int!, resultMsg: json[RESULT_MSG].string!)
                }
            } else {
                throw ORMError.ORMBizError(resultCode: json[RESULT_CODE].int!, resultMsg: json[RESULT_MSG].string!)
            }
        }
    }
    
    func mapResponseToObjArray<T: Mapable>(type: T.Type) -> Observable<[T]> {
        return map { response in
            
            // get Moya.Response
            guard let response = response as? Moya.Response else {
                throw ORMError.ORMNoRepresentor
            }
            
            // check http status
            guard ((200...209) ~= response.statusCode) else {
                throw ORMError.ORMNotSuccessfulHTTP
            }
            
            // unwrap biz json shell
            let json = JSON.init(data: response.data)
            
            if let code = json[RESULT_CODE].int {
                if code == BizStatus.BizSuccess.rawValue {
                    // bizSuccess -> return biz obj
                    let sign = json[RESULT_SIGN].stringValue
                    let dataString = json[RESULT_DATA].stringValue
                    let returnSignString = (NSString(format: "EnterKey%@EnterKey", dataString) as String).md5()
                     return [T]()
//                    if sign == returnSignString {
//                        let desReturnDataString = DesSigner.base64String(fromTextDecrypt: dataString, withKey: AppConfiguration.WinsharesApp.desKey)
//                        let dataArray = DesSigner.dictionary(withJsonString: desReturnDataString)["data"] as! [Dictionary<String,Any>]
//                        var objects = [T]()
//                        for object in dataArray {
//                            let obj = self.resultFromJSON(jsonData: JSON(object), classType:type)
//                          
//                            if type == HomeModel.self{
//                                if let homeItem = obj as? HomeModel{
//                                    let itemGoodsList = homeItem.goodlist as! [Dictionary<String,Any>]
//                                    for item in itemGoodsList {
//                                        let itemGoodsModul =  self.resultFromJSON(jsonData: JSON(item), classType:GoodsModel.self)
//                                        homeItem.goodModelList.append(itemGoodsModul!)
//                                    }
//                                }
//                            }
//                            if type == PHomeModel.self{
//                                if let homeItem = obj as? PHomeModel{
//                                    if homeItem.homemodule_type == 1{
//                                        //广告数据
//                                        let dataModel =  self.resultFromJSON(jsonData: homeItem.data as! JSON, classType:AdModel.self)
//                                        homeItem.data = dataModel
//                                    }else if homeItem.homemodule_type == 2{
//                                        //产品数据
//                                        let dataModel =  self.resultFromJSON(jsonData: homeItem.data as! JSON, classType:HomeModel.self)
//                                        let itemGoodsList = dataModel?.goodlist as! [Dictionary<String,Any>]
//                                        for item in itemGoodsList {
//                                            let itemGoodsModul =  self.resultFromJSON(jsonData: JSON(item), classType:GoodsModel.self)
//                                            dataModel?.goodModelList.append(itemGoodsModul!)
//                                        }
//                                        homeItem.data = dataModel
//                                    }
//                                }
//                            }
//
//                            if type == GoodsModel.self{
//                                if let goodItem = obj as? GoodsModel{
//                                    let keyArray = Array(goodItem.goodsTributeList.keys)
//                                    for item in keyArray{
//                                        if let goodsTributeJsonData = goodItem.goodsTributeList[item] as? JSON{
//                                            let itemGoodsTributeDicList = goodsTributeJsonData.arrayValue
//                                            var goodsTributeModelList:[GoodsTributeItemModel] = []
//                                            for itemGoodsTributeDicitem in itemGoodsTributeDicList{
//                                                let itemGoodsTributeModel =  self.resultFromJSON(jsonData: itemGoodsTributeDicitem, classType:GoodsTributeItemModel.self)
//                                                goodsTributeModelList.append(itemGoodsTributeModel!)
//                                            }
//                                            goodItem.goodsTributeModelList[item] = goodsTributeModelList
//                                        }
//                                    }
//                                }
//                            }
//                            if type == PromCartModel.self{
//                                if let pCartItem = obj as? PromCartModel{
//                                    if let keyArray = pCartItem.orderData as? Dictionary<String,Any>{
//                                        let cartList = Array(keyArray.values)
//                                        for itemCart in cartList{
//                                            let itemCartModel =  self.resultFromJSON(jsonData: JSON(itemCart), classType:CartModel.self)
//                                            pCartItem.orderGoodsData.append(itemCartModel!)
//                                        }
//                                    }
//                                }
//                            }
//                            objects.append(obj!)
//                        }
//                        return objects
//                    }else{
//                        throw ORMError.ORMSign_WrontError
//                    }
                } else {
                    // bizError -> throw biz error
                    throw ORMError.ORMBizError(resultCode: json[RESULT_CODE].int!, resultMsg: json[RESULT_MSG].string!)
                }
            }else{
                throw ORMError.ORMBizError(resultCode: json[RESULT_CODE].int!, resultMsg: json[RESULT_MSG].string!)
            }
        }
    }
    
    
    func mapResponseToObjArrayPagination<T: Mapable>(type: T.Type) -> Observable<Any> {
        return map { response in
            
            // get Moya.Response
            guard let response = response as? Moya.Response else {
                throw ORMError.ORMNoRepresentor
            }
            
            // check http status
            guard ((200...209) ~= response.statusCode) else {
                throw ORMError.ORMNotSuccessfulHTTP
            }
            
            // unwrap biz json shell
            let json = JSON.init(data: response.data)
            
            if let code = json[RESULT_CODE].int {
                if code == BizStatus.BizSuccess.rawValue {
                    // bizSuccess -> return biz obj
                    let sign = json[RESULT_SIGN].stringValue
                    let dataString = json[RESULT_DATA].stringValue
                    let returnSignString = (NSString(format: "EnterKey%@EnterKey", dataString) as String).md5()
                     return [T]()
//                    if sign == returnSignString {
//                        let desReturnDataString = DesSigner.base64String(fromTextDecrypt: dataString, withKey: AppConfiguration.WinsharesApp.desKey)
//                        let dataArray = DesSigner.dictionary(withJsonString: desReturnDataString)["data"] as! [Dictionary<String,Any>]
//                        let pageSize = DesSigner.dictionary(withJsonString: desReturnDataString)["pagesize"] as! Int
//                        let currentPage = DesSigner.dictionary(withJsonString: desReturnDataString)["currentpage"] as! Int
//                        let totalPage = DesSigner.dictionary(withJsonString: desReturnDataString)["totalpage"] as! Int
//                        var objectDic:Dictionary<String,Any> = Dictionary<String,Any>()
//                        var objects = [T]()
//                        for object in dataArray {
//                            let obj = self.resultFromJSON(jsonData: JSON(object), classType:type)
//                            if type == OrderListModel.self{
//                                if let orderListItem = obj as? OrderListModel{
//                                    let itemList = orderListItem.ordergoods as! [Dictionary<String,Any>]
//                                    for item in itemList {
//                                        let itemModul =  self.resultFromJSON(jsonData: JSON(item), classType:OrderGoodModel.self)
//                                        orderListItem.ordergoodsModelList.append(itemModul!)
//                                    }
//                                }
//                            }
//                            objects.append(obj!)
//                        }
//                        objectDic["pagesize"] = pageSize
//                        objectDic["currentpage"] = currentPage
//                        objectDic["totalpage"] = totalPage
//                        objectDic["data"] = objects
//                        return objectDic
//                    }else{
//                        throw ORMError.ORMSign_WrontError
//                    }
                } else {
                    // bizError -> throw biz error
                    throw ORMError.ORMBizError(resultCode: json[RESULT_CODE].int!, resultMsg: json[RESULT_MSG].string!)
                }
            }else{
                throw ORMError.ORMBizError(resultCode: json[RESULT_CODE].int!, resultMsg: json[RESULT_MSG].string!)
            }
        }
    }
    
    
    func mapResponseToObjArrayToArray<T: Mapable>(type: T.Type) -> Observable<Any> {
        return map { response in
            
            // get Moya.Response
            guard let response = response as? Moya.Response else {
                throw ORMError.ORMNoRepresentor
            }
            
            // check http status
            guard ((200...209) ~= response.statusCode) else {
                throw ORMError.ORMNotSuccessfulHTTP
            }
            
            // unwrap biz json shell
            let json = JSON.init(data: response.data)
            
            if let code = json[RESULT_CODE].int {
                if code == BizStatus.BizSuccess.rawValue {
                    // bizSuccess -> return biz obj
                    let sign = json[RESULT_SIGN].stringValue
                    let dataString = json[RESULT_DATA].stringValue
                    let returnSignString = (NSString(format: "EnterKey%@EnterKey", dataString) as String).md5()
                    return [T]()
//                    if sign == returnSignString {
//                        let desReturnDataString = DesSigner.base64String(fromTextDecrypt: dataString, withKey: AppConfiguration.WinsharesApp.desKey)
//                        var objects = [[T]]()
//                        if type == AdModel.self {
//                            let dataArray = DesSigner.dictionary(withJsonString: desReturnDataString)["data"] as! [[Dictionary<String,Any>]]
//                            for i in 0..<2 {
//                                var tempdata = [T]()
//                                for itemdata in dataArray[i]{
//                                    let obj = self.resultFromJSON(jsonData: JSON(itemdata), classType:type)
//                                    tempdata.append(obj!)
//                                }
//                                objects.append(tempdata)
//                            }
//                        }
//                        return objects
//                    }else{
//                        throw ORMError.ORMSign_WrontError
//                    }
                } else {
                    // bizError -> throw biz error
                    throw ORMError.ORMBizError(resultCode: json[RESULT_CODE].int!, resultMsg: json[RESULT_MSG].string!)
                }
            }else{
                throw ORMError.ORMBizError(resultCode: json[RESULT_CODE].int!, resultMsg: json[RESULT_MSG].string!)
            }
        }
    }

    
}


