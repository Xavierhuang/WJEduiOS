//
//  RootWireframe.swift
//  Winsharesapp
//
//  Created by samson on 27/11/2016.
//  Copyright © 2016 samson. All rights reserved.
//

import Foundation
import UIKit

class RootWireframe : NSObject {
//     let ShopMainViewControllerIdentifier = "ShopIndexTabbarViewController"
//    let "mainToHomeView"
//    "mainToLoginView"
    func showRootViewController(_ viewController: UIViewController, inWindow: UIWindow) {
        let rootViewController = navigationControllerFromWindow(inWindow)
        rootViewController.present(viewController, animated: false, completion: nil)
        
    }
    
    func navigationControllerFromWindow(_ window: UIWindow) -> UIViewController {
        let navigationController = window.rootViewController 
        return navigationController!
    }
}
