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
    
    @State private var selectedSection: PickerSection = .INFO
    
    @StateObject var vm = SubjectDetailViewModel(stagService: StagService())
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                Color.defaultBackground
                    .ignoresSafeArea()
                
                
                VStack(alignment: .leading) {
                    InformationBubble(title: nil) {
                        HStack {
                            Spacer()
                            StatisticLabelView(label: "Místnost", value: "\(self.scheduleAction?.building ?? "")-\(self.scheduleAction?.room ?? "")")
                            Spacer()
                            StatisticLabelView(label: "Čas", value: self.scheduleAction?.getTimeOfAction() ?? "")
                            Spacer()
                            StatisticLabelView(label: "Typ", value: self.scheduleAction?.labelShort ?? "")
                            Spacer()
                        }
                    }
                    .frame(height: 80)
                    .padding([.leading, .trailing])
                    
                    
                    Picker("Selected section:", selection: $selectedSection) {
                        Group {
                            Text("Info")
                                .tag(PickerSection.INFO)
                            
                            Text("Studenti (\(self.vm.subjectstudents.count))")
                                .tag(PickerSection.STUDENTS)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding([.leading, .trailing])
                    .padding(.top, 5)
                    
                    
                    if (self.selectedSection == .INFO) {
                        if (self.vm.subjectDetail != nil) {
                            SubjectInfoView(subjectDetail: self.vm.subjectDetail!)
                                .padding([.leading, .trailing])
                        }
                        
                    } else if (self.selectedSection == .STUDENTS) {
                        SubjectStudentsView(subjectStudents: self.vm.subjectstudents)
                    }
                    
                    
                    Spacer()
                    
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle(self.vm.subjectDetail?.title ?? "")
                .navigationBarItems(
                    leading:
                        Button {
                            self.dismiss()
                        } label: {
                            Image(systemName: "chevron.down")
                                .font(.system(size: 18, weight: .bold))
                                .scaledToFit()
                        },
                    trailing:
                        Group {
                            if (self.vm.subjectDetail != nil && self.vm.subjectDetail!.subjectUrl != nil) {
                                Link(destination: URL(string: self.vm.subjectDetail!.subjectUrl!)!) {
                                    Image(systemName: "w.circle")
                                        .font(.system(size: 18, weight: .bold))
                                        .scaledToFit()
                                }
                            }
                        }
                )
                
            }
            .ignoresSafeArea(.all, edges: .bottom)
            .task {
                if (self.scheduleAction != nil) {
                    await self.vm.loadSubjectDetail(department: self.scheduleAction!.department, short: self.scheduleAction!.titleShort)
                    await self.vm.loadSubjectStudents(subjectId: self.scheduleAction!.id)
                }
            }
        }
    }
}


struct SubjectInfoView: View {
    
    var subjectDetail: SubjectDetail
    
