//
//  ViewController.swift
//  C03 Hangman
//
//  Created by Beau Herron on 4/19/19.
//  Copyright © 2019 Beau Herron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // UI Variables
    var wordPreview: UILabel!
    var turnLabel: UILabel!
    var letterButtons = [UIButton]()
    
    // Game Variables
    let letters = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    var rightWord = "HANGMAN"
    var guessedLetters = [String]()
    var previewWord = "" {
        didSet {
            wordPreview.text = previewWord
        }
    }
    var turns = 7 {
        didSet {
            turnLabel.text = "Turns Left: \(turns)"
        }
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        turnLabel = UILabel()
        turnLabel.translatesAutoresizingMaskIntoConstraints = false
        turnLabel.textAlignment = .center
        view.addSubview(turnLabel)
        
        wordPreview = UILabel()
        wordPreview.translatesAutoresizingMaskIntoConstraints = false
        wordPreview.font = UIFont.systemFont(ofSize: 72)
        wordPreview.textAlignment = .center
        wordPreview.backgroundColor = .lightGray
        view.addSubview(wordPreview)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        NSLayoutConstraint.activate([
            turnLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            turnLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            
            wordPreview.topAnchor.constraint(equalTo: turnLabel.bottomAnchor, constant: 40),
            wordPreview.centerXAnchor.constraint(equalTo: turnLabel.centerXAnchor),
            wordPreview.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.75),
            
            buttonsView.heightAnchor.constraint(equalToConstant: 320),
            buttonsView.widthAnchor.constraint(equalToConstant: 560),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: wordPreview.bottomAnchor, constant: 50),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
        ])
        
        //Button setup
        let width = 80
        let height = 80
        
        for row in 0..<4 {
            for column in 0..<7 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 48)
                letterButton.setTitle("W", for: .normal)
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                
                let frame = CGRect(x: column * width, y: row * width, width: width, height: height)
                letterButton.frame = frame
                
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New Word", style: .plain, target: self, action: #selector(newWord))
        
        loadLevel()
    }
    
    @objc func newWord() {
        let ac = UIAlertController(title: "Enter New Word", message: "Hide your screen, enter a new word, and pass the phone to a friend!", preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            guard let term = ac?.textFields?[0].text else { return }
            self?.rightWord = term
            self?.loadLevel()
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
        
        if rightWord.contains(buttonTitle) {
            guessedLetters.append(buttonTitle)
            sender.isHidden = true
        } else {
            sender.setTitleColor(UIColor.lightGray, for: .normal)
            turns -= 1
            
            if turns == 0 {
                let ac = UIAlertController(title: "You Died", message: nil, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Try Again?", style: .default, handler: resetGame))
                present(ac, animated: true)
            }
        }
        
        showWord()
    }
    
    func showWord() {
        previewWord = ""
        
        for letter in rightWord {
            let strLetter = String(letter)
            
            if guessedLetters.contains(strLetter) {
                previewWord += strLetter
            } else {
                previewWord += "_ "
            }
        }
    }
    
    func resetGame(action: UIAlertAction) {
        loadLevel()
    }
    
    func loadLevel() {
        guessedLetters = []
        turns = 7
        showWord()
        
        for i in 0..<letters.count {
            letterButtons[i].setTitle(letters[i], for: .normal)
        }
    }
}

