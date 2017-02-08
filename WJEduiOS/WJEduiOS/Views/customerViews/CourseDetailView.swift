//
//  CourseDetailView.swift
//  WJEduiOS
//
//  Created by samson on 25/1/2017.
//  Copyright © 2017 samson. All rights reserved.
//

import UIKit

class CourseDetailView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    weak var infoTitle:UILabel!
    weak var titleLabel:UILabel!
    
    weak var couseNeedKnowTitleLabel:UILabel!
    weak var teacherToldInfoTitleLabel:UILabel!
    
    weak var couseNeedKnowinfoLabel:UILabel!
    weak var teacherToldInfoLabel:UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let rootLayout = TGLinearLayout(.vert)
        rootLayout.backgroundColor = UIColor.white
        rootLayout.tg_width.equal(self.frame.width)
        rootLayout.tg_height.equal(.fill)
        rootLayout.tg_top.equal(2)
        self.addSubview(rootLayout)
        
        rootLayout.addSubview(self.createCourseInfoLayout())
        rootLayout.addSubview(self.createCourseDetaiInfoLayout())
        rootLayout.addSubview(self.createConnectCourseLayout())
    }
    
    func setCourseInfoModel(title:String,infotext:String) {
        self.titleLabel.text = title
        self.infoTitle.text = infotext
    }

    func setCourseNeadToKnowInfoModel(needtitle:String,needinfotext:String,teachtoldtitle:String,teachtoldtext:String) {
        self.couseNeedKnowTitleLabel.text = needtitle
        self.couseNeedKnowinfoLabel.text = needinfotext
        self.teacherToldInfoTitleLabel.text = teachtoldtitle
        self.teacherToldInfoLabel.text = teachtoldtext
    }

    func createConnectCourseLayout() -> TGLinearLayout {
        let actionLayout = TGLinearLayout(.vert)
        actionLayout.backgroundColor = UIColor.white
        actionLayout.tg_width.equal(self.frame.width)
        actionLayout.tg_height.equal(TGDimeAdapter.height(276))
        actionLayout.tg_bottomBorderline =  TGLayoutBorderline(color: AppPlist.lineColor)
        
        let titlelabel = UILabel()
        titlelabel.font = CFTool.fontCustomer(AppPlist.appPingFangMediumFontString, size: 14)
        titlelabel.textColor = CFTool.color(4)
        titlelabel.text = "相关计划"
        titlelabel.tg_width.equal(.fill)
        titlelabel.tg_top.equal(10)
        titlelabel.tg_height.equal(.wrap)
        titlelabel.sizeToFit()
        titlelabel.tg_left.equal(10)
        actionLayout.addSubview(titlelabel)
       

        
        let bottomScrollView = UIScrollView()
        bottomScrollView.tg_width.equal(.fill)
        bottomScrollView.tg_top.equal(10)
        bottomScrollView.tg_height.equal(TGDimeAdapter.height(220))
        bottomScrollView.backgroundColor = .white
        //        bottomScrollView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        bottomScrollView.contentSize = CGSize(width: 192*5, height: TGDimeAdapter.height(220))
        //        bottomScrollView.isPagingEnabled = true
        //        bottomScrollView.delegate = self
        actionLayout.addSubview(bottomScrollView)
        
        //创建课程模块信息视图
        for i in 0..<5{
            let view = UIView(frame: CGRect(x: 0+192*CGFloat(i), y: 0, width: 192, height: TGDimeAdapter.height(220)))
            
            let itemCourseLayout = self.createItemCourseLayout(imageName: "coursebg", title: "React Native 贯穿全栈", remark: "让你了解Java实战课程", price: 598.00, marketprice: 598.00,viewtag:100, action: #selector(handleCellLayoutTap(_:)))
            view.addSubview(itemCourseLayout)
            bottomScrollView.addSubview(view)
        }
        return actionLayout
    }
    
    func createCourseInfoLayout() -> TGLinearLayout {
        let actionLayout = TGLinearLayout(.vert)
        actionLayout.backgroundColor = UIColor.white
        actionLayout.tg_width.equal(self.frame.width)
        actionLayout.tg_height.equal(TGDimeAdapter.height(126))
        actionLayout.tg_bottomBorderline =  TGLayoutBorderline(color: AppPlist.lineColor)
        titleLabel = {
            let titlelabel = UILabel()
            titlelabel.font = CFTool.fontCustomer(AppPlist.appPingFangMediumFontString, size: 14)
            titlelabel.textColor = CFTool.color(4)
            titlelabel.tg_width.equal(.fill)
            titlelabel.tg_top.equal(20)
            titlelabel.tg_height.equal(.wrap)
            titlelabel.sizeToFit()
            titlelabel.tg_left.equal(15)
            actionLayout.addSubview(titlelabel)
            return titlelabel
        }()
       
        infoTitle = {
            let titlelabel = UILabel()
            titlelabel.font = CFTool.fontCustomer(AppPlist.appPingFangRegularFontString, size: 14)
            titlelabel.textColor = UIColor(red: 110/255, green: 110/255, blue: 110/255, alpha: 1)
            titlelabel.tg_width.equal(.fill)
            titlelabel.tg_top.equal(10)
            titlelabel.tg_height.equal(.wrap)
            titlelabel.sizeToFit()
            titlelabel.tg_left.equal(15)
            titlelabel.numberOfLines = 0
            actionLayout.addSubview(titlelabel)
            return titlelabel
        }()

        return actionLayout
    }

    
    func createCourseDetaiInfoLayout() -> TGLinearLayout {
        let actionLayout = TGLinearLayout(.vert)
        actionLayout.backgroundColor = UIColor.white
        actionLayout.tg_width.equal(self.frame.width)
        actionLayout.tg_height.equal(TGDimeAdapter.height(216))
        actionLayout.tg_bottomBorderline =  TGLayoutBorderline(color: AppPlist.lineColor)
        couseNeedKnowTitleLabel = {
            let titlelabel = UILabel()
            titlelabel.font = CFTool.fontCustomer(AppPlist.appPingFangMediumFontString, size: 14)
            titlelabel.textColor = CFTool.color(4)
            titlelabel.tg_width.equal(.fill)
            titlelabel.tg_top.equal(20)
            titlelabel.tg_height.equal(.wrap)
            titlelabel.sizeToFit()
            titlelabel.tg_left.equal(15)
            actionLayout.addSubview(titlelabel)
            return titlelabel
        }()
        
        couseNeedKnowinfoLabel = {
            let titlelabel = UILabel()
            titlelabel.font = CFTool.fontCustomer(AppPlist.appPingFangRegularFontString, size: 14)
            titlelabel.textColor = UIColor(red: 110/255, green: 110/255, blue: 110/255, alpha: 1)
            titlelabel.tg_width.equal(.fill)
            titlelabel.tg_top.equal(10)
            titlelabel.tg_height.equal(.wrap)
            titlelabel.sizeToFit()
            titlelabel.tg_left.equal(30)
            titlelabel.numberOfLines = 0
            actionLayout.addSubview(titlelabel)
            return titlelabel
        }()

        teacherToldInfoTitleLabel = {
            let titlelabel = UILabel()
            titlelabel.font = CFTool.fontCustomer(AppPlist.appPingFangMediumFontString, size: 14)
            titlelabel.textColor = CFTool.color(4)
            titlelabel.tg_width.equal(.fill)
            titlelabel.tg_top.equal(20)
            titlelabel.tg_height.equal(.wrap)
            titlelabel.sizeToFit()
            titlelabel.tg_left.equal(15)
            actionLayout.addSubview(titlelabel)
            return titlelabel
        }()
        
        teacherToldInfoLabel = {
            let titlelabel = UILabel()
            titlelabel.font = CFTool.fontCustomer(AppPlist.appPingFangRegularFontString, size: 14)
            titlelabel.textColor = UIColor(red: 110/255, green: 110/255, blue: 110/255, alpha: 1)
            titlelabel.tg_width.equal(.fill)
            titlelabel.tg_top.equal(10)
            titlelabel.tg_height.equal(.wrap)
            titlelabel.sizeToFit()
            titlelabel.tg_left.equal(30)
            titlelabel.numberOfLines = 0
            actionLayout.addSubview(titlelabel)
            return titlelabel
        }()

        return actionLayout
    }

    //模块课程点击事件执行
    func handleCellLayoutTap(_ sender:UIView) -> Void {
//        let supplementaryIndex = sender.tag / sBaseTag
//        let cellIndex = sender.tag % sBaseTag
        
    }

}
