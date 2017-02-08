//
//  MainViewController.swift
//  Winsharesapp
//
//  Created by samson on 27/11/2016.
//  Copyright © 2016 samson. All rights reserved.
//

import UIKit

protocol MainViewInterface: class {
    
    //    func showNoContentScreen()
}

class MainViewController: UIViewController,MainViewInterface {
    
//    var eventHandler : MainModuleInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//
    }

    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
//         eventHandler?.isLoginCheck()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
