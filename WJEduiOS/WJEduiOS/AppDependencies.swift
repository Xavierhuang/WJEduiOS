//
//  AppDependencies.swift
//  VIPER TODO
//
//  Created by Conrad Stoll on 6/4/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation
import UIKit

class AppDependencies {
    var mainWireframe = MainWireframe()
    
    init() {
        configureDependencies()
    }
    
    func installRootViewControllerIntoWindow(_ window: UIWindow) {
        mainWireframe.presentMainInterfaceFromWindow(window)
    }
    
    func configureDependencies() {
        let rootWireframe = RootWireframe()
        mainWireframe.rootWireframe = rootWireframe
        
//        let mainPresenter = MainPresenter()
//        mainWireframe.mainPresenter = mainPresenter
//        
//        mainPresenter.mainWireframe = mainWireframe
//        
//        let shopMainWireframe = ShopMainWireframe()
//        mainWireframe.shopMainWireframe = shopMainWireframe
    }
}
