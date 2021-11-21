//
//  ScheduleScreen.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 17.10.2021.
//

import SwiftUI

struct ScheduleScreen: View {
    var body: some View {
        ZStack {
            Color.defaultBackground
                .ignoresSafeArea()
            
            
                VStack(alignment: .leading) {
                    Text("Rozvrh")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                    
                    ScrollViewReader { proxy in
                        HStack {
                            Text("Listopad 2021")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                            
                            Spacer()
                            
                            Button("Dnes") {
                                withAnimation { proxy.scrollTo(17, anchor: .center) }
                            }
                            .buttonStyle(ScheduleButtonStyle())
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "slider.horizontal.3")
                            }
                            .buttonStyle(ScheduleButtonStyle())
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
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            ScheduleSuvjectView()
                            ScheduleSuvjectView(isExercise: true)
                            ScheduleSuvjectView()
                            ScheduleSuvjectView()
                            ScheduleSuvjectView()
                            ScheduleSuvjectView()
                        }
                        .padding(.bottom, 30)
                        
                    }
                    .padding(.leading, -15)
                    .padding(.trailing, -15)
                    .padding(.bottom, -15)
                    
                }
                .padding(.leading)
                .padding(.trailing)
            
            
        }
        
        .foregroundColor(.defaultFontColor)
    }
}

struct ScheduleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.white)
            .foregroundColor(.defaultFontColor)
            .font(.system(size: 16, weight: .semibold, design: .rounded))
            .frame(height: 30)
            .clipShape(Capsule())
            .shadow(color: .shadow, radius: 8)
    }
}

struct ScheduleScreen_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleScreen()
    }
}

struct ScheduleSuvjectView: View {
    var isExercise : Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("08:25 - 10:00")
                Spacer()
                Text("1 h 45 min")
            }
            .font(.system(size: 14, weight: .bold, design: .rounded))
            
            ZStack(alignment: .topLeading) {
                
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(self.isExercise ? .customLightGreen : .customDarkGray)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(self.isExercise ? "Cvičení" : "Přednáška")
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                    Text("Architektury softwarových systémů")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                    Text("KIV/SAR")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                    Label("Doc. Ing. Přemysl Brada", systemImage: "person")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                    
                    Label {
                        Text("UP-120")
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                    } icon: {
                        Image("symbol-pin-2")
                            .resizable()
                            .frame(width: 17, height: 17)
                    }
                    
                }
                .padding()
            }
            .shadow(color: .shadow, radius: 10)
        }
        .frame(height: 175)
        .padding()
        .padding(.bottom, -15)
        
        
    }
}
