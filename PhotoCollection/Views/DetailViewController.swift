//
//  DetailViewController.swift
//  PhotoCollection
//
//  Created by Patrick on 2/10/18.
//  Copyright © 2018 patrick. All rights reserved.
//

import UIKit

class DetailViewController : UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
        navigationItem.title = "Photo"
        
    }
    
}
