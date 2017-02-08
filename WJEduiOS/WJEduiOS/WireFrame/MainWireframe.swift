//
//  MainWireframe.swift
//  WJEduiOS
//
//  Created by samson on 26/11/2016.
//  Copyright © 2016 samson. All rights reserved.
//

import Foundation
import UIKit

/*
 * Protocol that defines the possible routes from the Articles module.
 */
protocol MainWireframeInput:BaseWireframe {
//    func presentDetailsInterfaceForGood(good: Good)
}

/*
 * The Router responsible for navigation between modules.
 */
class MainWireframe : NSObject, MainWireframeInput
{
    var rootWireframe : RootWireframe?
//    var mainPresenter : MainPresenter?
    var mainViewController : MainViewController?
//    var shopMainWireframe : ShopMainWireframeInput?
    var MainViewControllerIdentifier  = "mainTabbarViewController"
    
    func presentMainInterfaceFromWindow(_ window: UIWindow) {
        let viewController = maintabViewControllerFromStoryboard()
        window.rootViewController = viewController
//        viewController.eventHandler = mainPresenter
//        mainViewController = viewController
//        rootWireframe?.showRootViewController(viewController, inWindow: window)
    }
    
    func presentShopMainInterface() {
//        shopMainWireframe?.presentShopMainInterfaceFromViewController(mainViewController!)
    }
    
    func presentLoginMainInterface() {
//        shopMainWireframe?.presentLoginInterfaceFromViewController(mainViewController!)
    }
    
    func maintabViewControllerFromStoryboard() -> MainTabbarViewController {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: MainViewControllerIdentifier) as! MainTabbarViewController
         initTabChildController(mainViewController: viewController)
        return viewController
    }

}
