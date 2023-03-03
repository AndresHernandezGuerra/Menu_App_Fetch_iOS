//
//  UIImageView+Cache.swift
//  Menu_App_Fetch_iOS
//
//  Created by Andres S. Hernandez G. on 2/28/23.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

// MARK: - Image Cacheing Extension

extension UIImageView {
    func loadImageUsingCache(withUrl url : URL?) {
        
        guard let url = url else { return }
        self.image = nil
                
        //check cached image
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
            return
        }
        
        //if not, download from URL
        guard let url = URL(string: url.absoluteString) else { return }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            //download error
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data, let downloadedImage = UIImage(data: data) else { return }
            
            imageCache.setObject(downloadedImage, forKey: url.absoluteString as NSString)
            
            DispatchQueue.main.async {
                self.image = downloadedImage
            }
        }).resume()
    }
}
