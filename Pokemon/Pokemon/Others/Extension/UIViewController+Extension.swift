//
//  UIViewController+Extension.swift
//  Pokemon
//
//  Created by Vinicius on 09/05/18.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showLoader() {
        DispatchQueue.main.async {
            let loader = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            loader.center = UIApplication.shared.keyWindow?.center ?? CGPoint()
            loader.startAnimating()
            UIApplication.shared.windows.first?.addSubview(loader)
        }
    }
    
    func dismissLoader() {
        DispatchQueue.main.async {
            if let loader = UIApplication.shared.keyWindow?.subviews.filter({ $0 is UIActivityIndicatorView }) as? [UIActivityIndicatorView] {
                loader.forEach { $0.removeFromSuperview() }
            }
        }
    }
    
    func showDefaultAlert(message: String, completeBlock: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: "Aviso", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: completeBlock)
        alertController.addAction(action)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
