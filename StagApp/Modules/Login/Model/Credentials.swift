//
//  Credentials.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 13.10.2021.
//

import Foundation

struct Credentials: Decodable {
    let username: String
    let password: String
}


extension Credentials {
    static let dummyData: Credentials = Credentials(username: "cagy", password: "pass");
}
