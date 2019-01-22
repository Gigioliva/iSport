//
//  CustomImage.swift
//  iSport
//
//  Created by Gianluigi Oliva on 14/01/2019.
//  Copyright © 2019 Gianluigi Oliva. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String, callback: @escaping () -> Void) {
        
        imageUrlString = urlString
        
        guard let url = URL(string: urlString) else { return }
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
//            let ratio = imageFromCache.size.width / imageFromCache.size.height
//            self.addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.frame.size.width / ratio))
            callback()
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, respones, error) in
            
            if error != nil {
                print(error ?? "")
                return
            }
            
            DispatchQueue.main.async {
                guard let imageToCache = UIImage(data: data!) else { return }
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
//                    let ratio = imageToCache.size.width / imageToCache.size.height
//                    self.addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.frame.size.width / ratio))
                    callback()
                }
                
                imageCache.setObject(imageToCache, forKey: urlString as NSString)
            }
            
        }).resume()
    }
    
}
