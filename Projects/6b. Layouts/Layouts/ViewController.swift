//
//  ViewController.swift
//  Layouts
//
//  Created by Krish Murjani on 16/08/19.
//  Copyright © 2019 Krish Murjani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label1 = UILabel()
        let label2 = UILabel()
        let label3 = UILabel()
        let label4 = UILabel()
        let label5 = UILabel()
        
        let labels = [label1, label2, label3, label4, label5]
        
        for label in labels {
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont(name: "Gill Sans", size: 35)
            label.sizeToFit()
        }
        
//        let label1 = UILabel()
//        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = .red
        label1.text = "These"
//        label1.sizeToFit()
        
//        let label2 = UILabel()
//        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = .cyan
        label2.text = "Are"
//        label2.sizeToFit()
        
//        let label3 = UILabel()
//        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = .green
        label3.text = "Some"
//       label3.sizeToFit()
        
//        let label4 = UILabel()
//        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = .orange
        label4.text = "Awesome"
        //label4.font = UIFont.systemFont(ofSize: 40)
//        label4.sizeToFit()
        
//        let label5 = UILabel()
//        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = .yellow
        label5.text = "Labels"
//        label5.sizeToFit()
        
        for label in labels {
            view.addSubview(label)
        }
        
//                VISUAL FORMAT LANGUAGE
//
//                let viewsDictionary = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]
//
//                for labels in viewsDictionary.keys {
//                    view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(labels)]|", options: [], metrics: nil, views: viewsDictionary))
//                }
//
//                let metrics = ["labelHeight": 88]
//
//                view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]-(>=10)-|", options: [], metrics: metrics, views: viewsDictionary))
        
        //          ANCHORS
        var previous: UILabel?

        for label in labels {
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true

            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true

            label.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2, constant: -10).isActive = true

            if let previous = previous {
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 5).isActive = true
            }
            else {
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            }

            previous = label

        }
    }
}

