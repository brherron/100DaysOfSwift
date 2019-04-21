//
//  Person.swift
//  P10 NameToFaces
//
//  Created by Beau Herron on 4/21/19.
//  Copyright © 2019 Beau Herron. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
