//
//  ViewController.swift
//  Shopping List
//
//  Created by Krish Murjani on 20/08/19.
//  Copyright © 2019 Krish Murjani. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var shoppingList = [String]()
    var completeList = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shopping List"
      //  navigationController?.navigationBar.prefersLargeTitles = false
        
        let share = UIBarButtonItem(barButtonSystemItem: .action , target: self, action: #selector(shareTapped))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbarItems = [space, share]
        
        navigationController?.isToolbarHidden = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector((addItemTapped)))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear All", style:.plain, target: self, action: #selector(clearList))
        completeList = shoppingList.joined(separator: "\n")
        
        clear(action: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    @objc func addItemTapped() {
        
        let ac = UIAlertController(title: "Enter Item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let add = UIAlertAction(title: "Add", style: .default) {
            [weak self, weak ac] _ in
            guard let itemName = ac?.textFields?[0].text else { return }
            self?.addItem(itemName)
        }
        ac.addAction(add)
        present(ac, animated: true)
        
    }
    
    func addItem (_ itemName: String) {
        
        if itemName == "" || itemName == " " {
            let ac = UIAlertController(title: "Uh-oh! ", message: "Your item name cannot be blank!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            return
        }
        
        shoppingList.insert(itemName, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
    }
    
    @objc func clearList() {
        let ac = UIAlertController(title: "Are you sure?", message: "Do you want to clear your list?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Yes", style: .default, handler: clear))
        ac.addAction(UIAlertAction(title: "No", style: .default))
        ac.present(ac, animated: true)
        
    }
    
    func clear(action: UIAlertAction!) {
        shoppingList.removeAll()
        tableView.reloadData()
    }
    
    @objc func shareTapped() {
        let list = shoppingList.joined(separator: "\n")
        let ac = UIActivityViewController(activityItems: [list], applicationActivities: [])
        present(ac, animated: true)
    }

}

