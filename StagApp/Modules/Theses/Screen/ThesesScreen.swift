//
//  ThesesScreen.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 21.03.2022.
//

import SwiftUI

struct ThesesScreen: View {
    
    @ObservedObject var vm: ThesesViewModel
    
    init () {
        self._vm = ObservedObject(wrappedValue: ThesesViewModel(stagService: StagService(), teacherRepository: TeacherRepository(context: CoreDataManager.getContext())))
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.defaultBackground
                .ignoresSafeArea()
            
            switch self.vm.state {
                case .idle:
                    if (self.vm.theses.isEmpty) {
                        WhiteComponent(text: "theses.empty")
                    } else {
                        ScrollView(.vertical, showsIndicators: false) {
                            ForEach(self.vm.theses, id: \.id) { thesis in
                                TheseCellView(thesis: thesis)
                            }
                        }
                    }
                
                case .fetchingData:
                    LoadingView(text: "common.loading", withBackground: true)
            }
                
                
            
        }
        .onAppear() {
            self.vm.loadTheses()
        }
        .navigationTitle("theses.title")
        .navigationBarTitleDisplayMode(.inline)
            
        
        
    }
}

struct ThesesScreen_Previews: PreviewProvider {
    static var previews: some View {
        ThesesScreen()
    }
}
