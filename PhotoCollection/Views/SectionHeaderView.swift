//
//  SectionHeaderView.swift
//  PhotoCollection
//
//  Created by Patrick on 2/10/18.
//  Copyright © 2018 patrick. All rights reserved.
//

import UIKit

class SectionHeaderView : UICollectionReusableView {
    
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    
    var photoCategory: PhotoCategory! {
        didSet {
//            categoryTitleLabel.text = photoCategory.title
//            categoryImageView.image = UIImage(named: photoCategory.categoryImageName)
        }
        
    }

}
