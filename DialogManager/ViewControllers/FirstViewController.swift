//
//  FirstViewController.swift
//  DialogManager
//
//  Created by 유현재 on 22/05/2020.
//  Copyright © 2020 유현재. All rights reserved.
//

import UIKit

class FirstViewController: BaseViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewWillAppearDialog(id: "View1")
    }
       
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.viewWillDisappearDialog()
    }
       
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didTappedButton(_ sender: UIButton) {
        print("1")
        let alert = DialogFactory(id: "View1", deleteKey: "AAA", title: "test", message: "first View", preferredStyle: .alert, propertyType: .high)
        .addAction("ok", style: .default, handler: nil)
        .create()

        DialogManager().addAlert(alert)
        DialogManager().show()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            print("2")
//            let alert2 = AlertDialogFactory(id: "View1", deleteKey: "AAA", title: "test", message: "second View", preferredStyle: .alert, propertyType: .high)
//                .addAction("ok", style: .default, handler: nil)
//                .create()
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 300))
            view.backgroundColor = .blue
            let alert2 = DialogFactory(id: "View1", deleteKey: "AAA", alertView: view, propertyType: .high)
                .addAction("test", style: .default, moveView: false, handler: nil)
                .create()
            
            DialogManager().addAlert(alert2)
            DialogManager().show()
        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            print("3")
//            let alert2 = AlertDialogFactory(id: "View1", deleteKey: "AAA", title: "test", message: "third View", preferredStyle: .alert, propertyType: .high)
//                .addAction("ok", style: .default, handler: nil)
//                .create()
//
//            AlertDialogManager().addAlert(alert2)
//            AlertDialogManager().show()
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//            print("4")
//            let alert2 = AlertDialogFactory(id: "View1", deleteKey: "AAA", title: "test", message: "forth View", preferredStyle: .alert, propertyType: .high)
//                .addAction("ok", style: .default, handler: nil)
//                .create()
//
//            AlertDialogManager().addAlert(alert2)
//            AlertDialogManager().show()
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
//            print("5")
//            let alert2 = AlertDialogFactory(id: "Anywhere", deleteKey: "AAA", title: "test", message: "fifth View", preferredStyle: .alert, propertyType: .high)
//                .addAction("ok", style: .default, handler: nil)
//                .create()
//
//            AlertDialogManager().addAlert(alert2)
//            AlertDialogManager().show()
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//            print("6")
//            let alert2 = AlertDialogFactory(id: "View1", deleteKey: "AAA", title: "test", message: "sixth View", preferredStyle: .alert, propertyType: .high)
//                .addAction("ok", style: .default, handler: nil)
//                .setDeleteKey(id: "View1")
//                .create()
//
//            AlertDialogManager().addAlert(alert2)
//            AlertDialogManager().show()
//        }
        
        
        
        
        
        
        
        
        
        
        
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
//            print("3")
//            let alert3 = AlertDialogFactory(id: "View1", title: "test", message: "third View", preferredStyle: .alert, propertyType: .high)
//                .addAction("action3", style: .default, handler: { (action) in
//                    let coAlert = AlertDialogFactory(id: "View1", title: "test3-1", message: "ko third View", preferredStyle: .alert, propertyType: .normal)
//                        .addAction("move", style: .default, moveView: true, handler: { (action) in
//                            self.performSegue(withIdentifier: "push", sender: nil)
//                        })
//                        .create()
//
//                    AlertDialogManager().addAlert(coAlert, next: true)
//                    AlertDialogManager().show()
//                })
//            .create()
//
//            AlertDialogManager().addAlert(alert3)
//            AlertDialogManager().show()
//        }
//
////        DispatchQueue.main.asyncAfter(deadline: .now() + 9.0) {
////            self.performSegue(withIdentifier: "push", sender: nil)
////        }
    }
    
}

