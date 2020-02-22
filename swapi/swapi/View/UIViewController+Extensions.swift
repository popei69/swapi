//
//  UIViewController+Extensions.swift
//  swapi
//
//  Created by Benoit PASQUIER on 22/02/2020.
//  Copyright © 2020 Benoit Pasquier. All rights reserved.
//

import UIKit

extension UIViewController: Identifiable {
    var id: String { return self.description }
}

extension UIViewController {
    
    func showAlertWithError(_ error: Error?) {
        
        let errorType: ErrorType = (error as? ErrorType) ?? .unknown
        
        let alertController = UIAlertController(title: "An error occured", message: errorType.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
