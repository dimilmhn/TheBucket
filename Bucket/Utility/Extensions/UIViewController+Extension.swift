//
//  UIViewController+Extension.swift
//  Bucket
//
//  Created by Dimil T Mohan on 2021/09/29.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert( _ message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
