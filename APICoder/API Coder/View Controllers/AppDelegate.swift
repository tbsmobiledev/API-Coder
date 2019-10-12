//
//  AppDelegate.swift
//  Registration_demo
//
//  Created by TBS17 on 16/09/19.
//  Copyright © 2019 Sazzadhusen Iproliya. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var HUD: MBProgressHUD!
    var SVHUD: SVProgressHUD!
    var reachability:Reachability!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        return true
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
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    //MARK:- MBProgressHUD Toast Message
    func showToastMessage(_ message:String) -> Void {
        HUD = MBProgressHUD.showAdded(to: self.window, animated: true)
        HUD?.mode = MBProgressHUDModeText
        HUD?.detailsLabelText = message
        HUD?.detailsLabelColor = UIColor.white
        HUD?.yOffset = Float(50.0 * DeviceScale.SCALE_Y)
        HUD?.detailsLabelFont = UIFont.systemFont(ofSize: (17 * DeviceScale.SCALE_X))
        HUD?.dimBackground = false
        HUD?.sizeToFit()
        HUD?.color = ThemeYellow
        HUD?.margin = 10.0
        HUD?.removeFromSuperViewOnHide = true
        HUD?.hide(true, afterDelay: 2.0)
    }
    
    //MARK:- SVProgressHUD Hudder Method
    func showHudder(){ 
        SVProgressHUD.setDefaultAnimationType(.flat)
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setBackgroundColor(ThemeYellow)
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setContainerView(appDelegateShared.window!)
        SVProgressHUD.show()
    }
    
    func hideHudder() {
        SVProgressHUD.dismiss()
    }
    
    //MARK:- Reachability Network Connection
    func isNetworkAvailable() -> Bool {
        reachability = Reachability.forInternetConnection()
        reachability?.startNotifier()
        
        var status: NetworkStatus?
        status = reachability?.currentReachabilityStatus()
        
        if status == NotReachable {
            return false
        }else if (status == ReachableViaWiFi){
            return true
        }else if (status == ReachableViaWWAN){
            return true
        }else{
            return false
        }
    }
}

