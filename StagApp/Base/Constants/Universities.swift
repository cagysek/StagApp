//
//  Universities.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 28.02.2022.
//

import Foundation

enum Universities {
    
    
    static let universities: [University] = [
        University(id: 1, title: "Akademie výtvarných umění v Praze", url: "https://stag-avu.zcu.cz/ws", smallLogoImagePath: "01-avu-simple", bigLogoImagePath: "01-avu"),
        University(id: 2,title: "Jihočeská univerzita v Českých Budějovicích", url: "https://stag-ws.jcu.cz/ws", smallLogoImagePath: "02-jiho-simple", bigLogoImagePath: "02-jiho"),
        University(id: 3,title: "Ostravská univerzita", url: "https://wsstag.osu.cz/ws", smallLogoImagePath: "03-ostrava-simple", bigLogoImagePath: "03-ostrava"),
        University(id: 4,title: "Technická univerzita v Liberci", url: "https://stag-ws.tul.cz/ws", smallLogoImagePath: "04-liberec-simple", bigLogoImagePath: "04-liberec"),
        University(id: 5,title: "Univerzita Hradec Králové", url: "https://stagws.uhk.cz/ws", smallLogoImagePath: "05-hradec-simple", bigLogoImagePath: "05-hradec"),
        University(id: 6,title: "Univerzita Jana Evangelisty Purkyně v Ústí nad Labem", url: "https://ws.ujep.cz/ws", smallLogoImagePath: "06-ujep-simple", bigLogoImagePath: "06-ujep"),
        University(id: 7,title: "Univerzita Pardubice", url: "https://stag-ws.upce.cz/ws", smallLogoImagePath: "07-pardubice-simple", bigLogoImagePath: "07-pardubice"),
//        University(id: 8,title: "Univerzita Palackého v Olomouci", url: "https://stag-ws.upol.cz/ws", smallLogoImagePath: "08-olomouc-simple", bigLogoImagePath: "08-olomouc"),
        University(id: 9,title: "Univerzita Tomáše Bati ve Zlíně", url: "https://stag-ws.utb.cz/ws", smallLogoImagePath: "09-bata-simple", bigLogoImagePath: "09-bata"),
        University(id: 10,title: "Veterinární a farmaceutická univerzita Brno", url: "https://stagweb.vfu.cz/ws", smallLogoImagePath: "10-brno-simple", bigLogoImagePath: "10-brno"),
        University(id: 11,title: "Vysoká škola PRIGO", url: "https://stag-vsss.zcu.cz/ws", smallLogoImagePath: "11-prigo-simple", bigLogoImagePath: "11-prigo"),
        University(id: 12,title: "Západočeská univerzita v Plzni", url: "https://stag-ws.zcu.cz/ws", smallLogoImagePath: "12-zcu-simple", bigLogoImagePath: "12-zcu"),
        University(id: 13,title: "DEMO - Západočeská univerzita v Plzni", url: "https://stag-demo.zcu.cz/ws", smallLogoImagePath: "12-zcu-simple", bigLogoImagePath: "12-zcu"),
    ];
    
    static func getUniversityById(id: Int) -> University? {
        let index = id - 1
        
        if (index < 0 || index > universities.count) {
            return nil
        }
        
        return universities[index]
    }
    
}
