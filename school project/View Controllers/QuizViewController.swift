//
//  QuizViewController.swift
//  school project
//
//  Created by Khalid Elkilany on 2019-11-18.
//  Copyright © 2019 Khalid Elkilany. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class QuizViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    var rightAnswer = ""
    var alreadyClicked = false
    var score = 0
    var currentQuestion = 0
    var allQuestions:[Questions] = []
    
    var ref: DatabaseReference!
    
    struct Questions {
        var Answer1:String = "";
        var Answer2:String = ""
        var Answer3:String = ""
        var Question:String = ""
        var RightAnswer:String = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

         self.ref = Database.database().reference()
         var count = 0;
         self.ref.child("Question").observe(.value) { (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                let value = child.value as? [String:AnyObject];
                count += 1
                self.allQuestions.append(
                    Questions(
                        Answer1: value?["Answer1"] as? String ?? "",
                        Answer2: value?["Answer2"] as? String ?? "",
                        Answer3: value?["Answer3"] as? String ?? "",
                        Question: value?["Question"] as? String ?? "",
                        RightAnswer: value?["RightAnswer"] as? String ?? ""
                    )
                )
            }
            self.displayOneQuestion()
        }
    }
    
    
    

    @IBAction func option1Tapped(_ sender: Any) {
        if option1.titleLabel?.text == self.rightAnswer && !alreadyClicked  {
            option1.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            score += 1
            alreadyClicked = true
        }   else if option1.titleLabel?.text != self.rightAnswer && !alreadyClicked {
            alreadyClicked = true
            option1.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        }
            
    }
    
    @IBAction func option2Tapped(_ sender: Any) {
        if option2.titleLabel?.text == self.rightAnswer && !alreadyClicked  {
            option2.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            score += 1
            alreadyClicked = true
        }   else if option2.titleLabel?.text != self.rightAnswer && !alreadyClicked {
            alreadyClicked = true
            option2.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        }
        
    }
    
    @IBAction func option3Tapped(_ sender: Any) {
        if option3.titleLabel?.text == self.rightAnswer && !alreadyClicked  {
            option3.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            score += 1
            alreadyClicked = true
        }   else if option3.titleLabel?.text != self.rightAnswer && !alreadyClicked {
            alreadyClicked = true
            option3.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        }
    }
    @IBAction func nextTapped(_ sender: Any) {
        if currentQuestion < 10{
            option1.backgroundColor = #colorLiteral(red: 0.2354220152, green: 0.6353029013, blue: 0.6106306314, alpha: 1)
            option2.backgroundColor = #colorLiteral(red: 0.2354220152, green: 0.6353029013, blue: 0.6106306314, alpha: 1)
            option3.backgroundColor = #colorLiteral(red: 0.2354220152, green: 0.6353029013, blue: 0.6106306314, alpha: 1)
            displayOneQuestion()
            }
        else{
            transitionToEnd()
            
            
            
        }
        
    }
    
   
    
    func displayOneQuestion() {
        self.questionLabel.text = self.allQuestions[currentQuestion].Question
        self.option1.setTitle(self.allQuestions[currentQuestion].Answer1, for: .normal)
        self.option1.titleLabel?.numberOfLines = 0
                       
        self.option2.setTitle(self.allQuestions[currentQuestion].Answer2, for: .normal)
        self.option2.titleLabel?.numberOfLines = 0
                       
        self.option3.setTitle(self.allQuestions[currentQuestion].Answer3, for: .normal)
        self.option3.titleLabel?.numberOfLines = 0
        self.rightAnswer =  self.allQuestions[currentQuestion].RightAnswer
        alreadyClicked = false
        currentQuestion += 1
    }
    
    
    func transitionToEnd(){
        let endViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.EndViewController) as? EndViewController
        view.window?.rootViewController = endViewController
        view.window?.makeKeyAndVisible()
        endViewController?.scoreNrTextField.text = String(self.score)
        
        let db = Firestore.firestore();
            let user = Auth.auth().currentUser;
            if user != nil {
                db.collection("users").document(user?.uid ?? "").setData([
                    "score":score,
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }

             
            } else {
              print("no user is logged ine ")
            }
            
            
            
                
        }

        
        
        
    }

