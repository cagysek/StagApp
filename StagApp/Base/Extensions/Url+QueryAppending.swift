//
//  Url.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 30.01.2022.
//

import Foundation

extension URL {
    
    
    /// Adds parameters to URL
    /// - Parameters:
    ///   - queryItem: parameter name
    ///   - value: parameter value
    /// - Returns: updated URL
    func appending(_ queryItem: String, value: String?) -> URL {

            guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }

            var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

            let queryItem = URLQueryItem(name: queryItem, value: value)

            queryItems.append(queryItem)

            urlComponents.queryItems = queryItems

            return urlComponents.url!
        }
    
    func valueOf(_ queryParameterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParameterName })?.value
    }
}
