//
//  Leitura_de_presencaApp.swift
//  Leitura_de_presenca
//
//  Created by Mohamad Lobo on 19/07/24.
//

import SwiftUI
import IQKeyboardManagerSwift
import Firebase
import FirebaseCore
import FirebaseMessaging
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        
        //------------------------- Firebase ----------------------------
        
        FirebaseApp.configure()
        
        //------------------------ Notificações --------------------------
        
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) {
                granted, error in
                print("Permission granted: \(granted)")
        }
        
        application.registerForRemoteNotifications()
        
        UNUserNotificationCenter.current().delegate = self
        
        //------------------ Subscribe Topic Firebase ----------------------
        
        Messaging.messaging().subscribe(toTopic: "all")
        
        if Messaging.messaging().fcmToken != nil {
        
            print("Firebase registration token: \(String(describing: Messaging.messaging().fcmToken))")
            
        }
        
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        Messaging.messaging().apnsToken = deviceToken
        
        Messaging.messaging().token { token, error in
            
            print("AQUIIIII")
            print(token)
            print(error)
            
        }
        
    }
    
}

@main
struct Leitura_de_presencaApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
