//
//  DialogManager.swift
//  DialogManager
//
//  Created by 유현재 on 22/05/2020.
//  Copyright © 2020 유현재. All rights reserved.
//

import UIKit

public class DialogManager {
    
    /// 표시중인 다이어로그
    public static var showAlertController: DialogFactory?
    
    /// 화면 전환 시 실행
    public func willShow(_ id: String) {
        // 화면에서 표시해야 하는 화면 id를 저장
        DialogQueue.shared.setViewId(id: id)
        
        guard let lastAlert = self.getLastAlert() else {
            return
        }
        
        if let alert = lastAlert.getAlertController() {
            UIViewController.topViewController()?.present(alert, animated: true, completion: nil)
        } else if let view = lastAlert.getAlertView() {
            let viewAlert = UIAlertController(title: "", message: "", preferredStyle: .alert)
            for action in lastAlert.getActionList() {
                viewAlert.addAction(action)
            }
            
            if let action = lastAlert.getCancelAction() {
                viewAlert.addAction(action)
            }
            UIViewController.topViewController()?.present(viewAlert, animated: true) {
                viewAlert.customViewAlert(view)
            }
        } else {
            return
        }
    }
    
    /// 다이어로그 표시
    public func show() {
        guard let lastAlert = self.getLastAlert() else {
            return
        }
        
        if let alert = lastAlert.getAlertController() {
            UIViewController.topViewController()?.present(alert, animated: true, completion: nil)
        } else if let view = lastAlert.getAlertView() {
            let viewAlert = UIAlertController(title: "", message: "", preferredStyle: .alert)
            for action in lastAlert.getActionList() {
                viewAlert.addAction(action)
            }
            
            if let action = lastAlert.getCancelAction() {
                viewAlert.addAction(action)
            }
            UIViewController.topViewController()?.present(viewAlert, animated: true) {
                viewAlert.customViewAlert(view)
            }
        } else {
            return
        }
    }
}

extension DialogManager {
    
    /// 현재 표시 중인 다이어로그 정보 저장
    public func setShowAlertController(showAlert: DialogFactory?) {
        DialogManager.showAlertController = showAlert
    }
      
    /// 현재 표시 중인 다이어로그 정보
    public func getShowAlertController() -> DialogFactory? {
        return DialogManager.showAlertController
    }
}

/// MARK:- 큐 조작

extension DialogManager {
    
    /// 생성된 다이어로그 큐에 저장
    public func addAlert(_ alert: DialogFactory, next: Bool = false) {
        /// 현재 표시중인 다이어로그가 없다면 nil 저장
        if !UIViewController.topViewControllerIsAlertController() {
            self.setShowAlertController(showAlert: nil)
        }
        
        /// 큐 저장
        DialogQueue.shared.addQueue(alert, next)
    }
    
    /// 큐에서 출력해야 하는 다이어로그 습득
    private func getLastAlert() -> DialogFactory? {
         /// inner func
         /// 다이어로그 표시 교환 조건
         func isDismissTopAlertViewController() -> Bool {
            if let showAlert = self.getShowAlertController(),
                let nextAlert = DialogQueue.shared.nextAlertController() {
                if (showAlert.getPropertyType().rawValue == nextAlert.getPropertyType().rawValue),
                    showAlert.getId() != ANYWHERE, nextAlert.getId() == ANYWHERE {
                     return true
                 }
                 else if (showAlert.getPropertyType().rawValue > nextAlert.getPropertyType().rawValue) {
                     return true
                 }
             }
             return false
         }
        /// inner func end
         
         if UIViewController.topViewControllerIsAlertController() {
             guard isDismissTopAlertViewController() else { return nil }
             self.dismissAlert()
         } else if let showAlert = DialogQueue.shared.nextAlertController() {
            DialogQueue.shared.removeShowLastQueue(showAlert)
            self.setShowAlertController(showAlert: showAlert)
            return showAlert
         }
         return nil
    }

    /// 현재 표시 중인 다이어로그를 닫기
    public func dismissAlert(viewChange: Bool = false) {
        /// 화면 전환 시 닫을 경우에는 애니메이션 영향으로 출력이 늦춰쳐 무시되어버리기 때문에 애니메이션을 실행하지 않는다.
        let animated = viewChange ? false : true
         
        // 닫기 실행
        if let top = UIViewController.topViewController(), UIViewController.topViewControllerIsAlertController() {
            top.dismiss(animated: animated, completion: {
                if let showAlert = self.getShowAlertController() {
                    DialogQueue.shared.addQueue(showAlert, true)
                    if !viewChange {
                        self.show()
                    }
                 }
             })
         }
     }
}

