//
//  
//  Winsharesapp
//
//  Created by samson on 24/12/2016.
//  Copyright © 2016 samson. All rights reserved.
//

import UIKit

class UserCommentTableViewCell: UITableViewCell {
    
    weak var userAvater:UIImageView!
    weak var username:UILabel!
    weak var likenum:UILabel!
    weak var likeicon:UIImageView!
    weak var timeLabel:UILabel!
    weak var commentLabel:UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createLinearRootLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //对于需要动态评估高度的UITableViewCell来说可以把布局视图暴露出来。用于高度评估和边界线处理。以及事件处理的设置。
    fileprivate(set) var rootLayout:TGBaseLayout!
    
    
    func setModel(model: CommentModel)
    {
        self.timeLabel.text = model.timeStreing
        self.commentLabel.text = model.commentString
        self.username.text = model.userName
        self.likeicon.image = UIImage(named: model.likeIconImageName)
        self.userAvater.image = UIImage(named: model.userAvaterImageName)
        self.likenum.text = NSString(format: "%d", model.likeNum) as String
        
    }
    
}

extension UserCommentTableViewCell{
    //用线性布局来实现UI界面
    func createLinearRootLayout()
    {
        /*
         在UITableViewCell中使用TGLayout中的布局时请将布局视图作为contentView的子视图。如果我们的UITableViewCell的高度是动态的，请务必在将布局视图添加到contentView之前进行如下设置：
         self.rootLayout.tg_width.equal(.fill)
         self.rootLayout.tg_height.equal(.wrap)
         */
        self.rootLayout = TGLinearLayout(.vert)
        self.rootLayout.tg_width.equal(.fill)
        self.rootLayout.tg_height.equal(.wrap)
        self.contentView.addSubview(self.rootLayout)
        rootLayout.tg_bottomBorderline = TGLayoutBorderline(color: AppPlist.lineColor)
        self.createUserInfoLayout(rootLayout: self.rootLayout as! TGLinearLayout)
        self.timeLabel = {
            let label = UILabel()
            label.textColor = CFTool.color(4)
            label.font = CFTool.fontCustomer(AppPlist.appPingFangRegularFontString, size: 10)
            label.tg_centerY.equal(0)
            label.tg_width.equal(.wrap)
            label.tg_height.equal(.wrap)
            label.tg_left.equal(TGDimeAdapter.width(45))
            label.tg_right.equal(10)
            label.tg_top.equal(-5)
            rootLayout.addSubview(label)
            return label
        }()
        
        self.commentLabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.textColor = CFTool.color(4)
            label.font = CFTool.fontCustomer(AppPlist.appPingFangRegularFontString, size: 14)
            label.tg_centerY.equal(0)
            label.tg_width.equal(.wrap)
            label.tg_height.equal(.wrap)
            label.tg_left.equal(30)
            label.tg_right.equal(30)
            label.tg_top.equal(10)
            label.tg_bottom.equal(20)
            rootLayout.addSubview(label)
            return label
        }()
        
    }
    
    
    func createUserInfoLayout(rootLayout:TGLinearLayout){
        let bgTopFlowLayout = TGLinearLayout(.horz)
        bgTopFlowLayout.tg_width.equal(.fill)
        bgTopFlowLayout.tg_height.equal(TGDimeAdapter.height(38))
        rootLayout.addSubview(bgTopFlowLayout)
        
        self.userAvater = {
            let imageView = UIImageView()
            imageView.tg_centerY.equal(0)
            imageView.tg_width.equal(TGDimeAdapter.width(20))
            imageView.tg_height.equal(TGDimeAdapter.width(20))
            imageView.tg_left.equal(10)
            //        let url = URL(string: AppConfiguration.WinsharesApp.baseImageUrl+dataUnit.goods_image)
            //        imageView.kf.setImage(with: url)
            bgTopFlowLayout.addSubview(imageView)
            return imageView
        }()
        
        self.username = {
            let label = UILabel()
            label.textColor = CFTool.color(4)
            label.font = CFTool.fontCustomer(AppPlist.appPingFangRegularFontString, size: 13)
            label.tg_centerY.equal(0)
            label.tg_width.equal(.wrap)
            label.tg_height.equal(.wrap)
            label.tg_left.equal(10)
            bgTopFlowLayout.addSubview(label)
            return label
        }()
        
        self.likenum = {
            let label = UILabel()
            label.textColor = CFTool.color(4)
            label.font = CFTool.fontCustomer(AppPlist.appPingFangRegularFontString, size: 13)
            label.textAlignment = .right
            label.tg_centerY.equal(0)
            label.tg_width.equal(.fill)
            label.tg_height.equal(.wrap)
//            label.tg_left.equal(80%)
            label.tg_right.equal(10)
            bgTopFlowLayout.addSubview(label)
            return label
        }()
        
        self.likeicon = {
            let imageView = UIImageView()
            imageView.tg_centerY.equal(0)
            imageView.tg_width.equal(TGDimeAdapter.width(15))
            imageView.tg_height.equal(TGDimeAdapter.width(15))
//            imageView.tg_left.equal(50%)
            imageView.tg_right.equal(20)
            //        let url = URL(string: AppConfiguration.WinsharesApp.baseImageUrl+dataUnit.goods_image)
            //        imageView.kf.setImage(with: url)
            bgTopFlowLayout.addSubview(imageView)
            return imageView
        }()
        
        
        
    }
    
    
}
