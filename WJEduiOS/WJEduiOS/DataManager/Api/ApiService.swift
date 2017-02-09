//
//  ApiService.swift
//
//  Created by Kooze on 16/6/27.
//  Copyright © 2016年 purisen. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON
import CryptoSwift

let headerFields: Dictionary<String, String> = [
    "platform": "iOS",
    "sys_ver": String(UIDevice.version())
]

let appendedParams: Dictionary<String, AnyObject> = [
    "uid": "123456" as AnyObject
]

let endpointClosure = { (target: ApiService) -> Endpoint<ApiService> in
    
    let url = target.baseURL.appendingPathComponent(target.path).absoluteString
    return Endpoint(url: url, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters)
        .adding(newParameters: appendedParams)
        .adding(newHTTPHeaderFields:headerFields)
    
}

let apiProvider = RxMoyaProvider<ApiService>(endpointClosure: endpointClosure)

enum ApiService {
    case Login(phone: String, vcode: String)
    case GetVcode(phone: String)
    case Logout()
    case getAllProduct()
    case homeModulGoodsData(size:Int,openid:String)
    case AdIndexWithPosId(pos:Int,openid:String)
    case getHomeAdListData(openid:String)
    case LoadAllGoodsData(openid:String,pos:Int)
    case LoadCommandData(size:Int,openid:String)
    case GetGoodsDetailData(goodsid:Int64,openid:String)
    case getAddressListByUserid(userId:Int64,openid:String)
    case getCouponListByUserid(userId:Int64,openid:String)
    case createOrderByUserInfo(goodsid:Int64,disinfoid:Int64,goodsnum:Int64,tableware:String,
        openid:String,userid:Int64,pay_code:String,pay_name:String,addressid:Int64)
    case storeCartDataByUserInfo(goodsid:Int64,disinfoid:Int64,goodsnum:Int64,tableware:String,
        openid:String,userid:Int64,buytype:Int64)
    case getAllCartData(userid:Int64,openid:String)
    case getNewUserCoupon(userid:Int64,openid:String)
    case yhCodeExchange(userid:Int64,openid:String,code:String)
    case createOrderByCart(cartidlist:[Int64],addressid:Int64,userid:Int64,openid:String,pay_code:String,pay_name:String)
    case orderListBytype(userid:Int64,ordertype:Int,currentid:Int64)
    case orderDetailBySn(userid:Int64,ordersn:String)
    case changeCartGoodNum(cartid:Int64,apitype:Int,openid:String,userid:Int64)
    case deleteCartGoodNum(cartid:Int64,openid:String,userid:Int64)
    
}

extension ApiService: TargetType {
    
    var baseURL: URL {return URL(string: AppConfiguration.WinsharesApp.serviceBaseUrl)!}
    
