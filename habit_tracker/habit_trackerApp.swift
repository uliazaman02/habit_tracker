//
//  habit_trackerApp.swift
//  habit_tracker
//
//  Created by Ulia on 2/21/24.
//

import SwiftUI

@main
struct habit_trackerApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                CalendarView()
                    .tabItem {
                        Label("Home", systemImage: "calendar")
                    }
            }
        }
    }
}
