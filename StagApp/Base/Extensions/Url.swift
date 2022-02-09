//
//  Url.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 30.01.2022.
//

import Foundation

extension URL {
    
    /// Adds parameter to url
    func appending(_ queryItem: String, value: String?) -> URL {

            guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }

            var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

            let queryItem = URLQueryItem(name: queryItem, value: value)

            queryItems.append(queryItem)

            urlComponents.queryItems = queryItems

            return urlComponents.url!
        }
}