    var task: Task {
        switch self {
        case .GetVcode, .getAllProduct, .Login, .AdIndexWithPosId:
            return .request
        case .homeModulGoodsData, .LoadAllGoodsData, .LoadCommandData:
            return .request
        case .GetGoodsDetailData, .getAddressListByUserid,.getHomeAdListData:
            return .request
        case .getCouponListByUserid,.createOrderByUserInfo,.storeCartDataByUserInfo:
            return .request
        case .getAllCartData,.getNewUserCoupon,.yhCodeExchange,.createOrderByCart:
            return .request
        case .orderListBytype,.orderDetailBySn,.changeCartGoodNum,.deleteCartGoodNum:
            return .request
        default:
            return .request
        }
    }
    var path: String {
        switch self {
        case .GetVcode(_):
            return "user/sendvcode"
        case .Login(_, _):
            return "user/login"
        case .Logout(_):
            return "user/login"
        case .getAllProduct():
            return "goods/indextest"
        case .AdIndexWithPosId(_, _):
            return "ad/index"
        case .homeModulGoodsData(_, _):
            return "wshomemodule/index"
        case .LoadCommandData(_, _):
            return "goods/commandgood"
        case .LoadAllGoodsData(_,_):
            return "goods/getallbypid"
        case .GetGoodsDetailData(_,_):
            return "goods/getgoodsdetailbyid"
        case .getAddressListByUserid(_,_):
            return "useraddress/appindex"
        case .getHomeAdListData(_):
            return "ad/adlist"
        case .getCouponListByUserid(_,_):
            return "coupon/cplist"
        case .createOrderByUserInfo(_,_,_,_,_,_,_,_,_):
            return "order/appcreate"
        case .storeCartDataByUserInfo(_,_,_,_,_,_,_):
            return "cart/appstore"
        case .getAllCartData(_,_):
            return "cart/appindex"
        case .getNewUserCoupon(_,_):
            return "coupon/appgetnewcoupon"
        case .yhCodeExchange(_,_,_):
            return "yhcode/appcodeexchange"
        case .createOrderByCart(_,_,_,_,_,_):
            return "order/appcreatebycart"
        case .orderListBytype(_,_,_):
            return "order/apporderlistbytype"
        case .orderDetailBySn(_, _):
            return "order/orderdetailbysn"
        case .changeCartGoodNum(_,_,_,_):
            return "cart/appchangenum"
        case .deleteCartGoodNum(_,_,_):
            return "cart/appdeletecartgood"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .GetVcode(_),.Login(_, _),.getAllProduct(),.AdIndexWithPosId(_, _):
            return .post
        case .homeModulGoodsData(_, _),.LoadAllGoodsData(_,_),.LoadCommandData(_, _):
            return .post
        case .GetGoodsDetailData(_, _),.getAddressListByUserid(_,_),.getHomeAdListData(_):
            return .post
        case .getCouponListByUserid(_, _),.getAllCartData(_, _),.getNewUserCoupon(_,_),.yhCodeExchange(_,_,_):
            return .post
        case .createOrderByUserInfo(_,_,_,_,_,_,_,_,_),.storeCartDataByUserInfo(_,_,_,_,_,_,_):
            return .post
        case .createOrderByCart(_,_,_,_,_,_),.orderListBytype(_,_,_),.orderDetailBySn(_,_):
            return .post
        case .changeCartGoodNum(_,_,_,_),.deleteCartGoodNum(_,_,_):
            return .post
        default:
            return .post
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .GetVcode(let phone):
            return EncryptParas(["phone":phone as AnyObject],devicetype:"app")
        case .Login(let phone, let vcode):
            return EncryptParas(["inputphone": phone as AnyObject ,"inputvcode":vcode as AnyObject],devicetype:"app")
        case .getAllProduct():
            return EncryptParas(["openid":"odkzjs2In29an8HRBo3fu0zsrRhg" as AnyObject],devicetype:"app")
        case .AdIndexWithPosId(let posId, let openid):
            return EncryptParas(["pid":posId, "openid":openid as AnyObject],devicetype:"app")
        case .homeModulGoodsData(let size, let openid):
            return EncryptParas(["displaysize":size, "openid":openid as AnyObject],devicetype:"app")
        case .LoadAllGoodsData(let openid,let pos):
            return EncryptParas([ "openid":openid as AnyObject,"pos":pos],devicetype:"app")
        case .LoadCommandData(let size, let openid):
            return EncryptParas(["displaysize":size, "openid":openid as AnyObject],devicetype:"app")
        case .GetGoodsDetailData(let goodsid, let openid):
            return EncryptParas(["goodid":goodsid, "openid":openid as AnyObject],devicetype:"app")
        case .getAddressListByUserid(let userId, let openid):
            return EncryptParas(["user_id":userId, "openid":openid as AnyObject],devicetype:"app")
        case .getHomeAdListData(let openid):
            return EncryptParas(["openid":openid as AnyObject],devicetype:"app")
        case .getCouponListByUserid(let userid, let openid):
            return EncryptParas(["userid":userid as AnyObject, "openid":openid as AnyObject],devicetype:"app")
        case .getAllCartData(let userid, let openid):
            return EncryptParas(["userid":userid as AnyObject, "openid":openid as AnyObject],devicetype:"app")
        case .createOrderByUserInfo(let goodsid, let disinfoid,let goodsnum, let tableware,let openid, let userid
            ,let pay_code, let pay_name, let addressid):
            return EncryptParas(["goodsid":goodsid as AnyObject, "disinfoid":disinfoid as AnyObject,
                                 "goodsnum":goodsnum as AnyObject, "tableware":tableware as AnyObject,
                                 "openid":openid as AnyObject, "userid":userid as AnyObject,
                                 "pay_code":pay_code as AnyObject, "pay_name":pay_name as AnyObject,"addressid":addressid],devicetype:"app")
        case .storeCartDataByUserInfo(let goodsid, let disinfoid,let goodsnum, let tableware,let openid, let userid
            ,let buytype):
            return EncryptParas(["goodsid":goodsid as AnyObject, "disinfoid":disinfoid as AnyObject,
                                 "goodsnum":goodsnum as AnyObject, "tableware":tableware as AnyObject,
                                 "openid":openid as AnyObject, "userid":userid as AnyObject,
                                 "buytype":buytype as AnyObject],devicetype:"app")
        case .getNewUserCoupon(let userid, let openid):
            return EncryptParas(["userid":userid as AnyObject, "openid":openid as AnyObject],devicetype:"app")
        case .yhCodeExchange(let userid, let openid,let code):
            return EncryptParas(["userid":userid as AnyObject, "openid":openid as AnyObject,"code":code as AnyObject],devicetype:"app")
        case .createOrderByCart(let cartidlist,let addressid,let userid, let openid,let pay_code, let pay_name):
            return EncryptParas(["cartidlist":cartidlist,"addressid":addressid,"userid":userid as AnyObject, "openid":openid as AnyObject,"pay_code":pay_code as AnyObject, "pay_name":pay_name as AnyObject],devicetype:"app")
        case .orderListBytype(let userid,let ordertype,let currentid):
            return EncryptParas(["userid":userid,"ordertype":ordertype,"currentid":currentid],devicetype:"app")
        case .orderDetailBySn(let userid,let ordersn):
             return  EncryptParas(["userid":userid,"order_sn":ordersn],devicetype:"app")
        case .changeCartGoodNum(let cartid,let apitype,let openid,let userid):
            return  EncryptParas(["cartid":cartid,"apitype":apitype,"openid":openid,"userid":userid],devicetype:"app")
        case .deleteCartGoodNum(let cartid,let openid,let userid):
            return  EncryptParas(["cartid":cartid,"openid":openid,"userid":userid],devicetype:"app")
        case .Logout(_):
            return nil
        }
        
    
    }
    
