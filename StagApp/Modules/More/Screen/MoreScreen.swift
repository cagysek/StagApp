import SwiftUI

/// App screen `More`
struct MoreScreen: View {
    
    @AppStorage(UserDefaultKeys.LANGUAGE) private var language = LanguageService.shared.language
    
    @State private var languageIndex: ELanguage = .system
    
    @AppStorage(UserDefaultKeys.IS_LOGED) private var isLogged = true
    @AppStorage(UserDefaultKeys.HAS_TEACHER_ID) private var hasTeacherId = false
    
    @Binding var selectedTabIndex: Int
    
    var body: some View {
        NavigationView {
            ZStack {
                Color
                    .defaultBackground
                    .ignoresSafeArea()
                
                VStack {
                    HStack(alignment:.bottom) {
                        Text("more.headline")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                        Spacer()
                    }
                    .padding()
                    
                    
                    List {
                        Section(header: Text("ZČU").font(.system(size: 14, weight: .regular, design: .rounded))) {
                            NavigationLink {
                                CanteenScreen()
                            } label: {
                                Text("canteen.title")
                            }
                            
//                            NavigationLink {
//                                CanteenScreen()
//                            } label: {
//                                Text("Webmail")
//                            }
                            
                            
                        }
                        
                        if (self.hasTeacherId) {
                            Section(header: Text("Učitel").font(.system(size: 14, weight: .regular, design: .rounded))) {
                                NavigationLink {
                                    ThesesScreen()
                                } label: {
                                    Text("theses.title")
                                }
                            }
                        }

                        
//
//                        Section(header: Text("Další funkce").font(.system(size: 14, weight: .regular, design: .rounded))) {
//                            NavigationLink {
//                                CanteenScreen()
//                            } label: {
//                                Text("Učebny")
//                            }
//
//                            NavigationLink {
//                                CanteenScreen()
//                            } label: {
//                                Text("Studenti")
//                            }
//                        }
                        
                        
                        Section(header: Text("Obecné").font(.system(size: 14, weight: .regular, design: .rounded))) {
                            
                            NavigationLink {
                                SettingsScreen()
                            } label: {
                                Text("settings.title")
                            }
                            
                            NavigationLink {
                                AboutScreen()
                            } label: {
                                Text("about.title")
                            }
                        }
                        
                        
                        Button("more.logout") {
                            self.isLogged = false
                            self.selectedTabIndex = 2
                        }
                        .foregroundColor(.red)
                        
                    }
                    
//                    .listSectionSeparator(.hidden, edges: .all)
                    .padding(.top, -20)
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("more.headline".localized(language))
        }
        
    }
}

struct MoreScreen_Previews: PreviewProvider {
    static var previews: some View {
        MoreScreen(selectedTabIndex: .constant(2))
    }
}
