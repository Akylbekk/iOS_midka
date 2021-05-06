//
//  RegistrationViewController.swift
//  Chat
//
//  Created by Bagdat on 5/6/21.
//

import UIKit
import Firebase

class RegistrationViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        registerButton.layer.cornerRadius = 4
        registerButton.layer.masksToBounds = true
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self ] (result, error) in
            if let error = error {
                print(error)
            } else {
                self?.performSegue(withIdentifier: "goToChatFromRegistration", sender: nil)
            }
        }
        
    }
}
