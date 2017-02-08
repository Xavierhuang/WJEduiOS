//
//  ImageButton.swift
//  Winsharesapp
//
//  Created by samson on 29/11/2016.
//  Copyright © 2016 samson. All rights reserved.
//

import UIKit

class ImageButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let imageView = UIImageView(image:UIImage(named:"todayhoticon"))
        imageView.contentMode = .center
        imageView.tg_height.equal(TGDimeAdapter.height(23))
        imageView.tg_width.equal(TGWeight(100.0/(CGFloat(4)))) //这里三个，第一个占用全部的1/3，第二个占用剩余的1/2，第三个占用剩余的1/1。这样就实现了均分宽度的效果。
        imageView.tg_top.equal(TGDimeAdapter.height(10))
        self.addSubview(imageView)
        self.setTitle(NSLocalizedString("特惠菜品", comment:""), for: .normal)
//        rightButton.addTarget(self, action: #selector(handleShowBrother), for: .touchUpInside)
        self.backgroundColor = CFTool.color(7)
        self.titleLabel!.font = CFTool.font(14)
        self.sizeToFit()
        self.tg_width.equal(.average)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


}
