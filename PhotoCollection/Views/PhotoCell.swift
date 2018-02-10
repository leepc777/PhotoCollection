//
//  PhotoCell.swift
//  PhotoCollection
//
//  Created by Patrick on 2/10/18.
//  Copyright © 2018 patrick. All rights reserved.
//

import Foundation
import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    var imageName: String! {
        //when imageName got updated, photoImageView will read in the matching photo from locally.
        didSet {
            photoImageView.image = UIImage(named: imageName)
        }
    }
    
}
