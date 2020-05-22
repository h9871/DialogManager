//
//  UIAlertController+.swift
//  DialogManager
//
//  Created by 유현재 on 22/05/2020.
//  Copyright © 2020 유현재. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    ///
    /// 커스텀 다이어로그를 설정
    ///
    public func customViewAlert(_ view: UIView) {
        let input = view
        self.view.addSubview(input)
        
        let topMargin: CGFloat = 20.0
        let leftMargin: CGFloat = 16.0
        let btnHeight: CGFloat = 44.0
        let alertWidth = self.view.frame.size.width - (2 * leftMargin)
        
        let viewWidth = (alertWidth / input.frame.width) * input.frame.width
        let viewHeight = (alertWidth / input.frame.width) * input.frame.height
        
        input.frame = CGRect(x: leftMargin, y: topMargin, width: viewWidth, height: viewHeight)
        
        let indicatorConstraint = NSLayoutConstraint(item: self.view as Any, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: viewHeight + btnHeight + topMargin + leftMargin)
        indicatorConstraint.identifier = "indicatorConstraint"
        self.view.addConstraint(indicatorConstraint)
    }
}
