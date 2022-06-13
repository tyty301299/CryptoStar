//
//  ImageCache.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 31/05/2022.
//
//
import UIKit

class ImageCache {
    static var shared = ImageCache()
    var keys: [String] = []
    var cache: NSCache = NSCache<NSString, UIImage>()

    func setCache(key: String, data: UIImage) {
        if keys.count >= 50 {
            removeKeyImage(forkey: keys.removeFirst())
        }
        cache.setObject(data, forKey: NSString(string: key))
        keys.append(key)
    }

    func image(forKey key: String) -> UIImage? {
        cache.object(forKey: NSString(string: key))
    }

    func removeKeyImage(forkey key: String) {
        cache.removeObject(forKey: NSString(string: key))
    }

    func removeAll() {
        keys.removeAll()
        cache.removeAllObjects()
    }
}

