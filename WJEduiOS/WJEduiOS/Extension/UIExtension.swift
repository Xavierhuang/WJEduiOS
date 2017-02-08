//
//  UIExtension.swift
//  Winsharesapp
//
//  Created by samson on 1/12/2016.
//  Copyright © 2016 samson. All rights reserved.
//

import Foundation
import UIKit


extension UIColor{
}

extension String{
    func isPurnInt(string: String) -> Bool {
        let scan: Scanner = Scanner(string: string)
        var val:Int = 0
        return scan.scanInt(&val) && scan.isAtEnd
    }

}
