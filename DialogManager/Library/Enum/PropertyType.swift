//
//  PropertyType.swift
//  DialogManager
//
//  Created by 유현재 on 22/05/2020.
//  Copyright © 2020 유현재. All rights reserved.
//

import Foundation

/// 다이어로그 우선 순위
public enum PropertyType: Int {
    case high = 1
    case normal
    case low
    case unknown
    
    // don't put unknown
    static let order = [high, normal, low]
}

/// 어디에서나 표시 가능한 다이어로그
let ANYWHERE = "Anywhere"

