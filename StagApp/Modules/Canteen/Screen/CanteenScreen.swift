//
//  DietScreen.swift.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 24.11.2021.
//

import SwiftUI



struct CanteenScreen: View {
    
    enum PickerSection {
        case BORY, KOLLAROVA
    }
    
    @ObservedObject var vm: CanteenViewModel
    
    @State var date = Date()
    @State var calendarId: UUID = UUID()
    @State var canteenSelection: PickerSection = PickerSection.BORY
    
    init () {
        self._vm = ObservedObject(wrappedValue: CanteenViewModel(canteenService: CanteenService()))
    }
    
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.defaultBackground.ignoresSafeArea()
        
        
            VStack {
                
                HStack {
                    Picker("", selection: $canteenSelection) {
                        Group {
                            Text("Bory")
                                .tag(PickerSection.BORY)
                            
                            Text("Kollárova")
                                .tag(PickerSection.KOLLAROVA)
                        }
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: canteenSelection) { _ in
                        self.vm.loadCanteenMenu(canteenId: self.getCanteenId(pickerValue: self.canteenSelection), selectedDate: date)
                    }
                    
                    
                    Spacer()
                    
                    DatePicker(
                       "",
                       selection: $date,
                       displayedComponents: [.date])
                       .labelsHidden()
                       .id(calendarId)
                       .onChange(of: date) { _ in
                           calendarId = UUID()
                           
                           self.vm.loadCanteenMenu(canteenId: self.getCanteenId(pickerValue: self.canteenSelection), selectedDate: date)
                       }
                }
                .padding([.leading, .trailing])
                
                
                switch self.vm.state {
                    case .fetchingData:
                        LoadingView(text: "common.loading", withBackground: true)
                    case .idle:
                        if (self.vm.menu != nil) {
                            List {
                                Section(header: Text("canteen.main-meal").font(.system(size: 14, weight: .regular, design: .rounded))) {
                                    
                                    if (self.vm.menu!.mainCourses.isEmpty) {
                                        Text("canteen.no-meals")
                                            .font(.system(size: 16, weight: .regular, design: .rounded))
                                    }
                                    else {
                                        ForEach(self.vm.menu!.mainCourses) { mainCourse in
                                            mealCell(meal: mainCourse)
                                        }
                                    }
                                    
                                }
                                
                                
                                Section(header: Text("canteen.soup").font(.system(size: 14, weight: .regular, design: .rounded))) {
                                    
                                    if (self.vm.menu!.soups.isEmpty) {
                                        Text("canteen.no-soups")
                                            .font(.system(size: 16, weight: .regular, design: .rounded))
                                    }
                                    else {
                                        ForEach(self.vm.menu!.soups) { soup in
                                            mealCell(meal: soup)
                                        }
                                    }
                                    
                                    HStack {
                                        Text("canteen.note")
                                            .font(.system(size: 14, weight: .light, design: .rounded))
                                    }
                                    .listRowInsets(EdgeInsets())
                                    .frame(maxWidth: .infinity, minHeight: 50)
                                    .background(Color(UIColor.systemGroupedBackground))
                                }
                                
                                
                            }
                            .padding(.bottom, 50)
                            
                        }
                }
                    
                
                
                Spacer()
            }
            .onAppear() {
                self.vm.loadCanteenMenu(canteenId: self.getCanteenId(pickerValue: self.canteenSelection), selectedDate: Date())
            }
            .edgesIgnoringSafeArea(.bottom)
        
        
        }
        .navigationTitle("canteen.title")
    }
    
    private func getCanteenId(pickerValue: PickerSection) -> String {
        switch pickerValue {
        case .BORY:
            return "B"
        case .KOLLAROVA:
            return "K"
        }
    }
}

struct mealCell: View {
    
    let meal: Meal
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(meal.number == 0 ? "\(meal.name)" :"\(meal.number). \(meal.name)")
                .font(.system(size: 17, weight: .bold, design: .rounded))
            
            Text(meal.allergensToString())
                .font(.system(size: 14, weight: .light, design: .rounded))
            
            Text(meal.pricesToString())
                .font(.system(size: 15, weight: .medium, design: .rounded))
        }
    }
}

struct DietScreen_Previews: PreviewProvider {
    static var previews: some View {
        CanteenScreen()
    }
}
