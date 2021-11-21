//
//  ScheduleDateTimeFilterView.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 21.11.2021.
//

import SwiftUI

struct ScheduleDateTimeFilterView: View {
    var body: some View {
        ScrollViewReader { proxy in
            HStack {
                Text("Listopad 2021")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                
                Spacer()
                
                Button("Dnes") {
                    withAnimation { proxy.scrollTo(17, anchor: .center) }
                }
                .buttonStyle(WhiteCapsuleButtonStyle())
                
                Button {
                    
                } label: {
                    Image(systemName: "slider.horizontal.3")
                }
                .buttonStyle(WhiteCapsuleButtonStyle())
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 30) {
                    ForEach((1...30), id: \.self) {index in
                        Button {
                            
                        } label: {
                            VStack(alignment: .center, spacing: 5) {
                                Text("Po")
                                    .font(.system(size: 14, weight: .medium, design: .rounded))
                                    .foregroundColor(.gray)
                                Text("\(index)")
                                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                                    .foregroundColor(.defaultFontColor)
                            }
                        }
                        .padding(0)
                        .id(index)
                    }
                }
                .padding()
                
            }
            .frame(height: 60)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(color: .shadow, radius: 8)
            
        }
    }
}

struct ScheduleDateTimeFilterView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleDateTimeFilterView()
    }
}
