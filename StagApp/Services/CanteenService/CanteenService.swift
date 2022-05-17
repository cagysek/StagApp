import Foundation

/// Protocol which defines funtions for service
protocol ICanteenService {
    
    /// Fetch canteen menu
    /// - Parameters:
    ///   - canteenId: canteen to load menu
    ///   - daysShift: menu days shift
    ///   - language: language of menu
    /// - Returns: canteen menu
    func fetchMenu(canteenId: String, daysShift: Int, language: String) async throws -> Menu
}

/// Implementation of canteen service. Provides communication for zcu WS
final class CanteenService: ICanteenService {
    
    public func fetchMenu(canteenId: String, daysShift: Int, language: String = "cs") async throws -> Menu {
        print(language)
        let url = URL(string: "\(CanteenApiConstants.baseUri)/\(canteenId)?lang=\(language)&daysShift=\(String(daysShift))")!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return try JSONDecoder().decode(Menu.self, from: data)
    }
}
