//
//  SubjectResultView.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 23.10.2021.
//

import SwiftUI

struct SubjectResultView: View {
    var body: some View {
        ZStack(alignment: .leading){
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .padding()
            
            VStack(alignment: .leading, spacing: 5) {
                (Text("Manažerské techniky").bold() + Text(" KIV/MNT")).font(.system(size: 18, design: .rounded))
                Text("6 kreditů").font(.system(size: 15, design: .rounded))
                (Text("Zápočet").bold() + Text("∙ Bohuslav Theimer ∙ 20.01.2021")).font(.system(size: 15, design: .rounded))
                (Text("Zkouška").bold() + Text("∙ Bohuslav Theimer ∙ 20.01.2021")).font(.system(size: 15, design: .rounded))
                (Text("Hodnocení").bold() + Text("∙ 2")).font(.system(size: 15, design: .rounded))
            }
            .padding(.leading, 30)
            
            
        }
        .frame(height: 165)
        .shadow(color: Color.shadow, radius: 4)
        .padding(.bottom, -26)
    }
}

struct SubjectResultView_Previews: PreviewProvider {
    static var previews: some View {
        SubjectResultView()
    }
}
