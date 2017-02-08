//
//  UIScrollAndTabView.swift
//  Winsharesapp
//
//  Created by samson on 1/12/2016.
//  Copyright © 2016 samson. All rights reserved.
//

import UIKit

class UIScrollAndTabView: UIView,TabIndexSelect{

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var tabClickProtocal:TabIndexClick?
    weak var underLineView:UIView!
    var itemChangedAction:((_ index:Int)->Void)!
    var rootLayout:TGFrameLayout!
    var tabCount = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        rootLayout = TGFrameLayout()
        rootLayout.tg_height.equal(.fill)
        rootLayout.tg_width.equal(.fill)
        rootLayout.backgroundColor = UIColor.white
        self.addSubview(rootLayout)
    
    }
    
    func initWithTabName(nameList:[String],isIcon:Bool,tabpos:Int){
        self.tabCount = nameList.count
        let leftItemLayout = self.createItemLayout(NSLocalizedString(
            nameList[0], comment: ""), withTag: 0,isIcon: isIcon)
        leftItemLayout.tg_left.equal(0)
        leftItemLayout.tg_height.equal(.fill)
        leftItemLayout.tg_width.equal(TGWeight(100/nameList.count))
        leftItemLayout.contentMode = .center
        leftItemLayout.tg_highlightedOpacity = 0.5
        rootLayout.addSubview(leftItemLayout)
        //多少个tab
        switch nameList.count {
        case 2:
            break
        case 3:
            let centerItemLayout = self.createItemLayout(NSLocalizedString(nameList[nameList.count-2], comment: ""), withTag: nameList.count-2,isIcon: isIcon)
            centerItemLayout.tg_centerX.equal(0)
            centerItemLayout.tg_height.equal(.fill)
            centerItemLayout.tg_width.equal(TGWeight(100/nameList.count))
            centerItemLayout.tg_highlightedOpacity = 0.5
            rootLayout.addSubview(centerItemLayout)
            
            break
        case 4:
            let centerLayout = TGFrameLayout()
            centerLayout.tg_height.equal(.fill)
            centerLayout.tg_width.equal(TGWeight(100.0/Float(nameList.count-2)))
            centerLayout.tg_centerX.equal(0)
            rootLayout.addSubview(centerLayout)
            
            let itemLayout = self.createItemLayout(NSLocalizedString(
                nameList[1], comment: ""), withTag: 1,isIcon: isIcon)
            itemLayout.tg_height.equal(.fill)
            itemLayout.tg_width.equal(TGWeight(100.0/2))
            itemLayout.tg_left.equal(0)
            itemLayout.tg_highlightedOpacity = 0.5
            centerLayout.addSubview(itemLayout)
            
            let itemLayout1 = self.createItemLayout(NSLocalizedString(
                nameList[2], comment: ""), withTag: 2,isIcon: isIcon)
            itemLayout1.tg_height.equal(.fill)
            itemLayout1.tg_width.equal(TGWeight(100.0/2))
            itemLayout1.tg_highlightedOpacity = 0.5
            itemLayout1.tg_right.equal(0)
            centerLayout.addSubview(itemLayout1)

            break
        case 5:
            let centerLayout = TGFrameLayout()
            centerLayout.tg_height.equal(.fill)
            centerLayout.tg_width.equal(TGWeight((100.0/Float(nameList.count))*3))
            centerLayout.tg_centerX.equal(0)
            rootLayout.addSubview(centerLayout)
            
            let itemLayout = self.createItemLayout(NSLocalizedString(
                nameList[1], comment: ""), withTag: 1,isIcon: isIcon)
            itemLayout.tg_height.equal(.fill)
            itemLayout.tg_width.equal(TGWeight(100.0/3))
            itemLayout.tg_left.equal(0)
            itemLayout.tg_highlightedOpacity = 0.5
            centerLayout.addSubview(itemLayout)
            
            let itemLayout1 = self.createItemLayout(NSLocalizedString(
                nameList[2], comment: ""), withTag: 2,isIcon: isIcon)
            itemLayout1.tg_height.equal(.fill)
            itemLayout1.tg_width.equal(TGWeight(100.0/3))
            itemLayout1.tg_highlightedOpacity = 0.5
            itemLayout1.tg_centerX.equal(0)
            centerLayout.addSubview(itemLayout1)

            let itemLayout2 = self.createItemLayout(NSLocalizedString(
                nameList[3], comment: ""), withTag: 3,isIcon: isIcon)
            itemLayout2.tg_height.equal(.fill)
            itemLayout2.tg_width.equal(TGWeight(100.0/3))
            itemLayout2.tg_highlightedOpacity = 0.5
            itemLayout2.tg_right.equal(0)
            centerLayout.addSubview(itemLayout2)

            break
        default:
            break
        }
        
        let rightItemLayout = self.createItemLayout(NSLocalizedString(
            nameList[nameList.count-1], comment: ""), withTag: nameList.count-1,isIcon: isIcon)
        rightItemLayout.tg_height.equal(.fill)
        rightItemLayout.tg_width.equal(TGWeight(100/nameList.count))
        rightItemLayout.tg_highlightedOpacity = 0.5
        rightItemLayout.contentMode = .center
        rightItemLayout.tg_right.equal(0)
        rootLayout.addSubview(rightItemLayout)
        
        let underLineView = UIView()
        underLineView.tg_height.equal(2)
        underLineView.tg_width.equal(TGWeight(100/(nameList.count*2)))
        var number = ((100/self.tabCount)/4)
        number = (number+(tabpos-1)*(100/self.tabCount))
        
        underLineView.tg_left.equal(number%)
//      self.underLineView.tg_left.equal((((100/self.tabCount)/4)+index*(100/self.tabCount))%)
        underLineView.tg_bottom.equal(0)
        underLineView.backgroundColor = UIColor(red: 80/255, green: 178/255, blue: 245/255, alpha: 1)
        rootLayout.addSubview(underLineView)
        self.underLineView = underLineView
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createItemLayout(_ title: String, withTag tag: Int,isIcon:Bool) -> TGFrameLayout {
        //创建一个框架条目布局，并设置触摸处理事件
        let itemLayout = TGFrameLayout()
        itemLayout.tag = tag
//        itemLayout.backgroundColor = CFTool.color(tag)
        itemLayout.tg_setTarget(self, action: #selector(self.handleTap),for:.touchUpInside)
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.sizeToFit()
        titleLabel.tg_centerY.equal(0) //标题尺寸由内容包裹，位置在布局视图中居中。
      
        if(isIcon){
            let itemTabLayout = TGLinearLayout(.horz)
            itemTabLayout.tg_height.equal(.wrap)
            itemTabLayout.tg_width.equal(.wrap)
            itemTabLayout.tg_centerX.equal(0)
            itemTabLayout.tg_centerY.equal(0)
            itemLayout.addSubview(itemTabLayout)
            
            itemTabLayout.addSubview(titleLabel)
            
            let imageView = UIImageView(image:UIImage(named:"downtriangle"))
            imageView.tg_height.equal(TGDimeAdapter.height(5))
            imageView.tg_width.equal(TGDimeAdapter.width(10))
            imageView.tg_centerY.equal(0)
            imageView.tg_left.equal(5)
            itemTabLayout.addSubview(imageView)
        }else{
            
            titleLabel.tg_centerX.equal(0)
            itemLayout.addSubview(titleLabel)
        }
    
        return itemLayout
    }
    
    func handleTap(_ sender: TGBaseLayout) {
        
        self.underLineView.tg_left.equal((((100/self.tabCount)/4)+sender.tag*(100/self.tabCount))%)
        self.underLineView.tg_centerX.equal(nil)
        self.underLineView.tg_right.equal(nil)
        
        self.tabClickProtocal?.tabClickAtIndex(index: sender.tag+1)
        
        let layout = sender.superview as! TGBaseLayout
        layout.tg_layoutAnimationWithDuration(0.2)
        
    }

    func tabIndexSelect(index: Int) {
        self.underLineView.tg_left.equal((((100/self.tabCount)/4)+index*(100/self.tabCount))%)
        self.underLineView.tg_centerX.equal(nil)
        self.underLineView.tg_right.equal(nil)
        
        let layout = self.rootLayout as TGBaseLayout
        layout.tg_layoutAnimationWithDuration(0.2)
    }


}
