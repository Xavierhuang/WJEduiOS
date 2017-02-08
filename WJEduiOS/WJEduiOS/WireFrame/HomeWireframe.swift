//
//  HomeWireframe.swift
//  Winsharesapp
//
//  Created by samson on 10/12/2016.
//  Copyright © 2016 samson. All rights reserved.
//

import Foundation
import UIKit
protocol HomeWireframeInput:BaseWireframe{
    //    func presentDetailsInterfaceForGood(good: Good)
}

/*
 * The Router responsible for navigation between modules.
 */
class HomeWireframe : NSObject, HomeWireframeInput
{
    let CourseListViewControllerIdentifier = "courseListViewController"
    let CourseDetailViewControllerIdentifier = "courseDetailViewController"
    
    func presentCourseListInterfaceFromViewController(_ viewController: HomeViewController) {
    
        let newViewController = self.courseListViewController()
//        let goodDetailPresenter = GoodDetailPresenter()
//        goodDetailViewController.eventHandler = goodDetailPresenter
//        let goodDetailInteractor = GoodDetailInteractor()
//        goodDetailPresenter.view = goodDetailViewController
//        goodDetailPresenter.wireframe = GoodDetailWireframe()
//        goodDetailPresenter.interactor = goodDetailInteractor
//        goodDetailInteractor.output = goodDetailPresenter
//        goodDetailViewController.goodsIdSelect = goodsId
        viewController.navigationController?.pushViewController(newViewController, animated: true)
    }

    func presentCourseDetailInterfaceFromViewController(_ viewController: HomeViewController) {
        let newViewController = self.courseDetailViewController()
        //        let goodDetailPresenter = GoodDetailPresenter()
        //        goodDetailViewController.eventHandler = goodDetailPresenter
        //        let goodDetailInteractor = GoodDetailInteractor()
        //        goodDetailPresenter.view = goodDetailViewController
        //        goodDetailPresenter.wireframe = GoodDetailWireframe()
        //        goodDetailPresenter.interactor = goodDetailInteractor
        //        goodDetailInteractor.output = goodDetailPresenter
        //        goodDetailViewController.goodsIdSelect = goodsId
        viewController.navigationController?.pushViewController(newViewController, animated: true)
    }

    func courseListViewController() -> CourseListViewController {
        let storyboard = mainStoryboard()
        
        //为什么使用这个会不行的呢
        //let wtf : CourseListViewController = storyboard.instantiateViewController(withIdentifier: "what the fuck") as! CourseListViewController
        
        let courseListController: CourseListViewController = storyboard.instantiateViewController(withIdentifier: CourseListViewControllerIdentifier) as! CourseListViewController
        
       
        return courseListController
        
    }
    
    func courseDetailViewController() -> CourseDetailViewController {
        let storyboard = mainStoryboard()
        let newViewController: CourseDetailViewController = storyboard.instantiateViewController(withIdentifier: CourseDetailViewControllerIdentifier) as! CourseDetailViewController
        return newViewController
    }


}
