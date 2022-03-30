//
//  WebViewViewModel.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 23.03.2022.
//

import Foundation
import Combine

class WebViewViewModel: ObservableObject {
    var webViewNavigationPublisher = PassthroughSubject<WebViewNavigation, Never>()
    var showWebTitle = PassthroughSubject<String, Never>()
    var showLoader = PassthroughSubject<Bool, Never>()
    var valuePublisher = PassthroughSubject<String, Never>()
}

enum WebViewNavigation {
    case backward, forward, reload
}

enum WebUrlType {
    case localUrl, publicUrl
}