    var body: some View {
        VStack(alignment: .leading) {
            
            ScrollView {
                
                InformationBubble(title: "Název") {
                    HStack {
                        Text(self.subjectDetail.title)
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .lineLimit(5)
                        Spacer()
                    }
                    .padding(.leading)
                    .padding(.trailing)
                }
                
                InformationBubble(title: "Obecné") {
                    HStack {
                        Spacer()
                        StatisticLabelView(label: "Pracoviště", value: subjectDetail.department)
                        Spacer()
                        StatisticLabelView(label: "Zkratka", value: subjectDetail.short)
                        Spacer()
                        StatisticLabelView(label: "Kredity", value: String(subjectDetail.credits))
                        Spacer()
                    }
                }
                
                InformationBubble(title: "Rozsah hodin týdně") {
                    HStack {
                        Spacer()
                        StatisticLabelView(label: "Přednáška", value: String(subjectDetail.lectureCount))
                        Spacer()
                        StatisticLabelView(label: "Cvičení", value: String(subjectDetail.practiseCount))
                        Spacer()
                        StatisticLabelView(label: "Seminář", value: String(subjectDetail.seminarCount))
                        Spacer()
                    }
                }
                
                InformationBubble(title: "Zakončení") {
                    HStack {
                        Spacer()
                        StatisticLabelView(label: "Způsob", value: subjectDetail.examType)
                        Spacer()
                        StatisticLabelView(label: "Forma", value: subjectDetail.examForm)
                        Spacer()
                        StatisticLabelView(label: "Záp. před zk.", value: subjectDetail.creaditBeforeExam)
                        Spacer()
                    }
                }
                
                InformationBubble(title: "Garant") {
                    VStack(spacing:10) {
                        ForEach(self.explodeTeachers(teacherString: subjectDetail.garants), id: \.self) { teacherName in
                            HStack {
                                Text(teacherName.replacingOccurrences(of: "\'", with: ""))
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .padding(.leading)
                                Spacer()
                            }
                        }
                    }
                }
                
                InformationBubble(title: "Přednáčející") {
                    VStack(spacing:10) {
                        ForEach(self.explodeTeachers(teacherString: subjectDetail.speakers), id: \.self) { teacherName in
                            HStack {
                                Text(teacherName.replacingOccurrences(of: "\'", with: ""))
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .padding(.leading)
                                Spacer()
                            }
                        }
                    }
                }
                
                
                InformationBubble(title: "Cvičící") {
                    VStack(spacing:10) {
                        ForEach(self.explodeTeachers(teacherString: subjectDetail.practitioners), id: \.self) { teacherName in
                            HStack {
                                Text(teacherName.replacingOccurrences(of: "\'", with: ""))
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .padding(.leading)
                                Spacer()
                            }
                        }
                    }
                }
            
                
                if (!subjectDetail.seminarTeachers.isEmpty) {
                    InformationBubble(title: "Seminář") {
                        VStack(spacing:10) {
                            ForEach(self.explodeTeachers(teacherString: subjectDetail.seminarTeachers), id: \.self) { teacherName in
                                HStack {
                                    Text(teacherName.replacingOccurrences(of: "\'", with: ""))
                                        .font(.system(size: 16, weight: .medium, design: .rounded))
                                        .padding(.leading)
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                
                
                // To much elements for one body.. another in next view
                AnotherSubjectInfo(subjectDetail: subjectDetail)
                
            }
        }
    }
    
    fileprivate func explodeTeachers(teacherString: String) -> [String] {
    
        if (teacherString.isEmpty) {
            return []
        }
        
        let regex = "([\"'])(?:(?=(\\\\?))\\2.)*?\\1"
    
        
        return teacherString.matchingStrings(regex: regex)
    }
}




struct AnotherSubjectInfo: View {
    
    var subjectDetail: SubjectDetail
    
    var body: some View {
        
        InformationBubble(title: "Podmiňující předměty") {
            HStack {
                Text(subjectDetail.requiredSubjects)
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .padding(.leading)
                Spacer()
            }
        }
        
        InformationBubble(title: "Cíl předmětu") {
            HStack {
                Text(subjectDetail.goal)
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .padding(.leading)
                Spacer()
            }
        }
        
        
        InformationBubble(title: "Požadavky na studenta") {
            HStack {
                Text(subjectDetail.requirements)
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .padding(.leading)
                Spacer()
            }
        }
        
        
        InformationBubble(title: "Obsah") {
            HStack {
                Text(subjectDetail.content)
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .padding(.leading)
                Spacer()
            }
        }
        
        
        InformationBubble(title: "Literatura") {
            HStack {
                Text(subjectDetail.literature)
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
    
    var subjectStudents: [SubjectStudent]
    
    var body: some View {
        VStack {
            List {
                ForEach(self.subjectStudents, id: \.id) { student in
                    VStack(alignment: .leading) {
                        Text(student.getFormattedName())
                            .font(.system(size: 18, weight: .medium, design: .rounded))
                        
                        Text(StringHelper.concatStringsToOne(
                            strings: "\(student.studyYear). ročník", student.id
                        ))
                            .font(.system(size: 14, weight: .light, design: .rounded))
                        
                        Text(StringHelper.concatStringsToOne(
                            strings: student.faculty, student.fieldOfStudy
                        ))
                            .truncationMode(.tail)
                            .font(.system(size: 14, weight: .light, design: .rounded))
                    }
                }
            }
        }
        
    }
}

struct SubjectDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        SubjectStudentsView(subjectStudents: [SubjectStudent(id: "1111", firstname: "test", lastname: "prijmeni", faculty: "Fav", fieldOfStudy: "Informační systémy", studyYear: "3", titleBefore: "Bc.", titleAfter: nil)])
    }
}
