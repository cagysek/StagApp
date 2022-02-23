//
//  UniversityCell.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 23.02.2022.
//

import SwiftUI

struct UniversityCellView: View {
    
    var university: University
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.white)
            
            HStack {
                Image(university.smallLogoImagePath)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .padding()
                
                Text(university.title)
                    .font(.system(size: 19, weight: .medium, design: .rounded))
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
                    .padding()
                    .foregroundColor(.gray)
            }
            
        }
        .frame(height: 100)
        .shadow(color: Color.shadow, radius: 4)
        .padding(.bottom)
        .padding(.leading)
        .padding(.trailing)
        
    }
}

struct UniversityCellView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color
                .defaultBackground
                .ignoresSafeArea()
            
            UniversityCellView(university: University(id: 1, title: "Západočeská univerzita v Plzni", url: "https://stag-ws.zcu.cz/ws", smallLogoImagePath: "09-bata-simple", bigLogoImagePath: "09-bata"))
        }
    }
}
