//
//  LoginSignUpTableViewController.swift
//  Chiropractic
//
//  Created by Nicholas Laughter on 1/17/17.
//  Copyright © 2017 Nicholas Laughter. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginSignUpTableViewController: UITableViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            passwordTextField.becomeFirstResponder()
        case 1:
            repeatPasswordTextField.becomeFirstResponder()
        case 2:
            resignFirstResponder()
            registerUser()
        default:
            break
        }
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        
    }
    
    func registerUser() {
        guard let email = emailTextField.text,
            let password = passwordTextField.text, password == repeatPasswordTextField.text else {
                displayAlertController(withErrorMessage: "There was a problem with your information. Please try again.")
                return
        }
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (_, error) in
            if let error = error {
                self.displayAlertController(withErrorMessage: error.localizedDescription)
            }
        })
    }
    
    func displayAlertController(withErrorMessage errorMessage: String) {
        let alertController = UIAlertController(title: "Oops!", message: "There was a problem.\n\(errorMessage)", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alertController.addAction(dismissAction)
        present(alertController, animated: true, completion: nil)
    }
}
