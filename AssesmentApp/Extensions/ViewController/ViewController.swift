//
//  ViewController.swift
//  AssesmentApp
//
//  Created by Irfan Saeed on 26/10/2022.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .`default`, handler: { _ in
        }))
        present(alert, animated: true, completion: nil)
    }
}

extension UIViewController {
    func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        if let navController = self.navigationController {
            navController.view.endEditing(true)
        }
    }
}
