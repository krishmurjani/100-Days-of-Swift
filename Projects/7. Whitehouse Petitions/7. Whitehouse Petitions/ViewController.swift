//
//  ViewController.swift
//  7. Whitehouse Petitions
//
//  Created by Krish Murjani on 25/08/19.
//  Copyright © 2019 Krish Murjani. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {var petitions = [Petition]()
    var filteredPetition = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(credits))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filter))
        
        title = "Whitehouse Petitions"
        
        loadPetitions(filteredPetition)
    }
    
    func loadPetitions(_ filter: String) {
        let urlString: String
        let newFilter = filteredPetition.replacingOccurrences(of: " ", with: "+")
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?title=\(newFilter)&limit=100"
            //"https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString  = "https://api.whitehouse.gov/v1/petitions.json?title=\(newFilter)&signatureCountFloor=10000&limit=100"
            //"https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        showError()
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    @objc func filter() {
        let ac = UIAlertController(title: "Enter Keywords" , message: "Filter the petitions you want to view by searching.", preferredStyle: .alert)
        ac.addTextField()
        
        let searchResult = UIAlertAction(title: "Go", style: .default) { [weak self, weak ac] _ in
            guard let search = ac?.textFields?[0].text else { return }
            self?.go(search)
        }
        
        ac.addAction(UIAlertAction(title: "Cancel" , style: .default))
        ac.addAction(searchResult)
        present(ac, animated: true)
    }
    
    func go(_ filter: String) {
        filteredPetition = filter.lowercased()
        loadPetitions(filteredPetition)
        
    }
    
    @objc func credits() {
        let ac = UIAlertController(title: "Thank 'We The People API of the Whitehouse'!", message: "This data on our app comes directly from the We The People API of the Whitehouse.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.selectedPetition = indexPath.row+1
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading Error", message: "There was a problem loading the feed; please check your connection and try again later." , preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        
    }
}



