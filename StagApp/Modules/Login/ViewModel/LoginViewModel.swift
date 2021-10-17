//
//  LoginViewModel.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 13.10.2021.
//

import Foundation

protocol LoginViewModel: ObservableObject {
    func getLogin() async
}

@MainActor
final class LoginViewModelImpl: LoginViewModel {

    @Published private(set) var data: [Credentials] = []
    
    private let stagService: StagService
    
    init(stagService: StagService) {
        self.stagService = stagService
    }
    
    func getLogin() async {
        do {
            self.data = try await stagService.fetch()
        } catch {
            print(error)
        }
    }
}

