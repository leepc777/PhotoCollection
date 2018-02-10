//
//  PhotosCollectionViewController.swift
//  PhotoCollection
//
//  Created by Patrick on 2/10/18.
//  Copyright © 2018 patrick. All rights reserved.
//

import UIKit

class PhotosCollectionViewController : UICollectionViewController {
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    // this is JSON like data.
    var photosCategories: [PhotoCategory] = PhotosLibrary.fetchPhotos()
    
    struct Storyboard {
        static let photoCell = "PhotoCell"
        static let sectionHeaderView = "SectionHeaderView"
        static let leftAndRightPadding: CGFloat = 2.0
        static let numberOfItemsPerRow: CGFloat = 3.0
        static let showDetailVC = "ShowImageDetail"
    }
    
    //MARK: - View Controller LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: change the layout of the colleciton view
        let collectionViewWidth = collectionView?.frame.width
        let itemWidth = (collectionViewWidth! - Storyboard.leftAndRightPadding) / Storyboard.numberOfItemsPerRow
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        //delete button in navi bar
        navigationItem.leftBarButtonItem = editButtonItem
        
    }
    
    
    //MARK: --  Add Item
    @IBAction func addNewItem(_ sender: Any) {
        
        // 1 - get a random image, or download from internet
        let firstCategoryImageNames = photosCategories[0].imageNames
        // insure the randomIndex is within the range of array
        let randomIndex = Int(arc4random()) % firstCategoryImageNames.count
        let randomImage = firstCategoryImageNames[randomIndex]
        
        // 2 - add new image to Data Model
        photosCategories[0].imageNames.append(randomImage)
        
        // 3 - Update collection, reload all is wasting resouce
        //collectionView?.reloadData()
        
        // find out the last index of the array storing the data. which actually the number of array.count
        let insertedIndexPath = IndexPath(item: firstCategoryImageNames.count, section: 0)
        collectionView?.insertItems(at: [insertedIndexPath])
    }
    
    
    //MARK: -  Collection View DataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return photosCategories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosCategories[section].imageNames.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.photoCell, for: indexPath) as! PhotoCell
        let photoCategory = photosCategories[indexPath.section]
        let imageNames = photoCategory.imageNames
        let imageName = imageNames[indexPath.row]
        
        cell.imageName = imageName
        cell.delegate = self
        
        return cell
    }
    
    
    //MARK: - colleciton delegation method
    var selectedImage: UIImage!
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = photosCategories[indexPath.section]
        selectedImage = UIImage(named: category.imageNames[indexPath.row])
        performSegue(withIdentifier: Storyboard.showDetailVC, sender: nil)
    }
    
    //MARK: - Delete Collection Items
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(true, animated: true)
        addButton.isEnabled = !editing
       
        //read out all indexPath of cells showing in current VC
        if let indexPaths = collectionView?.indexPathsForVisibleItems {
            for indexPath in indexPaths {
                if let cell = collectionView?.cellForItem(at: indexPath) as? PhotoCell {
                    cell.isEditing = editing
                    
                }
            }
        }
        
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.showDetailVC {
            
            let detailVC = segue.destination as! DetailViewController
            detailVC.image = selectedImage
        }
    }
    
    //MARK: - Section Header View
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Storyboard.sectionHeaderView, for: indexPath) as! SectionHeaderView
        let category = photosCategories[indexPath.section]
        sectionHeaderView.categoryTitleLabel.text = category.title
        sectionHeaderView.categoryImageView.image = UIImage(named: category.categoryImageName)
        return sectionHeaderView
    }
}

extension PhotosCollectionViewController: PhotoCellDelegate {
    func delete(cell: PhotoCell) {
        
        // find out the indexPath of the Photo cell we want to delete. the index is same for both our Data Model(either an array or Core Data) and Collection View
        if let indexPath = collectionView?.indexPath(for: cell) {
            //1. delete photo from data souce (Model: array or core data)
            photosCategories[indexPath.section].imageNames.remove(at: indexPath.item)
            
            // 2. delete Photo Cell at the index path from Collection View
            
            collectionView?.deleteItems(at: [indexPath])
        }
    }
    
  
    
}
