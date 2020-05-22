//
//  DialogFactory.swift
//  DialogManager
//
//  Created by 유현재 on 22/05/2020.
//  Copyright © 2020 유현재. All rights reserved.
//

import UIKit

public class DialogFactory: NSObject {
    
    /// 화면 id
    private var id: String?
    
    /// 삭제용 id
    private var deleteKey: String
    
    /// 다이어로그 우선 순위
    private var propertyType: PropertyType = .unknown
    
    /// 생성 다이어로그
    private var alertController: UIAlertController?
    
    /// 커스텀 다이어로그
    private var alertView: UIView?
    
    /// 캔슬 액션
    private var action: UIAlertAction?
    
    /// 액션 리스트
    private var actionList: [UIAlertAction] = []
    
    ///
    /// initializer 다이어로그 생성
    ///
    public init(id: String, deleteKey: String, title: String?, message: String?, preferredStyle: UIAlertController.Style, propertyType: PropertyType) {
        self.id = id
        self.deleteKey = deleteKey
        self.propertyType = propertyType
        self.alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
    }
    
    ///
    /// 커스텀 뷰를 통한 다이어로그 생성
    ///
    public init(id: String, deleteKey: String, alertView: UIView, propertyType: PropertyType) {
        self.id = id
        self.deleteKey = deleteKey
        self.propertyType = propertyType
        self.alertView = alertView
    }
}

///
/// MARK:- 데이터 취득 시
///
extension DialogFactory {
    
    ///
    /// id
    ///
    public func getId() -> String {
        return self.id ?? ""
    }
    
    ///
    /// 삭제용 id
    ///
    public func getDeleteKey() -> String {
        return self.deleteKey
    }
    
    ///
    /// 우선 순위
    ///
    public func getPropertyType() -> PropertyType {
        return self.propertyType
    }
    
    ///
    /// 다이어로그
    ///
    public func getAlertController() -> UIAlertController? {
        return self.alertController
    }
    
    ///
    /// 커스텀 뷰
    ///
    public func getAlertView() -> UIView? {
        return self.alertView
    }
    
    ///
    /// 캔슬 액션
    ///
    public func getCancelAction() -> UIAlertAction? {
        return self.action
    }
    
    ///
    /// 액션 리스트
    ///
    public func getActionList() -> [UIAlertAction] {
        return self.actionList
    }
}

///
/// MARK:- 다이어로그 생성
///
extension DialogFactory {
    
    ///
    /// 완전체 다이어로그를 생성
    /// Parameters:
    ///  - next : 다이어로그 액션 핸들러를 통하여 새로운 다이어로그를 생성할 경우 연속으로 표시하기 위한 플래그
    ///
    public func create() -> Self {
        for action in self.actionList {
            self.alertController?.addAction(action)
        }
        
        if self.action != nil, let action = self.action {
            self.alertController?.addAction(action)
        }
        
        return self
    }
    
    public func setDeleteKey(id: String? = nil, deleteKey: String? = nil) -> Self {
        DialogQueue.shared.removeDeleteKeyQueue(id, deleteKey)
        return self
    }
}

///
/// MARK:- 다이어로그 액션 설정
///
extension DialogFactory {
    
    ///
    /// 커스텀 액션 리스트 생성
    /// Parameters:
    ///  - title : Action타이틀
    ///  - style: Action스타일
    ///  - moveView: 핸들러를 통하여 화면 전환이 있을 경우
    ///  - handler: 핸들러
    ///
    public func addAction(_ title: String = "OK",
                      style: UIAlertAction.Style,
                      moveView: Bool = false,
                      handler: ((UIAlertAction) -> Void)? = nil) -> Self {
        self.actionList.append(UIAlertAction(title: title, style: style) { (action: UIAlertAction!) -> Void in
            if let aHandler = handler {
                aHandler(action)
            }
            if !moveView { DialogManager().show() }
        })
        return self
    }
    
    ///
    /// 캔슬 액션 생성
    /// Parameters:
    ///  - moveView: 핸들러를 통하여 화면 전환이 있을 경우
    ///
    public func cancelAction(_ title: String = "cancel",
                             moveView: Bool = false,
                             handler: ((UIAlertAction) -> Void)? = nil) -> Self {
        self.action = UIAlertAction(title: title, style: .cancel) { (sender) -> Void in
            if let aHandler = handler {
                aHandler(sender)
            }
            if !moveView { DialogManager().show() }
        }
        return self
    }
}

