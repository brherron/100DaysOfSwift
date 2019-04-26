//
//  Person.swift
//  P10 NameToFaces
//
//  Created by Beau Herron on 4/21/19.
//  Copyright © 2019 Beau Herron. All rights reserved.
//

import UIKit

class Person: NSObject, NSCoding {
    
    var name: String
    var image: String
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(name, forKey: "image")
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
    }
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
