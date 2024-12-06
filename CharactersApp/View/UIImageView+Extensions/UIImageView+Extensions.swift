//
//  UIImageView+Extensions.swift
//  CharactersApp
//
//  Created by Sarah Gamal on 05/12/2024.
//

import UIKit

extension UIImageView {
    private static let imageCache = NSCache<NSString, UIImage>()
    
    func load(urlString: String) {

        if let cachedImage = UIImageView.imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                UIImageView.imageCache.setObject(image, forKey: urlString as NSString)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}
