//
//  LoginPresenter.swift
//  WJEduiOS
//
//  Created by samson on 25/11/2016.
//  Copyright © 2016 samson. All rights reserved.
//

/*
 * Protocol that defines the commands sent from the View to the Presenter.
 */
protocol LoginModuleInterface:class {
    func updateView()
    func showDetailsForUser(user: User)
}
/*
 * Protocol that defines the commands sent from the Interactor to the Presenter.
 */
protocol  LoginInteractorOutput:class {
    func userFetched(user: User)
}

class LoginPresenter: LoginModuleInterface,LoginInteractorOutput {
   

    weak var view:LoginViewInterface!
    
    // Reference to the Interactor's interface
    var interactor: LoginInteractorInput!
    
    // Reference to the Router
    var wireframe: LoginWireframe!
    
    func updateView() {
        self.interactor = LoginInteractor()
        self.interactor.fetchUser()
    }
    
    func showDetailsForUser(user: User) {
        
    }
    
    internal func userFetched(user: User) {
        
    }

    

}
