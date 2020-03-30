//
//  DetailViewController.swift
//  Know Your Flags ReDo
//
//  Created by Krish Murjani on 09/07/19.
//  Copyright © 2019 Krish Murjani. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var selectedFlag: String?
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        title = selectedFlag
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToLoad = selectedFlag {
            imageView.image = UIImage(named: imageToLoad)
        }
        
    }
    
    @objc func shareTapped() {
        
        guard let image = imageView.image?.jpegData(compressionQuality: 1.0) else {
            print("No image found.")
            return
        }
            
        let vc = UIActivityViewController(activityItems: [image, selectedFlag as Any], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = false
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
