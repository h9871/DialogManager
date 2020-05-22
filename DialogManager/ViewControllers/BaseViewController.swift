//
//  BaseViewController.swift
//  DialogManager
//
//  Created by 유현재 on 22/05/2020.
//  Copyright © 2020 유현재. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func viewWillAppearDialog(id: String) {
        // 화면 전환 시 새로운 다이어로그를 표시
        DialogManager().willShow(id)
    }
    
    func viewWillDisappearDialog() {
        // 화면 전환 시 기존의 다이어로그를 닫기
        DialogManager().dismissAlert(viewChange: true)
    }
}
