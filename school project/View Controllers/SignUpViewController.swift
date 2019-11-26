//
//  SignUpViewController.swift
//  school project
//
//  Created by Khalid Elkilany on 2019-11-17.
//  Copyright © 2019 Khalid Elkilany. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      setUpElements()
            }
            
            func setUpElements(){
                //Hide the error label
                errorLabel.alpha = 0
                //Style the elements
                Utilities.styleTextField(firstNameTextField)
                Utilities.styleTextField(lastNameTextField)
                Utilities.styleTextField(emailTextField)
                Utilities.styleTextField(passwordTextField)
                Utilities.styleFilledButton(signUpButton)
                Utilities.styleFilledButton(signUpButton)

                
            }
            

            // Check the fields and validate that data is correct. if everything is correct this method returns nil.Otherwise it returns the error message
            func validateFields() ->String?{
                //check that all fields are filled in
                if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                
                return "Please fill in all fields"
            }
                //Check if password is secure
                let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                if Utilities.isPasswordValid(cleanedPassword) == false {
                    return"Please make sure your password is at least 8 characters, contains a special characters and a number"
                }
                return nil
        }
            
            
            @IBAction func signUpTapped(_ sender: Any) {
                //Validate the fields
                let error = validateFields()
                if error != nil{
                    
                    showError(error!)
                }
                else{
                    //Create cleaned versions of the data
                    let firstname = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    let lastname = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    //Create the user
                    Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                        //Check for errors
                        if err != nil{
                            self.showError("Error creating user")
                        }
                        else{
                            //User was created succssefully
                            let db = Firestore.firestore()
                            
                            db.collection("users").addDocument(data: ["firstname":firstname, "lastname":lastname, "uid":result!.user.uid]) { (error) in
                                if error != nil{
                                    self.showError("Error saving used data")
                                }
                            }
                            //Transition to quiz screen
                            self.transitionToHome()

                        }
                    
                    }
                           
                    
                }
                
               
            }
            func showError(_ message:String){
                
                errorLabel.text = message
                errorLabel.alpha = 1
            }
            func transitionToHome(){
                let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.HomeViewController) as? HomeViewController
                
                view.window?.rootViewController = homeViewController
                view.window?.makeKeyAndVisible()
                
            }

        }
