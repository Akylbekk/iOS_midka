//
//  ChatViewController.swift
//  Chat
//
//  Created by Bagdat on 5/6/21.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var inputContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputTextField.delegate = self
        
        let tapOnTableView = UITapGestureRecognizer(target: self, action: #selector(tappedOnTableView))
        tableView.addGestureRecognizer(tapOnTableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        guard let message = inputTextField.text else { return }
        guard let email = Auth.auth().currentUser?.email else { return }
        
        let messagesDB = Database.database().reference().child("Messages")
        let messageDict = ["sender": email, "message": message]
       
        inputTextField.text = " "
        sendButton.isEnabled = false
        
        messagesDB.childByAutoId().setValue(messageDict) { [weak self] (error, reference) in
            if error != nil {
                print("Failed to send message, \(error!)")
            } else {
                self?.sendButton.isEnabled = true
            }
        }
    }
    
    @IBAction func signOutButtonPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.navigationController?.popToRootViewController(animated: true)
        } catch {
            print("Failed to Sign Out, \(error)")
        }
    }
    
    @objc func tappedOnTableView() {
        inputTextField.endEditing(true)
    }
}

extension ChatViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.inputContainerHeightConstraint.constant = 50 + 250
        } completion: { (_) in }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.4) {
            self.inputContainerHeightConstraint.constant = 50
        }
    }
}

extension ChatViewController: UITableViewDelegate {
    
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    
}
