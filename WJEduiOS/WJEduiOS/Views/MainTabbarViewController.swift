//
//  ShopMainTabbarViewController.swift
//  Winsharesapp
//
//  Created by samson on 27/11/2016.
//  Copyright © 2016 samson. All rights reserved.
//

import UIKit

class MainTabbarViewController: UITabBarController {

    var oneTabBarItem:UITabBarItem?
    var secTabBarItem:UITabBarItem?
    var thiTabBarItem:UITabBarItem?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let vcs = self.childViewControllers
        for index in 0 ..< vcs.count{
            switch index {
            case 0:
                oneTabBarItem = vcs[index].tabBarItem
                oneTabBarItem?.selectedImage = UIImage(named: "homeicon_selected")?.withRenderingMode(.alwaysOriginal)
                oneTabBarItem?.image = UIImage(named: "homeicon")?.withRenderingMode(.alwaysOriginal)
                oneTabBarItem?.title = AppPlist.TabbarConfigText.homeText
            case 1:
                secTabBarItem = vcs[index].tabBarItem
                secTabBarItem?.selectedImage = UIImage(named: "cysocityicon_select")?.withRenderingMode(.alwaysOriginal)
                secTabBarItem?.image = UIImage(named: "cysocityicon")?.withRenderingMode(.alwaysOriginal)
                secTabBarItem?.title = AppPlist.TabbarConfigText.discoverText
            case 2:
                thiTabBarItem = vcs[index].tabBarItem
                thiTabBarItem?.selectedImage = UIImage(named: "usericon_selected")?.withRenderingMode(.alwaysOriginal)
                thiTabBarItem?.image = UIImage(named: "usericon")?.withRenderingMode(.alwaysOriginal)
                thiTabBarItem?.title = AppPlist.TabbarConfigText.myText
            default:break
            }
        }
        self.tabBar.tintColor =  UIColor(red: 80/255, green: 178/255, blue: 245/255, alpha: 1)
        self.tabBar.barTintColor = UIColor.white
        self.selectedIndex = 0

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
