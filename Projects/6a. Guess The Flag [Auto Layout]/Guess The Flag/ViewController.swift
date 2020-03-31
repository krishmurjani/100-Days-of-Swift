//
//  ViewController.swift
//  Guess The Flag
//
//  Created by Krish Murjani on 30/06/19.
//  Copyright © 2019 Krish Murjani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var numberOfQuestionsAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"] //can also use append
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion(nil)
        
        navigationItem.rightBarButtonItem =  UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(viewScore))
        
       // navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Restart", style: .plain, target: self, action: #selector(restartGame))
        
        
    }
    
     func askQuestion(_ action: UIAlertAction!) {
        countries.shuffle()
        
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        /* let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.font = UIFont(name: "Georgia-Bold" , size: 20)!
        label.textAlignment = .center
        label.textColor = .black
        label.text = "\(countries[correctAnswer].uppercased()) \n Score: \(score)/10"
        self.navigationItem.titleView = label */
        
        
        title = "Guess: " + countries[correctAnswer].uppercased()
        
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont(name: "Georgia-Bold", size: 20)!
        ]
        
        UINavigationBar.appearance().titleTextAttributes = attrs
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        numberOfQuestionsAsked+=1
        
        var title: String
        
        if(sender.tag == correctAnswer) {
            
            title = "Correct"
            score+=1
        }
        else {
            
            title = "Wrong!"
        }
        
        let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
    
        if sender.tag != correctAnswer {
            ac.message = "You picked \(countries[sender.tag].uppercased()). \n The correct answer is Flag No. \(correctAnswer+1). \n Your score is \(score)."
        }
        
        if numberOfQuestionsAsked == 10 {
            
            let finalAC = UIAlertController(title: "Game Over!", message: "Your final score is \(score)/10.", preferredStyle: .alert)
            
            finalAC.addAction(UIAlertAction(title: "Play Again!", style: .default, handler: askQuestion))
            finalAC.addAction(UIAlertAction(title: "Exit", style: .default, handler: exitGame))
            
            present(finalAC,animated: true)
            
            numberOfQuestionsAsked = 0
            score = 0

        }
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        present(ac, animated: true)
        
    }
    
    @objc func viewScore() {
        
        let vc = UIAlertController(title: "Score", message: "Your score is \(score)/\(numberOfQuestionsAsked).\nQuestions remaining: \(10-numberOfQuestionsAsked)", preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "Done", style: .default))
        present(vc, animated: true)
        
    }
    
    func exitGame(_ action: UIAlertAction!) {
        UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
    }
    

}

