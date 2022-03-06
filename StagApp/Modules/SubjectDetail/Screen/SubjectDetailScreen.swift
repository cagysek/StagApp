//
//  SubjectDetailScreen.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 06.03.2022.
//

import SwiftUI


fileprivate enum PickerSection {
    case INFO, STUDENTS
}

struct SubjectDetailScreen: View {
    
    @Binding var scheduleAction: ScheduleAction?
    
    @State private var selectedSection: PickerSection = .STUDENTS
    
    @StateObject var vm = SubjectDetailViewModel(stagService: StagService())
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                Color.defaultBackground
                    .ignoresSafeArea()
                
                
                VStack(alignment: .leading) {
                    InformationBubble(title: nil) {
                        HStack {
                            Spacer()
                            StatisticLabelView(label: "Místnost", value: "UP-108")
                            Spacer()
                            StatisticLabelView(label: "Čas", value: "08:40 - 12:10")
                            Spacer()
                            StatisticLabelView(label: "Typ", value: "Cvičení")
                            Spacer()
                        }
                    }
                    .frame(height: 110)
                    
                    
                    Picker("Selected section:", selection: $selectedSection) {
                        Group {
                            Text("Info")
                                .tag(PickerSection.INFO)
                            
                            Text("Studenti")
                                .tag(PickerSection.STUDENTS)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    
                    if (self.selectedSection == .INFO) {
                        SubjectInfoView()
                    } else if (self.selectedSection == .STUDENTS) {
                        SubjectStudentsView()
                    }
                    
                    
                    Spacer()
                    
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle(self.vm.subjectDetail?.title ?? "")
                .padding()
            }
            .ignoresSafeArea(.all, edges: .bottom)
            .task {
                if (self.scheduleAction != nil) {
                    
                    await self.vm.loadSubjectDetail(department: self.scheduleAction!.department, short: self.scheduleAction!.titleShort)
                    
                }
                else {
                    print("nil")
                }
            }
            
        }
        
        
    }
}


struct SubjectInfoView: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            
            ScrollView {
                
                
                InformationBubble(title: "Obecné") {
                    HStack {
                        Spacer()
                        StatisticLabelView(label: "Pracoviště", value: "KIV")
                        Spacer()
                        StatisticLabelView(label: "Zkratka", value: "FJP")
                        Spacer()
                        StatisticLabelView(label: "Kredity", value: "6")
                        Spacer()
                    }
                }
                
                InformationBubble(title: "Rozsah hodin týdně") {
                    HStack {
                        Spacer()
                        StatisticLabelView(label: "Přednáška", value: "1")
                        Spacer()
                        StatisticLabelView(label: "Cvičení", value: "2")
                        Spacer()
                        StatisticLabelView(label: "Seminář", value: "2")
                        Spacer()
                    }
                }
                
                InformationBubble(title: "Zakončení") {
                    HStack {
                        Spacer()
                        StatisticLabelView(label: "Způsob", value: "Zkouška")
                        Spacer()
                        StatisticLabelView(label: "Forma", value: "Kombinovaná")
                        Spacer()
                        StatisticLabelView(label: "Záp. před zk.", value: "Ano")
                        Spacer()
                    }
                }
                
                InformationBubble(title: "Garant") {
                    HStack {
                        Text("Ing. Richard Lipka, Ph.D.")
                            .font(.system(size: 18, weight: .medium, design: .rounded))
                            .padding(.leading)
                        Spacer()
                    }
                }
                
                InformationBubble(title: "Přednáčející") {
                    VStack(spacing:10) {
                        HStack {
                            Text("Prof. Ing. Karel Ježek, CSc.")
                                .font(.system(size: 18, weight: .medium, design: .rounded))
                                .padding(.leading)
                            Spacer()
                        }
                        HStack {
                            Text("Ing. Richard Lipka, Ph.D.")
                                .font(.system(size: 18, weight: .medium, design: .rounded))
                                .padding(.leading)
                            Spacer()
                        }
                    }
                }
                
                
                InformationBubble(title: "Cvičící") {
                    VStack(spacing:10) {
                        HStack {
                            Text("Prof. Ing. Karel Ježek, CSc.")
                                .font(.system(size: 18, weight: .medium, design: .rounded))
                                .padding(.leading)
                            Spacer()
                        }
                        HStack {
                            Text("Ing. Richard Lipka, Ph.D.")
                                .font(.system(size: 18, weight: .medium, design: .rounded))
                                .padding(.leading)
                            Spacer()
                        }
                    }
                }
            
                
                InformationBubble(title: "Seminář") {
                    VStack(spacing:10) {
                        HStack {
                            Text("Prof. Ing. Karel Ježek, CSc.")
                                .font(.system(size: 18, weight: .medium, design: .rounded))
                                .padding(.leading)
                            Spacer()
                        }
                        HStack {
                            Text("Ing. Richard Lipka, Ph.D.")
                                .font(.system(size: 18, weight: .medium, design: .rounded))
                                .padding(.leading)
                            Spacer()
                        }
                    }
                }
                
                // To much elements for one body.. another in next view
                AnotherSubjectInfo()
                
            }
        }
    }
        
}


