//
//  DetailViewController.swift
//  Storm Viewer
//
//  Created by Krish Murjani on 25/06/19.
//  Copyright © 2019 Krish Murjani. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var selectedImageNumber = 0
    var totalImages = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\(selectedImageNumber) of \(totalImages)"
        navigationItem.largeTitleDisplayMode = .never

        //can also use --> navigationController?.navigationBar.prefersLargeTitles = false
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
