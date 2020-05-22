//
//  DialogQueue.swift
//  DialogManager
//
//  Created by 유현재 on 22/05/2020.
//  Copyright © 2020 유현재. All rights reserved.
//

import UIKit

public class DialogQueue {
    
    /// DialogQueue Singleton
    public static let shared: DialogQueue = DialogQueue()
    
    /// 큐
    private var viewDictionary = [String : Dictionary<PropertyType, [DialogFactory]>]()
    
    /// 화면의 id
    private var viewId: String?
    
    /// initializer
    public init() {}
}

///
/// MARK:- 화면 id 설정
///
extension DialogQueue {
    
    /// 표시중인 화면의 id를 저장
    public func setViewId(id: String?) {
        self.viewId = id
    }
    
    /// 화면의 id
    public func getViewId() -> String? {
        return self.viewId
    }
}

///
/// MARK:- 큐 관리
///
extension DialogQueue {
    
    ///
    /// 큐 입력
    ///
    public func addQueue(_ alert: DialogFactory, _ next: Bool = false) {
        if let view = self.viewDictionary[alert.getId()] {
            if var arr = view[alert.getPropertyType()] {
                next ? arr.append(alert) : arr.insert(alert, at: 0)
                self.viewDictionary[alert.getId()]?.updateValue(arr, forKey: alert.getPropertyType())
            } else {
                self.viewDictionary[alert.getId()]?.updateValue([alert], forKey: alert.getPropertyType())
            }
        } else {
            self.viewDictionary.updateValue([alert.getPropertyType() : [alert]], forKey: alert.getId())
        }
    }
    
    ///
    /// 삭제 id를 통한 큐 내용 삭제
    ///
    public func removeDeleteKeyQueue(_ id: String?, _ deleteKey: String?) {
        if let id = id {
            guard let idDictionary = self.viewDictionary[id] else {
                return
            }
            
            if let deleteKey = deleteKey {
                // 1
                for (pKey, pValue) in idDictionary {
                    self.viewDictionary[id]?.updateValue(pValue.filter {
                        $0.getDeleteKey() != deleteKey
                    }, forKey: pKey)
                }
            } else {
                // 2
                self.viewDictionary[id] = nil
            }
        } else if let deleteKey = deleteKey {
            // 2
            for (idKey, idValue) in self.viewDictionary {
                for (pKey, pValue) in idValue {
                    self.viewDictionary[idKey]?.updateValue(pValue.filter {
                        $0.getDeleteKey() != deleteKey
                    }, forKey: pKey)
                }
            }
        } else {
            // 3
            self.viewDictionary.removeAll()
        }
    }
    
    ///
    /// 순번 출력 시 큐 삭제
    ///
    public func removeShowLastQueue(_ showAlert: DialogFactory) {
        if let view = self.viewDictionary[showAlert.getId()] {
            if var arr = view[showAlert.getPropertyType()] {
                arr.removeLast()
                self.viewDictionary[showAlert.getId()]?.updateValue(arr, forKey: showAlert.getPropertyType())
            }
        }
    }
    
    ///
    /// 다음 출력 데이터 반환
    ///
    public func nextAlertController() -> DialogFactory? {
        guard let id = self.getViewId() else {
            return nil
        }
        
        // Anywhereのタイプをまずチェックする
        if let anywhereQueue = self.viewDictionary[ANYWHERE] {
            for type in PropertyType.order {
                if let typeQueue = anywhereQueue[type], typeQueue.count > 0 {
                    return typeQueue.last
                } else if let viewQueue = self.viewDictionary[id] {
                    if let typeQueue = viewQueue[type], typeQueue.count > 0 {
                        return typeQueue.last
                    }
                }
            }
        } else if let viewQueue = self.viewDictionary[id] {
            for type in PropertyType.order {
                if let typeQueue = viewQueue[type], typeQueue.count > 0 {
                    return typeQueue.last
                }
            }
        }
        return nil
        
//        이전 로직
//        if let anywhereView = self.viewDictionary[ANYWHERE] {
//            if let anywhereArr = anywhereView[.high], anywhereArr.count > 0 {
//                return anywhereArr.last
//            } else if let anywhereArr = anywhereView[.normal], anywhereArr.count > 0 {
//                // normal系を確認する時には、まず画面系にhighがないかを確認してそちらを出す。
//                if let view = self.viewDictionary[id],
//                    let arr = view[.high], arr.count > 0 {
//                    return arr.last
//                } else {
//                    return anywhereArr.last
//                }
//            } else if let anywhereArr = anywhereView[.low], anywhereArr.count > 0 {
//                if let view = self.viewDictionary[id],
//                    let arr = view[.high], arr.count > 0 {
//                    return arr.last
//                } else if let view = self.viewDictionary[id],
//                    let arr = view[.normal], arr.count > 0 {
//                    return arr.last
//                } else {
//                    return anywhereArr.last
//                }
//            } else {
//                if let view = self.viewDictionary[id] {
//                    if let arr = view[.high], arr.count > 0 {
//                        return arr.last
//                    } else if let arr = view[.normal], arr.count > 0 {
//                        return arr.last
//                    } else if let arr = view[.low], arr.count > 0 {
//                        return arr.last
//                    }
//                }
//            }
//        } else if let view = self.viewDictionary[id] {
//            if let arr = view[.high], arr.count > 0 {
//                return arr.last
//            } else if let arr = view[.normal], arr.count > 0 {
//                return arr.last
//            } else if let arr = view[.low], arr.count > 0 {
//                return arr.last
//            }
//        }
//        return nil
    }
}

