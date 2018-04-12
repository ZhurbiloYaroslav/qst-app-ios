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
import FBSDKCoreKit
import OneSignal

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var interstitial: GADInterstitial!
    var currentVcWithInterstitial: UIViewController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        loadDataFromServer()
        chooseViewControllerToPresent()
        
        initializeAndConfigureFirebase()
        initializeGoogleMobileAds()
        
        setupPushNotificationsWith(launchOptions)
        authForNotifications()
        checkForAllowedNotifications()
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        return handled
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
        
        FBSDKAppEvents.activateApp()
        UIApplication.shared.applicationIconBadgeNumber = 0
        scheduleNotification()

    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }
    
}

// MARK: Other
extension AppDelegate {
    
    
    func loadDataFromServer() {
        EventsData.shared.getEventsFromServer {}
    }
    
    func initializeGoogleMobileAds() {
        let googleAdMobAppID = AdMobManager.AppID.ThisAppID.rawValue
        GADMobileAds.configure(withApplicationID: googleAdMobAppID)
    }
    
    func initializeAndConfigureFirebase() {
        FirebaseApp.configure()
    }
    
    func chooseViewControllerToPresent() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        chooseScreenToLoad()
    }
    
    func chooseScreenToLoad() {
        loadLoginOrOverviewViewController()
    }
    
    func loadLoginOrOverviewViewController() {
        if CurrentUser.isLoggedIn {
            let overviewVC = UIStoryboard(name: "TabBar", bundle: nil).instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
            self.window?.rootViewController = overviewVC
        } else {
            if let messageVC = AdviceVC.getInstance() {
                messageVC.messagesManager = MessagesManager(messageType: .greeting)
                self.window?.rootViewController = messageVC
            }
        }
        self.window?.makeKeyAndVisible()
    }
}

// MARK: Methods related with Notifications
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
        let interstitialID = AdMobManager.BannerID.Test_InterstitialID.rawValue
        self.interstitial = GADInterstitial(adUnitID: interstitialID)
        
        interstitial.delegate = self
        let request  = GADRequest()
        request.testDevices = [kGADSimulatorID] // , "e9ebcd52a35476ac486fdfb4a9c6567a57c1b88c"
        interstitial.load(request)
    }
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        guard let currentVcWithInterstitial = currentVcWithInterstitial else {
            return
        }
        ad.present(fromRootViewController: currentVcWithInterstitial)
    }
}

// Notifications Push Remote
extension AppDelegate {
    
    func setupPushNotificationsWith(_ launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        
        let notificationOpenedBlock: OSHandleNotificationActionBlock = { result in
            /*
            guard let payload: OSNotificationPayload = result!.notification.payload
                else { return }
            guard let additionalData = payload.additionalData as? [String: Any]
                else { return }
            let articleData = DataFromPushNotification(withResult: additionalData)
            
            let revealVC = UIStoryboard(name: "Menu", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
            self.window?.rootViewController = revealVC
            
            if articleData.postType == "news" {
                let eventsNavController = UIStoryboard(name: "News", bundle: nil).instantiateViewController(withIdentifier: "NewsNavBar") as! UINavigationController
                let eventsListVC = UIStoryboard(name: "News", bundle: nil).instantiateViewController(withIdentifier: "NewsListVC") as! NewsListVC
                eventsListVC.dataFromNotification = articleData
                eventsNavController.viewControllers = [eventsListVC]
                revealVC.setFront(eventsNavController, animated: true)
            } else {
                let eventsNavController = UIStoryboard(name: "Events", bundle: nil).instantiateViewController(withIdentifier: "EventsNavBar") as! UINavigationController
                let eventsListVC = UIStoryboard(name: "Events", bundle: nil).instantiateViewController(withIdentifier: "EventsListVC") as! EventsListVC
                eventsListVC.dataFromNotification = articleData
                eventsNavController.viewControllers = [eventsListVC]
                revealVC.setFront(eventsNavController, animated: true)
            }
            
            self.window?.makeKeyAndVisible()
            */
            
        }
        
        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false, kOSSettingsKeyInAppLaunchURL: false]
        OneSignal.initWithLaunchOptions(launchOptions,
                                        appId: "fed69789-8f68-40d0-b5fc-18facebb54d8",
                                        handleNotificationAction: notificationOpenedBlock,
                                        settings: onesignalInitSettings)
        
        OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification
        
        OneSignal.sendTag("first_name", value: CurrentUser.firstName)
        OneSignal.sendTag("last_name", value: CurrentUser.lastName)
        OneSignal.sendTag("email", value: CurrentUser.email)
        OneSignal.sendTag("phone", value: CurrentUser.phone)
        
        // Recommend moving the below line to prompt for push after informing the user about
        //   how your app will use them.
        OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
        })
    }
    
}
