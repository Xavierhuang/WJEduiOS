//
//  UserWireframe.swift
//  Winsharesapp
//
//  Created by samson on 15/12/2016.
//  Copyright © 2016 samson. All rights reserved.
//
import Foundation
import UIKit
protocol UserWireframeInput:BaseWireframe{
    //    func presentDetailsInterfaceForGood(good: Good)
}

/*
 * The Router responsible for navigation between modules.
 */
class UserWireframe : NSObject, UserWireframeInput
{
    let MyCouponViewControllerIdentifier = "myCouponListViewController"
     let MySettingViewControllerIdentifier = "mySettingViewController"
     let suggestionViewControllerIdentifier = "suggestionViewController"
     let qesListViewControllerIdentifier = "qesListViewController"
     let aboutUsViewControllerIdentifier = "aboutUsViewController"
    let loginViewControllerIndentidier = "loginViewController"
//     let myShareViewController = "myShareViewController"
//     let shareCodeExchangeViewController = "shareCodeExchangeViewController"
//  
//    let UserNavigationController = "userNavigationController"
    
    func presentPayInterfaceFromViewController(_ viewController:UIViewController,sessionIndex:Int,rowIndex:Int) {
        
       
        switch sessionIndex {
        case 0:
            switch rowIndex {
            case 0:
                 let newViewController = self.myCouponListViewController()
                 viewController.navigationController?.pushViewController(newViewController, animated: true)
                break
            case 1:
                let newViewController = self.myAboutUsViewController()
                viewController.navigationController?.pushViewController(newViewController, animated: true)
                break
            case 2:
                let newViewController = self.myQesListViewController()
                viewController.navigationController?.pushViewController(newViewController, animated: true)
                break
            case 3:
                let newViewController = self.mySuggestionViewController()
                viewController.navigationController?.pushViewController(newViewController, animated: true)
                break
            default:
                break
            }
            break
        case 1:
            let newViewController = self.mySettingViewController()
            viewController.navigationController?.pushViewController(newViewController, animated: true)
            break
            
        case 2:
            let newViewController = self.loginViewController()
            let window = UIApplication.shared.delegate?.window
            let nav = UINavigationController(rootViewController: newViewController)
            window!!.rootViewController = nav
            break

        default:
            break
        }
//        switch viewTag {
//        case 10001...10005:
//            let newViewController = orderInfoController()
//            let orderPresenter = OrderListPresenter()
//            orderPresenter.wireframe = OrderListWireframe()
//            let orderListInteractor = OrderListInteractor()
//            orderPresenter.interactor = orderListInteractor
//            orderListInteractor.output = orderPresenter
//            newViewController.eventHandler = orderPresenter
//            orderPresenter.view = newViewController
//            newViewController.ordertype = viewTag-10000
//            viewController.navigationController?.pushViewController(newViewController, animated: true)
//            break
//        case 10006:
        
    
//             let newViewController = myCouponViewController() as MyCouponViewController
//             let myCouponPresenter = CouponPresenter()
//             let myCouponInteractor = CouponInteractor()
//             myCouponPresenter.interactor = myCouponInteractor
//             myCouponInteractor.output = myCouponPresenter
//             newViewController.eventHandler = myCouponPresenter
//             myCouponPresenter.view = newViewController
//             viewController.navigationController?.pushViewController(newViewController, animated: true)

//            break
//        case 10007:
//            let newViewController = myShareCodeExchangeViewController()
//          
//            viewController.navigationController?.pushViewController(newViewController, animated: true)
//            break
//        case 10008:
//            let newViewController = myMyShareViewController()
//            viewController.navigationController?.pushViewController(newViewController, animated: true)
//            break
//        case 10009:
//           let newViewController = myAboutUsViewController()
//           viewController.navigationController?.pushViewController(newViewController, animated: true)
//            break
//        case 10010:
//            let newViewController = myQesListViewController()
//            viewController.navigationController?.pushViewController(newViewController, animated: true)
//            break
//        case 10011:
//            let newViewController = mySuggestionViewController()
//            
//             viewController.navigationController?.pushViewController(newViewController, animated: true)
//            break
//            
//        default:
//            break
//        }
       
       
    }
    
    
        func myCouponListViewController() -> MyCouponListViewController {
            let storyboard = mainStoryboard()
            let newViewController: MyCouponListViewController = storyboard.instantiateViewController(withIdentifier: MyCouponViewControllerIdentifier) as! MyCouponListViewController
            return newViewController
        }
    
        func myAboutUsViewController() -> AboutUsViewController {
            let storyboard = mainStoryboard()
            let ViewController: AboutUsViewController = storyboard.instantiateViewController(withIdentifier: aboutUsViewControllerIdentifier) as! AboutUsViewController
            return ViewController
        }
    
        func myQesListViewController() -> QesListViewController {
            let storyboard = mainStoryboard()
            let ViewController: QesListViewController = storyboard.instantiateViewController(withIdentifier: qesListViewControllerIdentifier) as! QesListViewController
            return ViewController
        }
    
    
        func mySuggestionViewController() -> SuggestionViewController {
            let storyboard = mainStoryboard()
            let ViewController: SuggestionViewController = storyboard.instantiateViewController(withIdentifier: suggestionViewControllerIdentifier) as! SuggestionViewController
            return ViewController
        }
    
        func mySettingViewController() -> MySettingViewController {
            let storyboard = mainStoryboard()
            let newViewController: MySettingViewController = storyboard.instantiateViewController(withIdentifier: MySettingViewControllerIdentifier) as! MySettingViewController
            return newViewController
        }
    
    func loginViewController() -> LoginViewController {
        let storyboard = mainStoryboard()
        let newViewController: LoginViewController = storyboard.instantiateViewController(withIdentifier: loginViewControllerIndentidier) as! LoginViewController
        return newViewController
    }
    
//    func myUserNavViewController() -> UserNavigationViewController {
//        let storyboard = mainStoryboard()
//        let userNavController: UserNavigationViewController = storyboard.instantiateViewController(withIdentifier: UserNavigationController) as! UserNavigationViewController
//        return userNavController
//    }

    

//
//    func myOrderInfoViewController() -> OrderInfoViewController {
//        let storyboard = mainStoryboard()
//        let orderInfoViewController: OrderInfoViewController = storyboard.instantiateViewController(withIdentifier: self.orderInfoViewController) as! OrderInfoViewController
//        return orderInfoViewController
//    }
//


    
//    func myMyShareViewController() -> MyShareViewController {
//        let storyboard = mainStoryboard()
//        let ViewController: MyShareViewController = storyboard.instantiateViewController(withIdentifier: myShareViewController) as! MyShareViewController
//        return ViewController
//    }
//    
//    func myShareCodeExchangeViewController() -> ShareCodeExchangeViewController {
//        let storyboard = mainStoryboard()
//        let ViewController: ShareCodeExchangeViewController = storyboard.instantiateViewController(withIdentifier: shareCodeExchangeViewController) as! ShareCodeExchangeViewController
//        return ViewController
//    }

    
}
