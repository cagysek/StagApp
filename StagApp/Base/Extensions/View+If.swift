//
//  View.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 21.11.2021.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
