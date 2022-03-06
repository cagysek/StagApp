//
//  ContentView.swift
//  StagApp
//
//  Created by Jan Čarnogurský on 15.08.2021.
//

import SwiftUI
import UIKit

//enum Tabs {
//     case Calendar, Exams, Student
//}


struct ContentView: View {
    
    @AppStorage(UserDefaultKeys.IS_LOGED) private var isLogged = false
    
    @State private var selection = 2
    
    @State var university: University? = nil
    
    @State var selectedDate: Date? = nil

    init() {
        // init tabBar top shaddow
        UITabBar.appearance().standardAppearance = uiTabBarAppearance
    }
   
    var body: some View {
        if (isLogged) {
            TabView(selection: $selection) {
                ScheduleScreen(selectedDate: self.$selectedDate)
                    .tabItem {
                        TabItem(title: "Rozvrh", iconName: "books.vertical");
                    }
                    .tag(0)
             
                ExamsScreen()
                    .tabItem {
                        TabItem(title: "Zkoušky", iconName: "pencil");
                    }
                    .tag(1)
             
                OverviewScreen(selectedTabIndex: self.$selection, selectedDate: self.$selectedDate)
                    .tabItem {
                        TabItem(title: "Přehled", iconName: "house");
                    }
                    .tag(2)
             
                StudentScreen()
                    .tabItem {
                        TabItem(title: "Student", iconName: "graduationcap");
                    }
                    .tag(3)
                
                MoreScreen()
                    .tabItem {
                        TabItem(title: "Další", iconName: "line.3.horizontal");
                    }
                    .tag(4)
            }
            .accentColor(Color.customBlue)
        }
        else {
            LoginScreen()
        }
    }
}

struct TabItem: View {
    
    public let title: String
    public let iconName: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 30, weight: .bold, design: .rounded))
        Image(systemName: iconName)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


// MARK: For TabView top shaddow

extension UIImage {
    static func gradientImageWithBounds(bounds: CGRect, colors: [CGColor]) -> UIImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
    
        return image!
    }
}

fileprivate let image = UIImage.gradientImageWithBounds(
    bounds: CGRect( x: 0, y: 0, width: UIScreen.main.scale, height: 10),
    colors: [
        UIColor.clear.cgColor,
        UIColor.black.withAlphaComponent(0.05).cgColor
    ]
)

fileprivate var uiTabBarAppearance: UITabBarAppearance {
    let appearance = UITabBarAppearance()
    appearance.configureWithTransparentBackground()
    appearance.backgroundColor = UIColor.systemGray6
            
    appearance.backgroundImage = UIImage()
    appearance.shadowImage = image
    
    return appearance
}
