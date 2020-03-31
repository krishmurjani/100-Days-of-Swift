//
//  DetailViewController.swift
//  7. Whitehouse Petitions
//
//  Created by Krish Murjani on 26/08/19.
//  Copyright © 2019 Krish Murjani. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Petition?
    var selectedPetition = 0
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Petition \(selectedPetition) of 100"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        guard let detailItem = detailItem else { return }
        
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 140%; font-family: Gill Sans;} </style>
        </head>
        <body>
        <b><u>\(detailItem.title)</u></b>
        <br>
        <br>
        \(detailItem.body)
        </body>
        </html>
        """
        webView.loadHTMLString(html, baseURL: nil)
        
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
