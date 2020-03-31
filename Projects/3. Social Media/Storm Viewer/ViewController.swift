//
//  ViewController.swift
//  Storm Viewer
//
//  Created by Krish Murjani on 16/06/19.
//  Copyright © 2019 Krish Murjani. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(shareTapped))
        
        /*let add = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(shareTapped))
        let play = UIBarButtonItem(title: "Play", style: .plain, target: self, action: #selector(shareTapped)) */
        //can add multiple bar buttons. example above
       // navigationItem.rightBarButtonItems = [add, play, share]
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items  {
            if item.hasPrefix("nssl") {
            // this is a picture to load!
            pictures.append(item)
            }
            pictures.sort()
        }
        
            print(pictures)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.selectedImageNumber = (indexPath.row)+1
            vc.totalImages = pictures.count
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func shareTapped() {
        
        let message = "Check out my new app called Storm Viewer to view beautiful pictures of storms. Now share these pictures with your friends and family too!"
        
        let vc = UIActivityViewController(activityItems: [message], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
        
    }
    
}

