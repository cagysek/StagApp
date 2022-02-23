//
//  University.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 21.02.2022.
//

import Foundation

class University: Identifiable {
    let id: Int
    let title: String
    let url: String
    let smallLogoImagePath: String
    let bigLogoImagePath: String
    
    init(id: Int, title: String, url: String, smallLogoImagePath: String, bigLogoImagePath: String) {
        self.id = id
        self.title = title
        self.url = url
        self.smallLogoImagePath = smallLogoImagePath
        self.bigLogoImagePath = bigLogoImagePath
    }
}
