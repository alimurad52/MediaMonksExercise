//
//  UIImage+Cache.swift
//  MediaMonksExercise
//
//  Created by Ali Murad on 24/08/2018.
//  Copyright © 2018 Media Monks. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()
public extension UIImageView {
    func downloadImage(from imgURL: String!) {
        let url = URLRequest(url: URL(string: imgURL)!)
        image = nil
        if let imageToCache = imageCache.object(forKey: imgURL! as NSString) {
            self.image = imageToCache
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                imageCache.setObject(imageToCache!, forKey: imgURL! as NSString)
                self.image = imageToCache
            }
        }
        task.resume()
    }
}
