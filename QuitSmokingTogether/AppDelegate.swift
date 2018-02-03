//
//  AppDelegate.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 30.09.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import CoreData
import FolioReaderKit
import Firebase
import GoogleMobileAds
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var interstitial: GADInterstitial!
    var currentVcWithInterstitial: UIViewController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        test()
        chooseViewControllerToPresent()
        
        initializeAndConfigureFirebase()
        initializeGoogleMobileAds()
        
        authForNotifications()
        checkForAllowedNotifications()
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        return true
    }
    
    func test() {
        EventsManager().retrieveInfoForPath(.events_all) { (arrayWithErrors) in
            print(arrayWithErrors)
        }
    }
    
    func initializeGoogleMobileAds() {
        let googleAdMobAppID = AdMobManager.AppID.ThisAppID.rawValue
        GADMobileAds.configure(withApplicationID: googleAdMobAppID)
    }
    
    func chooseViewControllerToPresent() {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        if CurrentUser.isLoggedIn {
            let overviewVC = UIStoryboard(name: "TabBar", bundle: nil).instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
            self.window?.rootViewController = overviewVC
        } else {
            let loginVC = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.window?.rootViewController = loginVC
        }
        self.window?.makeKeyAndVisible()
        
    }
    
    func loadLoginOrOverviewViewController() {
        
    }
    func initializeAndConfigureFirebase() {
        FirebaseApp.configure()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        scheduleNotification()

    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "QuitSmokingTogether")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    /// Local and Push Notifications in IOS 9 and 10 using swift3
    /// https://stackoverflow.com/questions/42688760/local-and-push-notifications-in-ios-9-and-10-using-swift3
    
    func scheduleNotification() {
        // timeInterval is in seconds, so 60*60*12*3 = 3 days, set repeats to true if you want to repeat the trigger
        //let time = Constants.Time.didNotOpenApp
        let time = Constants.Time.didNotOpenApp
        let requestTrigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
        
        let requestContent = UNMutableNotificationContent()
        requestContent.title = "Continue quit smoking"
        requestContent.subtitle = "You haven't open the App within 2 days"
        requestContent.body = "Open the App and continue reading!"
        requestContent.badge = 1
        requestContent.sound = UNNotificationSound.default()
        
        let notifID = NotificationID.RemindUserOpenApp.rawValue
        let request = UNNotificationRequest(identifier: notifID, content: requestContent, trigger: requestTrigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                
            }
        }
    }
    
    enum NotificationID: String {
        case RemindUserOpenApp = "RemindUserAboutOpenApp"
    }
    
    func authForNotifications() {
        let notifCenter = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        notifCenter.requestAuthorization(options: options) { (boolValue, error) in
            if error == nil {

            } else {
                print(error?.localizedDescription ?? "")
            }
        }
//        /// In case you want to register for the remote notifications
//        let application = UIApplication.shared
//        application.registerForRemoteNotifications()
    }

    func checkForAllowedNotifications() {
        let notifCenter = UNUserNotificationCenter.current()
        notifCenter.getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized {
                // Notifications not allowed
            }
        }
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print(deviceTokenString)
        // Send to your server here...
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("i am not available in simulator \(error)")
    }
}

extension AppDelegate: GADInterstitialDelegate {
    func showAdmobInterstitial() {
        self.interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        
        interstitial.delegate = self
        let request  = GADRequest()
        request.testDevices = [kGADSimulatorID, "e9ebcd52a35476ac486fdfb4a9c6567a57c1b88c"]
        interstitial.load(request)
    }
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        guard let currentVcWithInterstitial = currentVcWithInterstitial else {
            return
        }
        ad.present(fromRootViewController: currentVcWithInterstitial)
    }
}

