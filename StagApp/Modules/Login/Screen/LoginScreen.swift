//
//  LoginScreen.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 13.10.2021.
//

import SwiftUI

struct LoginScreen: View {
    
    @AppStorage(UserDefaultKeys.IS_LOGED) private var isLogged = false
    @AppStorage(UserDefaultKeys.SELECTED_UNIVERSITY) private var selectedUniversity = 0
    
    @State private var username: String = "S20N5585P"
    @State private var password: String = "demo"
    
    @State var showUniversity: Bool = false
    @State var university: University? = nil
    
    @ObservedObject private var vm = LoginViewModelImpl(
        stagService: StagService(),
        dataManager: DataManager(stagApiService: StagService(), subjectRepository: SubjectRepository(context: CoreDataManager.getContext()), teacherRepository: TeacherRepository(context: CoreDataManager.getContext())),
        keychainManager: KeychainManager()
    )
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color
                    .defaultBackground
                    .ignoresSafeArea()
        
                    switch vm.state {
                    case .idle:
                        VStack(spacing: 0) {
                            
                            HStack {
                                Spacer()
                                
                                NavigationLink(destination: UniversityScreen(showUniversity: $showUniversity), isActive: $showUniversity) {
                                    Button("login.change-university", action: {
                                        withAnimation {
                                            self.showUniversity = true
                                        }
                                    })
                                    .buttonStyle(WhiteCapsuleButtonStyle())
                                    .font(.system(size: 14, weight: .regular, design: .rounded))
                                    
                                    .foregroundColor(Color.customBlue)
                                    .padding(.trailing, 25)
                                }
                                
                            }
                            
                            if (self.university != nil) {
                                Image(self.university!.bigLogoImagePath)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.size.width * 0.80 , height: UIScreen.main.bounds.size.height * 1/6)
                                    .padding(.bottom, 20)
                                    .padding(.top, 20)
                            }
                                
                            
                            
                            Text("login.login")
                                .font(.system(size: 32, weight: .bold, design: .rounded))
                            
                            Text("login.log-in-text")
                                .font(.system(size: 14, weight: .regular, design: .rounded))
                                .foregroundColor(.gray)
                                .padding()
                                
                            
                            TextField(
                                    "login.username",
                                     text: $username
                            )
                            .textFieldStyle(LoginTextFieldStyle())
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                            
                            SecureField(
                                    "login.password",
                                     text: $password
                            )
                            .textFieldStyle(LoginTextFieldStyle())
                            .padding(20)
                            
                            
                            Button("login.action", action: {
                                withAnimation(.easeOut(duration: 0.4)) {
                                    
                                    self.vm.getLogin(username: self.username, password: self.password)
                                    
                                    
        //                            self.vm.dataManager.deleteCachedData()
        //                            self.vm.dataManager.syncData()
        //                            self.isLogged.toggle()
                                }
                                
                            })
                            .buttonStyle(LoginButtonStyle())
                            .padding(.leading)
                            .padding(.trailing)
                            
                            Spacer()
                        }
                case .loading:
                    LoadingView(text: "common.loading", withBackground: false)
                case .error(let error):
                    Text(error)
                case .fetchingData:
                    LoadingView(text: "login.fetching-data", withBackground: false)
            }
        }
        .foregroundColor(.defaultFontColor)
        .navigationBarHidden(true)
        .onAppear {
            self.showUniversity = self.selectedUniversity == 0
            self.university = self.vm.getSelectedUniversity()
        }
        
        
                
                
               
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    
    @State static var university: University?
    
    static var previews: some View {
        LoginScreen()
    }
}
