//
//  LogInViewController.swift
//  school project
//
//  Created by Fahed Yousef on 2019-11-18.
//  Copyright © 2019 Khalid Elkilany. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class LogInViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setUpElements()
            }
            func setUpElements(){
                
                errorLabel.alpha = 0
                //Style the elements
                Utilities.styleTextField(emailTextField)
                Utilities.styleTextField(passwordTextField)
                Utilities.styleFilledButton(logInButton)
                Utilities.styleFilledButton(logInButton)

            
            
            
            }

            @IBAction func logInTapped(_ sender: Any) {
                //Validate text field
                
                //MARK:Create cleaned version of the text
                let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                
                //MARK:signing in the user
                Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                    if error != nil{
                        self.errorLabel.text = error!.localizedDescription
                        self.errorLabel.alpha = 1
                    }
                    else{
                        let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.HomeViewController) as? HomeViewController
                        
                        self.view.window?.rootViewController = homeViewController
                        self.view.window?.makeKeyAndVisible()
                    }
                }
                
            }
        }
