//
//  CustomImageView.swift
//  CardsHearthstone
//
//  Created by Lucas Santana Brito on 20/07/23.
//

import UIKit

class CustomImageView: UIImageView {
    private static let cache = NSCache<NSString, UIImage>()
    
    func downloadImage(fromURL urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let cacheKey = NSString(string: urlString)
        
        if let image = CustomImageView.cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    CustomImageView.cache.setObject(image, forKey: cacheKey)
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
}
