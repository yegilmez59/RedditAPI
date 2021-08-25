//
//  UIViewControllerExtensions.swift
//  RedditAPI
//
//  Created by Yagmur Egilmez on 8/24/21.
//

import UIKit

extension UIViewController {
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Something Went Wrong", message: message, preferredStyle: .alert)
        let acceptButton = UIAlertAction(title: "Okay", style: .default)
        alert.addAction(acceptButton)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
}
