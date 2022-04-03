//
//  Menu.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 30.03.2022.
//

import Foundation

struct Menu: Decodable {
    let mainCourses: [Meal]
    let soups: [Meal]
}

struct Meal: Decodable, Identifiable {
    var id = UUID()
    let name: String
    let allergens: [Allergens]
    let prices: [Prices]
    let number: Int
    
    public func allergensToString() -> String {
        var result = ""
        
        for allergen in allergens {
            if (!result.isEmpty) {
                result += ", "
            }
            
            result += String(allergen.number)
        }
        
        return result
    }
    
    public func pricesToString() -> String {
        var result = ""
        
        for price in prices {
            if (!result.isEmpty) {
                result += " ∙ "
            }
            
            result += "\(price.type.prefix(3)): \(String(Int(price.price))) Kč"
        }
        
        return result
    }
}

struct Allergens: Decodable {
    let number: Int
    let name: String
    let description: String
}

struct Prices: Decodable {
    let type: String
    let price: Float
}
