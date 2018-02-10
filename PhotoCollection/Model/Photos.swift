//
//  Photos.swift
//  PhotoCollection
//
//  Created by Patrick on 2/9/18.
//  Copyright © 2018 patrick. All rights reserved.
//

import Foundation

struct PhotoCategory {
    var categoryImageName: String
    var title: String
    var imageNames: [String]
    
}

// this Class is to gerneate JSON-like data we got from website for using in this project
class PhotosLibrary
{
    
    // Type function fetchPhtos to return an array of Struct contaring three properties

    static func fetchPhotos() -> [PhotoCategory] {
        var categories = [PhotoCategory]()
        let photosData = PhotosLibrary.downloadPhotosData() // generate JSON-like data , Dictionary<String:Any>
        
        for (categoryTitle, dict) in photosData { //read out key-value paris one by one,
            
            if let dict = dict as? [String : Any] { // to make sure value is Dictionary<String:Any>
                let categoryImageName = dict["categoryImageName"] as! String
                if let imageNames = dict["imageNames"] as? [String] {
                    let newCategory = PhotoCategory(categoryImageName: categoryImageName, title: categoryTitle, imageNames: imageNames)
                    categories.append(newCategory)
                }
            }
            
        }
        
        return categories
    }

    
    //Type function downloadPhtosData() return an Dictioanry<String:Any>
    class func downloadPhotosData() -> [String : Any]
    {
        return [
            "Family" : [
                "categoryImageName" : "family",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "f", numberOfImages: 9),
            ],
            "Foods" : [
                "categoryImageName" : "foods",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "fo", numberOfImages: 8),
            ],
            "Travel" : [
                "categoryImageName" : "travel",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "t", numberOfImages: 8),
            ],
            "Nature" : [
                "categoryImageName" : "nature",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "n", numberOfImages: 9),
            ]
        ]
    }
    
    // this is to generate a arary of photo names
    private class func generateImage(categoryPrefix: String, numberOfImages: Int) -> [String] {
        var imageNames = [String]()
        
        for i in 1...numberOfImages {
            imageNames.append("\(categoryPrefix)\(i)")
        }
        
        return imageNames
    }
}

