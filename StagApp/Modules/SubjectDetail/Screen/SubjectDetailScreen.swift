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
                            StatisticLabelView(label: "scheduleDetail.room", value: "\(self.scheduleAction?.building ?? "")-\(self.scheduleAction?.room ?? "")")
                            Spacer()
                            StatisticLabelView(label: "scheduleDetail.time", value: self.scheduleAction?.getTimeOfAction() ?? "")
                            Spacer()
                            StatisticLabelView(label: "scheduleDetail.type", value: self.scheduleAction?.labelShort ?? "")
                            Spacer()
                        }
                    }
                    .frame(height: 80)
                    .padding([.leading, .trailing])
                    
                    
                    Picker("scheduleDetail.select-section", selection: $selectedSection) {
                        Group {
                            Text("scheduleDetail.info")
                                .tag(PickerSection.INFO)
                            
                            Text("scheduleDetail.students \(self.vm.subjectstudents.count)")
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
                    
                    await self.vm.loadSubjectStudents(subjectId: self.scheduleAction!.scheduleId!)
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
                
                InformationBubble(title: "scheduleDetail.title") {
                    HStack {
                        Text(self.subjectDetail.title)
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .lineLimit(5)
                        Spacer()
                    }
                    .padding(.leading)
                    .padding(.trailing)
                }
                
                InformationBubble(title: "scheduleDetail.general") {
                    HStack {
                        Spacer()
                        StatisticLabelView(label: "scheduleDetail.department", value: subjectDetail.department)
                        Spacer()
                        StatisticLabelView(label: "scheduleDetail.shortcut", value: subjectDetail.short)
                        Spacer()
                        StatisticLabelView(label: "scheduleDetail.credits", value: String(subjectDetail.credits))
                        Spacer()
                    }
                }
                
                InformationBubble(title: "scheduleDetail.range-of-hours-per-week") {
                    HStack {
                        Spacer()
                        StatisticLabelView(label: "scheduleDetail.lecture", value: String(subjectDetail.lectureCount))
                        Spacer()
                        StatisticLabelView(label: "scheduleDetail.exercise", value: String(subjectDetail.practiseCount))
                        Spacer()
                        StatisticLabelView(label: "scheduleDetail.seminar", value: String(subjectDetail.seminarCount))
                        Spacer()
                    }
                }
                
                InformationBubble(title: "scheduleDetail.course-completion") {
                    HStack {
                        Spacer()
                        StatisticLabelView(label: "scheduleDetail.course-completion-type", value: subjectDetail.examType)
                        Spacer()
                        StatisticLabelView(label: "scheduleDetail.course-completion-form", value: subjectDetail.examForm)
                        Spacer()
                        StatisticLabelView(label: "scheduleDetail.course-completion-credit-before", value: subjectDetail.creaditBeforeExam)
                        Spacer()
                    }
                }
                
                InformationBubble(title: "scheduleDetail.guarantors") {
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
                
                InformationBubble(title: "scheduleDetail.lecturers") {
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
                
                
                InformationBubble(title: "scheduleDetail.practitioners") {
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
                    InformationBubble(title: "scheduleDetail.seminarians") {
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
        
        InformationBubble(title: "scheduleDetail.prerequisite-courses") {
            HStack {
                Text(subjectDetail.requiredSubjects)
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .padding(.leading)
                Spacer()
            }
        }
        
        InformationBubble(title: "scheduleDetail.course-objectives") {
            HStack {
                Text(subjectDetail.goal)
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .padding(.leading)
                Spacer()
            }
        }
        
        
        InformationBubble(title: "scheduleDetail.requirements-on-student") {
            HStack {
                Text(subjectDetail.requirements)
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .padding(.leading)
                Spacer()
            }
        }
        
        
        InformationBubble(title: "scheduleDetail.content") {
            HStack {
                Text(subjectDetail.content)
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .padding(.leading)
                Spacer()
            }
        }
        
        
        InformationBubble(title: "scheduleDetail.literature") {
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
                    Text(LocalizedStringKey(self.title!))
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
                        
                        (
                            Text(String(format: NSLocalizedString("scheduleDetail.year %@", comment: "year"), student.studyYear)) + Text(StringHelper.concatStringsToOne(
                            strings: student.id,
                            separatorOnFirstPosition: true
                        ))
                        )
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