    var sampleData: Data {
        switch self {
        case .GetVcode(_),.Login(_, _), .AdIndexWithPosId(_, _),.homeModulGoodsData(_, _):
            return "Success".data(using: .utf8)!
        case .Logout(_):
            return "Success".data(using: .utf8)!
        case .getAllProduct(),.LoadAllGoodsData(_,_),.LoadCommandData(_, _),.GetGoodsDetailData(_,_):
            return "Success".data(using: .utf8)!
        case .getAddressListByUserid(_,_),.getHomeAdListData(_),.getCouponListByUserid(_,_),
             .createOrderByUserInfo(_,_,_,_,_,_,_,_,_):
            return "Success".data(using: .utf8)!
        case .storeCartDataByUserInfo(_,_,_,_,_,_,_),.getAllCartData(_,_),.getNewUserCoupon(_,_):
            return "Success".data(using: .utf8)!
        case .yhCodeExchange(_,_,_),.createOrderByCart(_,_,_,_,_,_),.orderListBytype(_,_,_),.orderDetailBySn(_,_):
            return "Success".data(using: .utf8)!
        case .changeCartGoodNum(_,_,_,_),.deleteCartGoodNum(_,_,_):
            return "Success".data(using: .utf8)!
        }
    }

    func EncryptParas(_ params: [String: Any],devicetype:String)->[String: String]{
        let paramsJasonString = JSON(params).description
        let paramsEncryptString = DesSigner.base64String(fromTextEncrypt: paramsJasonString, withKey: AppConfiguration.WinsharesApp.desKey)
        let signString = (NSString(format: "EnterKey%@EnterKey", paramsEncryptString!) as String).md5()
        let parasEncryp = ["postdata":paramsEncryptString,"devicetype":devicetype, "sign":signString]
        return parasEncryp as! [String : String]
    }
}

