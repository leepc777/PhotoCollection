//
//  PhotoCell.swift
//  PhotoCollection
//
//  Created by Patrick on 2/10/18.
//  Copyright © 2018 patrick. All rights reserved.
//

import UIKit

protocol PhotoCellDelegate: class {
    func delete(cell:PhotoCell)
    
}

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var deleteBackView: UIVisualEffectView!
    
    weak var delegate: PhotoCellDelegate?
    
    var imageName: String! {
        //when imageName got updated, photoImageView will read in the matching photo from locally.
        didSet {
            photoImageView.image = UIImage(named: imageName)
            
            deleteBackView.layer.cornerRadius = deleteBackView.bounds.width / 2.0
            deleteBackView.layer.masksToBounds = true
            deleteBackView.isHidden = !isEditing // hidden unless in edit mode
            
        }
    }
    
    var isEditing: Bool = false {
        
        didSet {
            deleteBackView.isHidden = !isEditing
        }
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        delegate?.delete(cell: self)
        
    }
}
