//
//  UniversityScreen.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 21.02.2022.
//

import SwiftUI

struct UniversityScreen: View {
    
    @Binding var showUniversity: Bool
    
    @ObservedObject var vm = UniversityViewModel()
    
    var body: some View {
        
            ZStack {
                Color
                    .defaultBackground
                    .ignoresSafeArea()
                
                VStack {
                    HStack(alignment: .center) {
                        Text("Vyber si svojí univerzitu")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                    }
                    .padding()
                    
                    ScrollView(.vertical, showsIndicators: true) {
                        ForEach(vm.getUniversities()) { university in
                            
                            UniversityCellView(university: university)
                                .onTapGesture {
                                    self.vm.selectUniversity(id: university.id)
                                    
                                    withAnimation {
                                        self.showUniversity = false
                                    }
                                }
                        }
                    }
                    
                    Spacer()
                }
                .ignoresSafeArea(.all, edges: .bottom)
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
        }
}

struct UniversityScreen_Previews: PreviewProvider {
    
    @State static var university: University?
    
    static var previews: some View {
        NavigationView {
        UniversityScreen(showUniversity: .constant(false))
        }
    }
}
