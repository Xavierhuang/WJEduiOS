//
//  UserCommentListView.swift
//  WJEduiOS
//
//  Created by samson on 25/1/2017.
//  Copyright © 2017 samson. All rights reserved.
//

import UIKit

class UserCommentListView: UIView {

    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    var titleListView:UITableView!
    let userCommentTableViewCell = "UserCommentTableViewCell"
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
        
        titleListView.register(UserCommentTableViewCell.self, forCellReuseIdentifier: userCommentTableViewCell)
    }
    
}
extension UserCommentListView:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
        
    }
    
    
  
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        // 注意这里。为了达到动态高度TableViewCell的加载性能最高以及高性能，一定要实现estimatedHeightForRowAtIndexPath这个方法。这个方法用来评估
        //UITableViewCell的高度。如果实现了这个方法，系统会根据数量重复调用这个方法，得出评估的总体高度。然后再根据显示的需要调用heightForRowAtIndexPath方法来确定真实的高度。如果您不实现estimatedHeightForRowAtIndexPath这个方法，加载性能将非常的低下！！！！
        return 100  //这个评估尺寸你可以根据你的cell的一般高度来设置一个最合适的值。
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UserCommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: userCommentTableViewCell) as! UserCommentTableViewCell
        
      let userCommentModel = CommentModel()
            userCommentModel.userAvaterImageName = "wechatlogin"
            userCommentModel.likeNum = 1
            userCommentModel.likeIconImageName = "likeicon"
            userCommentModel.userName = "小哲sunflower"
            userCommentModel.commentString = "作为一个初学者，这个教程非常好，也很适合在上班的时候学习，很容易理解~!"
            userCommentModel.timeStreing = "1小时前"
          
        
        cell.setModel(model: userCommentModel)
        
        return cell;
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        if section == 0{
        //            return AppPlist.UserViewConfigText.UserViewConfigTextTop.count
        //        }else if section == 1{
        //            return AppPlist.UserViewConfigText.UserViewConfigTextBottom.count
        //        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cell = self.tableView(tableView,cellForRowAt:indexPath) as! UserCommentTableViewCell
        
        
        let size = cell.rootLayout.tg_sizeThatFits(CGSize(width:tableView.frame.width, height:0))
        return size.height  //如果使用系统自带的分割线，请返回rect.size.height+1
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        // eventHandler?.toNextViewController(sessionIndex:indexPath.section,rowIndex:indexPath.row)
    }
    
}
