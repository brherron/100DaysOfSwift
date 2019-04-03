//
//  ViewController.swift
//  Project2
//
//  Created by Beau Herron on 3/28/19.
//  Copyright © 2019 Beau Herron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var correctAnswer = 0
    
    var score = 0
    let numberOfQuestions = 10
    var questionsAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(viewScore))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "View Score", style: .plain, target: self, action: #selector(viewScore))
        
        countries += ["estonia", "france", "germany",
                      "ireland", "italy", "monaco",
                      "nigeria", "poland", "russia",
                      "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.gray.cgColor
        button2.layer.borderColor = UIColor.gray.cgColor
        button3.layer.borderColor = UIColor.gray.cgColor

        askQuestion()
    }
    
    @objc func viewScore() {
        let ac = UIAlertController(title: "Your score is: \(score)", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        title = "Choose: \(countries[correctAnswer].uppercased())"
        questionsAsked += 1
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String
        
        if sender.tag == correctAnswer {
            score += 1
            title = "Correct!"
            message = ""
        } else {
            title = "Wrong!"
            message = "The correct answer was \(countries[correctAnswer].uppercased()). "
            score -= 1
        }
        
        if questionsAsked == numberOfQuestions {
            let ac = UIAlertController(title: title, message: "\(message)FINAL SCORE: \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Play Again", style: .default, handler: askQuestion))
            present(ac, animated: true)
            questionsAsked = 0;
            score = 0
        } else {
            let ac = UIAlertController(title: title, message: "\(message)You have \(numberOfQuestions - questionsAsked) more questions.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }
    }
}

