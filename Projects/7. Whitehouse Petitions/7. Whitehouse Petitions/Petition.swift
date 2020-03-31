//
//  Petition.swift
//  7. Whitehouse Petitions
//
//  Created by Krish Murjani on 25/08/19.
//  Copyright © 2019 Krish Murjani. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
