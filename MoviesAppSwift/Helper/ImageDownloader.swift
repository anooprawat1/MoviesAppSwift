//
//  ImageDownloader.swift
//  MoviesAppSwift
//
//  Created by Anoop on 03.08.22.
//

import Foundation
import UIKit

protocol ImageLoaderProtocol {
    func downloadImage(with imageUrl: String?,
                       completionHandler: @escaping (UIImage?, Bool) -> Void)
}

public final class ImageDownloader: ImageLoaderProtocol {
    private let imageBaseUrl: String
    private var cachedImages: [String: UIImage]
    private var imagesDownloadTasks: [String: URLSessionDataTask]

    init(_ imageBaseUrl: String) {
        self.imageBaseUrl = imageBaseUrl
        cachedImages = [:]
        imagesDownloadTasks = [:]
    }

    private let serialQueueForImages = DispatchQueue(label: "images.queue", attributes: .concurrent)
    private let serialQueueForDataTasks = DispatchQueue(label: "dataTasks.queue", attributes: .concurrent)

    func downloadImage(with imageUrl: String?,
                       completionHandler: @escaping (UIImage?, Bool) -> Void)
    {

        guard let imageUrl = imageUrl else {
            completionHandler(nil, false)
            return
        }
        
        let imageUrlString = imageBaseUrl + imageUrl

        if let image = getCachedImageFrom(urlString: imageUrlString) {
            completionHandler(image, true)
        } else {
            guard let url = URL(string: imageUrlString) else {
                completionHandler(nil, false)
                return
            }

            if let _ = getDataTaskFrom(urlString: imageUrlString) {
                return
            }

            let task = URLSession.shared.dataTask(with: url) { data, _, error in

                guard let data = data else {
                    return
                }

                if let _ = error {
                    DispatchQueue.main.async {
                        completionHandler(nil, false)
                    }
                    return
                }

                let image = UIImage(data: data)

                self.serialQueueForImages.sync(flags: .barrier) {
                    self.cachedImages[imageUrlString] = image
                }

                _ = self.serialQueueForDataTasks.sync(flags: .barrier) {
                    self.imagesDownloadTasks.removeValue(forKey: imageUrlString)
                }

                DispatchQueue.main.async {
                    completionHandler(image, false)
                }
            }

            serialQueueForDataTasks.sync(flags: .barrier) {
                imagesDownloadTasks[imageUrlString] = task
            }

            task.resume()
        }
    }

    private func getCachedImageFrom(urlString: String) -> UIImage? {
        serialQueueForImages.sync {
            cachedImages[urlString]
        }
    }

    private func getDataTaskFrom(urlString: String) -> URLSessionTask? {
        serialQueueForDataTasks.sync {
            imagesDownloadTasks[urlString]
        }
    }
}
