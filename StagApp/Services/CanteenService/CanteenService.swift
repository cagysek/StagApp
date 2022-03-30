//
//  CanteenService.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 30.03.2022.
//

import Foundation

protocol ICanteenService {
    func fetchMenu(canteenId: String, daysShift: Int, language: String) async throws -> Menu
}

final class CanteenService: ICanteenService {
    
    public func fetchMenu(canteenId: String, daysShift: Int, language: String = "cs") async throws -> Menu {
        
        let url = URL(string: "\(CanteenApiConstants.baseUri)/\(canteenId)?lang=\(language)&daysShift=\(String(daysShift))")!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return try JSONDecoder().decode(Menu.self, from: data)
    }
}
