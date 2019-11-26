//
//  HomeViewController.swift
//  school project
//
//  Created by Khalid Elkilany on 2019-11-17.
//  Copyright © 2019 Khalid Elkilany. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class HomeViewController: UIViewController {
    @IBOutlet weak var lastScore: UILabel!
    
    @IBOutlet weak var homeNavbar: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 100);
        let db = Firestore.firestore();
        let user = Auth.auth().currentUser;
        if user != nil {
            let dbDoc = db.collection("users").document(user?.uid ?? "")
            dbDoc.getDocument { (document, error) in
                if let document = document, document.exists{
                    let score = document.get("score").map(String.init(describing:)) ?? "nil"
                    self.lastScore.text = score
                    } else {
                        print("Document does not exist")
                    }
                }
            }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
