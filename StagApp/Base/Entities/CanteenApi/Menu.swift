//
//  Menu.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 30.03.2022.
//

import Foundation


/// Entity for map response from Canteen Api
struct Menu: Decodable {
    let mainCourses: [Meal]
    let soups: [Meal]
}


/// Entity for map response from Canteen Api
struct Meal: Decodable, Identifiable {
    
    private enum CodingKeys: String, CodingKey {
        case name, allergens, prices, number
    }
    
    var id = UUID()
    let name: String
    let allergens: [Allergens]
    let prices: [Prices]
    let number: Int
    
    
    /// Combine all alergens from array to one string
    /// - Returns: allergens as string
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
    
    
    /// Combine all prices to string
    /// - Returns: prices as string
    public func pricesToString() -> String {
        var result = ""
        

        let language = LanguageService.shared.language
        
        for price in prices {
            if (!result.isEmpty) {
                result += " ∙ "
            }
            
            var personStatus = price.type.prefix(3)
            
            if (personStatus == "Emp" && language == "cs") {
                personStatus = "Zam"
            }
            
            result += "\(personStatus): \(String(Int(price.price))) Kč"
        }
        
        return result
    }
}

/// Entity for map response from Canteen Api
struct Allergens: Decodable {
    let number: Int
    let name: String
    let description: String
}

/// Entity for map response from Canteen Api
struct Prices: Decodable {
    let type: String
    let price: Float
}
