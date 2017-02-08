//
//  LoginInteractor.swift
//  WJEduiOS
//
//  Created by samson on 25/11/2016.
//  Copyright © 2016 samson. All rights reserved.
//

import Alamofire


/*
 * Protocol that defines the Interactor's use case.
 */
protocol LoginInteractorInput: class {
    func fetchUser()
}

/*
 * The Interactor responsible for implementing
 * the business logic of the module.
 */
class LoginInteractor : LoginInteractorInput
{
    // Url to the desired API.
    let url = "http://api.winshares.cn/api/goods/index"
    
    // Reference to the Presenter's output interface.
    weak var output: LoginInteractorOutput!
    
    // MARK: ArticlesInteractorInput
    
    func fetchUser() {
        
        Alamofire.request(url,method:.get).response { response in
            print("Request: \(response.request)")
            print("Response: \(response.response)")
            print("Error: \(response.error)")
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
                
            }
            
        }
        var param:[String:String]?;
        param?["key"] = "value"
        
    }
}
