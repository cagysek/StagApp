import SwiftUI

/// App screen with university select
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
                        Text("university.pick-text")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                    }
                    .padding()
                    
                    ScrollView(.vertical, showsIndicators: true) {
                        ForEach(vm.getUniversities()) { university in
                            
                            // not supported yet
                            if (university.id != 8) {
                                UniversityCellView(university: university)
                                    .onTapGesture {
                                        self.vm.selectUniversity(id: university.id)
                                        
                                        withAnimation {
                                            self.showUniversity = false
                                        }
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
