//
//  ViewController.swift
//  school project
//
//  Created by Khalid Elkilany on 2019-11-17.
//  Copyright © 2019 Khalid Elkilany. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()

        }
        
        func setUpElements(){
            Utilities.styleFilledButton(signUpButton)
            Utilities.styleHollowButton(logInButton)
        }

}
