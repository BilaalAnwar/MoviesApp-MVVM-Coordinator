//
//  ExtOfUIIamge.swift
//  MasterMovie
//
//  Created by Bilal Anwar on 12/10/23.
//

import Foundation
import UIKit

extension UIImage {
    static func load(url: URL, placeholder: UIImage? = nil, cache: URLCache? = nil) async -> UIImage {
        let cache = cache ?? URLCache.shared
        let request = URLRequest(url: url)
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            return image
        } else {
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode < 300, let image = UIImage(data: data) {
                    let cachedData = CachedURLResponse(response: httpResponse, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    return image
                }
            } catch {
                print("Error loading image: \(error)")
            }
            return placeholder ?? UIImage()
        }
    }
}
