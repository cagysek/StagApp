import SwiftUI
import Sentry


@main
/// Project root file, cointains global settings logic
struct StagApp: App {

    @AppStorage(UserDefaultKeys.LANGUAGE) private var language = LanguageService.shared.language
    
    @ObservedObject var monitor = CheckNetworkService()
    
    @State private var showAlert = false
    @State private var alertData = AlertData.empty
    
    
    init() {
        SentrySDK.start { options in
            options.dsn = "https://" + ConfigurationManager.stringValue(forKey: "SENTRY_DSN")
            options.debug = false // Enabled debug when first installing is always helpful

            // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
            // We recommend adjusting this value in production.
            options.tracesSampleRate = 1.0
            
        }
    }
    
    
    var body: some Scene {
        WindowGroup {
            ZStack() {
                ContentView()
                    .environment(\.managedObjectContext, CoreDataManager.getContext())
                    .environment(\.locale, .init(identifier: self.language == ELanguage.system.rawValue ? Locale.current.languageCode ?? ELanguage.DEFAULT : self.language))
                
                    .onReceive(NotificationCenter.default.publisher(for: .showAlert)) { notif in
                        if let data = notif.object as? AlertData {
                            alertData = data
                            showAlert = true
                        }
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: alertData.title, message: alertData.msg, dismissButton: .default(Text("Ok")))
                    }
                
                if (!self.monitor.isConnected) {
                    ZStack() {
                        Capsule()
                            .foregroundColor(.red)
                            .opacity(0.7)
                            .frame(width: 200, height: 30)
                                
                        Text("common.no-internet".localized(self.language == ELanguage.system.rawValue ? Locale.current.languageCode ?? ELanguage.DEFAULT : self.language))
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundColor(.white)
                    }
                }
            }
            
        }
        
    }
}
