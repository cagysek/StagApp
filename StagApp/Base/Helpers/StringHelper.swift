import Foundation


/// Helper string functions
struct StringHelper {
    
    
    /// Concats all given strings to one with custom separator
    /// - Parameters:
    ///   - strings: strings to concat
    ///   - separatorOnFirstPosition: separator on first position
    ///   - separator: strings separator
    /// - Returns: concated strings separated by separator
    public static func concatStringsToOne(strings: String..., separatorOnFirstPosition: Bool = false, separator: String = " ∙ ") -> String {
        var result = "";
        
        
        for string in strings
        {
            if (!result.isEmpty && !string.isEmpty)
            {
                result += separator
            }
            
            result += string
        }
        
        if (separatorOnFirstPosition && !result.isEmpty)
        {
            result = separator + result
        }
        
        return result;
    }
}
