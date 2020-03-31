//
//  ViewController.swift
//  Anagrams
//
//  Created by Krish Murjani on 31/07/19.
//  Copyright © 2019 Krish Murjani. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector((promptWhenTapped)))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
            
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        startGame()
        
    }
    
    func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Restart", style: .plain, target: self, action: #selector(viewDidLoad))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc func promptWhenTapped() {
        let ac = UIAlertController(title: "Enter Answer" , message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
        
        
    }
    
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        
        if lowerAnswer == title!.lowercased() {
            errorFound(title: "Same Word as Title", message: "The word given cannot be used as an answer.")
            return
        }
        
        if lowerAnswer.isEmpty {
            errorFound(title: "Blank Input", message: "You haven't entered a word.")
            return
        }
        
        if isReal(word: lowerAnswer) {
            if isPossible(word: lowerAnswer) {
                if isOriginal(word: lowerAnswer) {
                    usedWords.insert(lowerAnswer, at: 0)
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    
                    return
                } else {
                    errorFound(title: "Word not Original.", message: "Look again! You've already used that word.")
                }
            } else {
                errorFound(title: "Word not Possible.", message: "The word '\(lowerAnswer)' cannot be spelled from the given word '\(title!.lowercased())'.")
                
            }
        } else {
            errorFound(title: "Word not Real.", message: "There is no such word like '\(lowerAnswer)' in the dictionary.")
        }
        
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word.lowercased()) && !usedWords.contains(word.uppercased())
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        if word.count < 3 {
            return false
        }
        return misspelledRange.location == NSNotFound
    }
    
    /*func isBlank(word: String) -> Bool {
     return word.isEmpty
     }*/
    
    func errorFound(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        
    }
    
}

