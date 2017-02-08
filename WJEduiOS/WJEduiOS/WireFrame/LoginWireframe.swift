//
//  LoginWireframe.swift
//  WJEduiOS
//
//  Created by samson on 26/11/2016.
//  Copyright © 2016 samson. All rights reserved.
//

import Foundation

/*
 * Protocol that defines the possible routes from the Articles module.
 */
protocol LoginWireframeInput {
    func presentDetailsInterfaceForGood(good: Good)
}

/*
 * The Router responsible for navigation between modules.
 */
class LoginWireframe : NSObject, LoginWireframeInput
{
    
    // Reference to the ViewController (weak to avoid retain cycle).
    weak var loginViewController: LoginViewController!
    
    // Reference to the Router of the next VIPER module.
    var mainWireframe: MainWireframe!
    
    
    // MARK: ArticlesWireframeInput
    
    func presentDetailsInterfaceForGood(good: Good) {
        // Create the Router for the upcoming module.
    self.mainWireframe = MainWireframe()
        
//        // Sends the article data to the next module's Presenter.
//        self.sendArticleToDetailsPresenter(self.detailsWireframe.detailsPresenter, article: good)
//        
//        // Presents the next View.
//        self.detailsWireframe.presentArticleDetailsInterfaceFromViewController(self.articlesViewController)
    }
    
    
    // MARK: Private
    
//    private func sendArticleToDetailsPresenter(detailsPresenter: DetailsPresenter, article: Article) {
//        detailsPresenter.article = article
//    }
}
