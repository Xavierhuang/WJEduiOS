//
//  CourseTitleListView.swift
//  WJEduiOS
//
//  Created by samson on 24/1/2017.
//  Copyright © 2017 samson. All rights reserved.
//

import UIKit

class CourseTitleListView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var titleListView:UITableView!
    let courseTitleTableViewCell = "CourseTitleTableViewCell"
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleListView = UITableView(frame: CGRect(x: 0, y: 1, width: frame.width, height: frame.height))
        
        titleListView.backgroundColor = AppPlist.mainViewBgColor
        self.addSubview(titleListView)
        
        titleListView.delegate = self
        titleListView.dataSource = self
        titleListView.separatorStyle = .none
        
        titleListView.register(CourseTitleTableViewCell.self, forCellReuseIdentifier: courseTitleTableViewCell)
    }

}
extension CourseTitleListView:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
    
        let actionLayout = TGLinearLayout(.vert)
        actionLayout.backgroundColor = UIColor.white
       
        actionLayout.tg_leftPadding = 10
        actionLayout.tg_rightPadding = 10
        actionLayout.tg_width.equal(tableView.frame.width)
        actionLayout.tg_height.equal(40)
        actionLayout.tg_bottomBorderline =  TGLayoutBorderline(color: AppPlist.lineColor)
        headView.addSubview(actionLayout)
        let label = UILabel()
        headView.backgroundColor = .white
        label.font = CFTool.fontCustomer(AppPlist.appPingFangMediumFontString, size: 14)
        label.textColor = CFTool.color(4)
        label.tg_width.equal(.fill)
        label.tg_centerY.equal(0)
        label.tg_height.equal(40)
        label.sizeToFit()
        //        label.tag = 1000
        label.tg_left.equal(0)
        actionLayout.addSubview(label)
        label.text = AppPlist.CourseTextList.SessionTitleList[section]
        return headView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        // 注意这里。为了达到动态高度TableViewCell的加载性能最高以及高性能，一定要实现estimatedHeightForRowAtIndexPath这个方法。这个方法用来评估
        //UITableViewCell的高度。如果实现了这个方法，系统会根据数量重复调用这个方法，得出评估的总体高度。然后再根据显示的需要调用heightForRowAtIndexPath方法来确定真实的高度。如果您不实现estimatedHeightForRowAtIndexPath这个方法，加载性能将非常的低下！！！！
        return 40  //这个评估尺寸你可以根据你的cell的一般高度来设置一个最合适的值。
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CourseTitleTableViewCell = tableView.dequeueReusableCell(withIdentifier: courseTitleTableViewCell) as! CourseTitleTableViewCell
        cell.setModel(infotext:  AppPlist.CourseTextList.CourseTitleList[indexPath.section][indexPath.row],timetext: AppPlist.CourseTextList.CourseTimeList[indexPath.section][indexPath.row])
        
        return cell;
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return AppPlist.CourseTextList.SessionTitleList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0{
//            return AppPlist.UserViewConfigText.UserViewConfigTextTop.count
//        }else if section == 1{
//            return AppPlist.UserViewConfigText.UserViewConfigTextBottom.count
//        }
        return AppPlist.CourseTextList.CourseTitleList[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cell = self.tableView(tableView,cellForRowAt:indexPath) as! CourseTitleTableViewCell
        
        
        let size = cell.rootLayout.tg_sizeThatFits(CGSize(width:tableView.frame.width, height:0))
        return size.height  //如果使用系统自带的分割线，请返回rect.size.height+1
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
       // eventHandler?.toNextViewController(sessionIndex:indexPath.section,rowIndex:indexPath.row)
        
        
    }

}
