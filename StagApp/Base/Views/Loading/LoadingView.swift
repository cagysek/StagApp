//
//  LoadingView.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 13.10.2021.
//

import SwiftUI

struct LoadingView: View {
    
    let text: String
    
    var body: some View {
        VStack(spacing: 8) {
            ProgressView()
            Text(LocalizedStringKey(self.text))
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(text: "common.loading")
    }
}
