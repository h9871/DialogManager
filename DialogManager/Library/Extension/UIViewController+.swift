//
//  UIViewController+.swift
//  DialogManager
//
//  Created by 유현재 on 22/05/2020.
//  Copyright © 2020 유현재. All rights reserved.
//

import UIKit

extension UIViewController {
    
    ///
    /// 맨 앞의 ViewController를 취득
    ///
    /// - Parameter viewController: 기준ViewController
    /// - Returns: UIViewController
    class func topViewController(controller: UIViewController? = UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return self.topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController, let selected = tabController.selectedViewController {
            return self.topViewController(controller: selected)
        }
        if let presented = controller?.presentedViewController {
            return self.topViewController(controller: presented)
        }
        return controller
    }

    /// 맨 앞의 ViewController가 다이어로그인지 확인
    ///
    /// - Returns: Bool
    class func topViewControllerIsAlertController() -> Bool {
        return self.topViewController() is UIAlertController
    }
}

