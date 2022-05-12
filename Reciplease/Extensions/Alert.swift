//
//  Alert.swift
//  Reciplease
//
//  Created by Nicolas Demange on 05/05/2022.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(message: String) {
        let alertController: UIAlertController = .init(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }
}
