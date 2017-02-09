//
//  CourseTypeViewController.swift
//  WJEduiOS
//
//  Created by fengzhongqian123 on 2/8/17.
//  Copyright © 2017 samson. All rights reserved.
//
//Hhwj65377068
import UIKit

class CourseTypeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
//dose not conform to protocol 'UICollectionViewDataSource'
    
    override func loadView() {
        
    let rootView = UIView()
    self.view = rootView
    rootView.backgroundColor = AppPlist.mainViewBgColor
    let rootLayout = TGLinearLayout(.vert)
        rootLayout.tg_width.equal(.fill)
        rootLayout.tg_height.equal(.fill)
        rootView.addSubview(rootLayout)
        let collectionLayout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: collectionLayout)
        collectionView.tg_height.equal(.fill)
        collectionView.tg_width.equal(.fill)
        collectionView.backgroundColor = AppPlist.mainViewBgColor
        collectionView.delegate = self
        collectionView.dataSource = self
        rootLayout.addSubview(collectionView)
        collectionView.register(UINib.init(nibName: "CourseTypeViewCell", bundle: nil), forCellWithReuseIdentifier: "CourseTypeViewCell")
        collectionView.register(UINib.init(nibName: "CourseTypeHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CourseTypeHeaderView")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeBackButton(#selector(self.rightBarButtonAction(_:)), title:"课程" ,viewController: self)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:Delegate & DataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize.init(width: screenBounds.width , height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: "CourseTypeViewCell", for: indexPath)
        cell.backgroundColor = UIColor.white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = CourseDetailController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (screenBounds.width) / 3, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CourseTypeHeaderView", for: indexPath)
        headerView.backgroundColor = UIColor.white
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.init(width: 0, height: 10)
    }
}

extension CourseTypeViewController:NavigationP{
    /**
     导航栏右键
     */
    func rightBarButtonAction(_ sender: AnyObject){
        self.navigationController!.popViewController(animated: true)
    }
}
