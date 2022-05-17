
import Foundation
import UIKit
import SwiftUI
import Combine
import WebKit
import UIKit

// MARK: - WebViewHandlerDelegate
/// For printinf values received from web app
protocol WebViewHandlerDelegate {
    func receivedJsonValueFromWebView(value: [String: Any?])
    func receivedStringValueFromWebView(value: String)
}


/// Definition of  custom `WebView` View for external login
struct ExternalLoginWebView: UIViewRepresentable {
    
    @Environment(\.dismiss) var dismiss
    
    var url: String
    
    @Binding var externalLoginResult: ExternalLoginResult?
    
    // Viewmodel object
    @ObservedObject var viewModel: WebViewViewModel = WebViewViewModel()
    
    // Make a coordinator to co-ordinate with WKWebView's default delegate functions
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        
        // Enable javascript in WKWebView
        
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preferences
        
        let webView = WKWebView(frame: .zero, configuration: configuration)

        webView.navigationDelegate = context.coordinator

        
       return webView
    }
    

    
    func updateUIView(_ webView: WKWebView, context: Context) {
        
        let request = URLRequest(url: URL(string: self.url)!)
        
        webView.load(request)
    }
    
    class Coordinator : NSObject, WKNavigationDelegate {
        var parent: ExternalLoginWebView
        var delegate: WebViewHandlerDelegate?
        var valueSubscriber: AnyCancellable? = nil
        var webViewNavigationSubscriber: AnyCancellable? = nil
        
        init(_ uiWebView: ExternalLoginWebView) {
            self.parent = uiWebView
        }
        
        deinit {
            valueSubscriber?.cancel()
            webViewNavigationSubscriber?.cancel()
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // Get the title of loaded webcontent
            webView.evaluateJavaScript("document.title") { (response, error) in
                if let error = error {
                    print("Error getting title")
                    print(error.localizedDescription)
                }
                
                guard let title = response as? String else {
                    return
                }
                
                self.parent.viewModel.showWebTitle.send(title)
            }
            
            /* An observer that observes 'viewModel.valuePublisher' to get value from TextField and
             pass that value to web app by calling JavaScript function */
            valueSubscriber = parent.viewModel.valuePublisher.receive(on: RunLoop.main).sink(receiveValue: { value in
                let javascriptFunction = "valueGotFromIOS(\(value));"
                webView.evaluateJavaScript(javascriptFunction) { (response, error) in
                    if let error = error {
                        print("Error calling javascript:valueGotFromIOS()")
                        print(error.localizedDescription)
                    } else {
                        print("Called javascript:valueGotFromIOS()")
                    }
                }
            })
            
            // Page loaded so no need to show loader anymore
            self.parent.viewModel.showLoader.send(false)
        }
        
        /* Here I implemented most of the WKWebView's delegate functions so that you can know them and
         can use them in different necessary purposes */
        
        func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
            // Hides loader
            parent.viewModel.showLoader.send(false)
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            // Hides loader
            parent.viewModel.showLoader.send(false)
        }
        
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            // Shows loader
            parent.viewModel.showLoader.send(true)
        }
        
        func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
            
            guard let serverTrust = challenge.protectionSpace.serverTrust  else {
                completionHandler(.useCredential, nil)
                return
            }
            let credential = URLCredential(trust: serverTrust)
            completionHandler(.useCredential, credential)
        }
        
     
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            // Shows loader
            parent.viewModel.showLoader.send(true)
            self.webViewNavigationSubscriber = self.parent.viewModel.webViewNavigationPublisher.receive(on: RunLoop.main).sink(receiveValue: { navigation in
                switch navigation {
                    case .backward:
                        if webView.canGoBack {
                            webView.goBack()
                        }
                    case .forward:
                        if webView.canGoForward {
                            webView.goForward()
                        }
                    case .reload:
                        webView.reload()
                }
            })
        }
        
        // This function is essential for intercepting every navigation in the webview
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            guard let url = navigationAction.request.url else {
                decisionHandler(.allow)
                return
            }
            
            let originalURL = url.valueOf("originalURL")
            
            if (originalURL == nil && url.absoluteString.contains("stag-client.cz")) {
                    // this means login successful
                decisionHandler(.cancel)
                
                self.parent.externalLoginResult = ExternalLoginResult(stagUserTicket: url.valueOf("stagUserTicket"), stagUserName: url.valueOf("stagUserName"), stagUserRole: url.valueOf("stagUserRole"), stagUserInfo: url.valueOf("stagUserInfo"))
                
                self.parent.dismiss()
            }
            else {
                decisionHandler(.allow)
            }
            
        }
    }
}

extension WKWebView {
    public func constraint(toView contentView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}

