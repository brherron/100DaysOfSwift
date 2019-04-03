//
//  DetailViewController.swift
//  Consolidation1
//
//  Created by Beau Herron on 4/1/19.
//  Copyright © 2019 Beau Herron. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var selectedFlag: String?
    var selectedFlagPosition = 0
    var totalFlags = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never
        
        
        if let imageToLoad = selectedFlag {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = false
    }

}
