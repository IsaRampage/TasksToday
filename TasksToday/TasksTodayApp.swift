//
//  TasksTodayApp.swift
//  TasksToday
//
//  Created by Isa Rampage on 02.05.23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
 func application(_ application: UIApplication,
          didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
  FirebaseApp.configure()
  return true
 }
}

@main
struct TasksTodayApp: App {
    @StateObject var fireBaseVM = FireBaseViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(fireBaseVM)
        }
    }
}
