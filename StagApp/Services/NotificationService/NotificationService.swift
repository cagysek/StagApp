//
//  NotificationService.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 17.07.2022.
// e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"com.cagy.StagApp.notifications"]




import Foundation
import UserNotifications
import BackgroundTasks


class NotificationService: ObservableObject {
    
    private let IDENTIFIER = "com.cagy.StagApp.notifications"
    
    init() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            
            if let error = error {
                print(error)
            }
            
            // Enable or disable features based on the authorization.
        }
        
        
//
//        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
//
//            let content = UNMutableNotificationContent()
//            content.title = "Feed the cat"
//            content.subtitle = "It looks hungry"
//            content.sound = UNNotificationSound.default
//
//            // show this notification five seconds from now
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//
//            // choose a random identifier
//            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//
//            // add our notification request
//            UNUserNotificationCenter.current().add(request)
//            print("added")
//        }
    }
    
    func register() {
        print("Register")
        BGTaskScheduler.shared.register(forTaskWithIdentifier: self.IDENTIFIER, using: nil) { task in
            
                self.handleAppRefresh(task: task as! BGAppRefreshTask)
            }
        }
    
    
    func handleAppRefresh(task: BGAppRefreshTask) {
        print("handle")
        // Schedule a new refresh task.
        scheduleAppRefresh()

       
       // Provide the background task with an expiration handler that cancels the operation.
       task.expirationHandler = {
          print("expired")
       }

        
                    let content = UNMutableNotificationContent()
                    content.title = "Feed the cat"
                    content.subtitle = "It looks hungry"
                    content.sound = UNNotificationSound.default
        
                    // show this notification five seconds from now
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
                    // choose a random identifier
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
                    // add our notification request
                    UNUserNotificationCenter.current().add(request)
        
        
        print("HELLO")
        

        task.setTaskCompleted(success: true)
     }
    
    
    func scheduleAppRefresh() {
        print("AA")
        let request = BGAppRefreshTaskRequest(identifier: self.IDENTIFIER)
        
        let timeDelay = 10.0
        
        request.earliestBeginDate = Date(timeIntervalSinceNow: timeDelay)
//        request.earliestBeginDate = .now.addingTimeInterval(20)
        do {
            try BGTaskScheduler.shared.submit(request)
            
        } catch {
            print("Could not schedule app refresh: \(error)")
        }
    }
    
    
    
}
