//
//  BaseVC.swift
//  CoinApp
//
//  Created by OnurAlp on 17.10.2023.
//

import UIKit

protocol BaseDelegateProtocol {
    func createFailureAlert(failMessage: String)
}

class BaseVC: UIViewController {
    
}

extension BaseVC: BaseDelegateProtocol {
    func createFailureAlert(failMessage: String) {
        let alert = UIAlertController(title: "Alert", message: failMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