struct AnotherSubjectInfo: View {
    
    var body: some View {
        
        InformationBubble(title: "Podmiňující předměty") {
            HStack {
                Text("KIV/SAR, KIV/SAR-E, KIV/PIA, KIV/VSP, KIV/VSS, KIV/VSS-E")
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .padding(.leading)
                Spacer()
            }
        }
        
        
        
        InformationBubble(title: "Cíl předmětu") {
            HStack {
                Text("Dát studentům důkladné znalosti o prostředcích a metodách zpracování formálních jazyků a jejich využití při implrmentaci programovacích jazyků, editorů, příkazových interpretů apod. Seznámit studenty s formálními metodami konstruování software.")
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .padding(.leading)
                Spacer()
            }
        }
        
        
        InformationBubble(title: "Požadavky na studenta") {
            HStack {
                Text("Vypracování a obhájení semestrálního softwarového projektu. Získání alespoň 50% z možných bodů hodnocení projektu a alespoň 50% z možných bodů hodnocení zkoušky.\r\n\r\nZ důvodu průběžné aktualizace předmětu je pro získání zápočtu při opakovaném zapsání předmětu (viz SZŘ čl. 24 odst. 3) nutné souhlasné vyjádření garanta předmětu.\r\n\r\nUpozornění:\r\nTermíny a forma ověřování splnění požadavků mohou být upraveny s ohledem na opatření vyhlášená v souvislosti s vývojem epidemiologické situace v ČR.")
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .padding(.leading)
                Spacer()
            }
        }
        
        
        InformationBubble(title: "Obsah") {
            HStack {
                Text("1-Typy překladačů, základní struktura překladače.\r\n2-Regulární gramatiky a konečné automaty v lexikální analýze. FLEX.\r\n3-Úvod do syntaktické analýzy, metoda rekurzivního sestupu.\r\n4-Překlad příkazů.\r\n5-Zpracování deklarací.\r\n6-Přidělování paměti.\r\n7-Interpretační zpracování. Průběžný test.\r\n8-Generování cílového kódu.\r\n9-Vlastnosti bezkontextových gramatik.\r\n10-Deterministická analýza shora dolů.\r\n11-LL(1) transformace.\r\n12-Deterministická analýza zdola nahoru, LR gramatiky.\r\n13-Formální metody konstrukce software, generátory překladačů. \r\n")
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .padding(.leading)
                Spacer()
            }
        }
        
        
        InformationBubble(title: "Literatura") {
            HStack {
                Text("'Thain, Douglas. Introduction to Compilers and Language Design. 2020. ISBN 979-8-655-18026-0.',\n'Reinhard Wilhelm Helmut Seidl Sebastian Hack. Compiler Design. Berlin, 2013. ISBN 978-3-642-17539-8.',\n'Aho, Alfred V.; Sethi, Ravi; Ullman, Jeffrey D. Compilers : principles, techniques, and tools. Reading : Addison-Wesley, 1988. ISBN 0-201-10088-6.',\n'Aho, Alfred V. Compilers : principles, techniques, and tools. 2nd ed. Boston : Pearson Education, 2007. ISBN 0-321-49169-6.',\n'Molnár, Ludovít; Melichar, Bořivoj; Češka, Milan. Gramatiky a jazyky. Bratislava : Alfa, 1987. ',\n'Melichar, Bořivoj. Jazyky a překlady. Vyd. 2., přeprac. Praha : Vydavatelství ČVUT, 2003. ISBN 80-01-02776-7.',\n'Melichar, Bořivoj. Konstrukce překladačů. I. část. Vyd. 1. Praha : Vydavatelství ČVUT, 1999. ISBN 80-01-02028-2.'")
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .padding(.leading)
                Spacer()
            }
        }
    }
}


struct InformationBubble<Content: View>: View {
    var title: String?
    var content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if (self.title != nil) {
                HStack {
                    Text(self.title!)
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.gray)
                    Spacer()
                }
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white)
                
                VStack {
                    
                    self.content()
                    
                    
                }
                .padding(.top)
                .padding(.bottom)
                
            }
            .shadow(color: Color.shadow, radius: 4)
        }
        .padding(.top)
    }
}


struct SubjectStudentsView: View {
    
    var body: some View {
        VStack {
            List {
                
            }
        }
        
    }
}

//struct SubjectDetailScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        SubjectDetailScreen()
//    }
//}
