//
//  ImageDownloader.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 29/05/2022.
//
import UIKit

class ImageDownloader {
    static let shared = ImageDownloader()
    lazy var queue: OperationQueue = {
        let queue = OperationQueue()
        return queue
    }()

    func addOperation(operation: DownloadOperation, completion: ((UIImage) -> Void)?) {
        operation.completionBlock = {
            if let image = operation.image {
                ImageCache.shared.setCache(key: operation.photoUrl, data: image)
                completion?(image)
            }
        }
        queue.addOperation(operation)
    }
}

class DownloadOperation: Operation {
    let photoUrl: String
    var image: UIImage?

    override var isAsynchronous: Bool {
        return true
    }

    init(photoUrl: String) {
        self.photoUrl = photoUrl
    }

    override func main() {
        if isCancelled { return }
        guard let url = URL(string: photoUrl),
              let data = try? Data(contentsOf: url),
              let image = UIImage(data: data) else {
            return
        }
        self.image = image
    }
}
