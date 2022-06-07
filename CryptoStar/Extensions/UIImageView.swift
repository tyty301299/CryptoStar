//
//  UIImageView.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 31/05/2022.
//

import UIKit

extension UIImageView {
    func load(link: String, placeholderImage: UIImage? = UIImage(named: "cryptostar"), completion: ((UIImage?) -> Void)? = nil) {
        guard let url = URL(string: link) else {
            image = placeholderImage
            completion?(image)
            return
        }
        if let cachedImage = ImageCache.shared.image(forKey: link) {
            image = cachedImage
            completion?(cachedImage)
            return
        }
        DispatchQueue.main.async {
            self.image = placeholderImage
        }
       
        accessibilityLabel = link
        ImageDownloader.shared.addOperation(operation: DownloadOperation(photoUrl: link)) { image in
            OperationQueue.main.addOperation { [weak self] in
                guard let self = self else { return }
                completion?(image)
                if self.accessibilityLabel == link {
                    self.image = image
                }
            }
        }
    }
}
