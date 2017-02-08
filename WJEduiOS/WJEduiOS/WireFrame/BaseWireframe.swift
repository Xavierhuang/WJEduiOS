//
//  BaseWireframe.swift
//  Winsharesapp
//
//  Created by samson on 10/12/2016.
//  Copyright © 2016 samson. All rights reserved.
//

import Foundation
import UIKit
protocol BaseWireframe {
     func mainStoryboard() -> UIStoryboard
     func initTabChildController(mainViewController:MainTabbarViewController)
}

extension BaseWireframe{
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard
    }
    
    func initTabChildController(mainViewController:MainTabbarViewController){
        
        let mainNavController = mainViewController.childViewControllers[0] as! UINavigationController
       
        if let homeViewControler: HomeViewController = mainNavController.viewControllers[0] as? HomeViewController{
            let homePresenter = HomePresenter()
            homeViewControler.eventHandler = homePresenter
            let hoemInteractor = HomeInteractor()
            homePresenter.interactor = hoemInteractor
            hoemInteractor.output = homePresenter
            homePresenter.view = homeViewControler
            homePresenter.mainWireframe = HomeWireframe()
        }
        
        let cySocityNavController = mainViewController.childViewControllers[1] as! UINavigationController
        if let cySocityViewControler: CySocityViewController = cySocityNavController.viewControllers[0] as? CySocityViewController{
//            let discoverPresenter = DiscoverPresenter()
//            discoverViewControler.eventHandler = discoverPresenter
//            let discoverInteractor = DiscoverInteractor()
//            discoverPresenter.interactor = discoverInteractor
//            discoverInteractor.output = discoverPresenter
//            discoverPresenter.view = discoverViewControler
//            discoverPresenter.mainWireframe = DiscoverWireframe()
        }

        let userNavController = mainViewController.childViewControllers[2] as! UINavigationController
        if let userViewControler: UserViewController = userNavController.viewControllers[0] as? UserViewController{
            let userPresenter = UserPresenter()
            userViewControler.eventHandler = userPresenter
            userPresenter.mainWireframe = UserWireframe()
            userPresenter.view = userViewControler
        }

    }
}
