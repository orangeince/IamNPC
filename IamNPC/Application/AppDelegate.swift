//
//  AppDelegate.swift
//  IamNPC
//
//  Created by 赵少龙 on 16/7/19.
//  Copyright © 2016年 orangeince. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let config = Realm.Configuration(
            schemaVersion: 4,
            migrationBlock: {
                migration, oldSchemaVersion in
            }
        )
        Realm.Configuration.defaultConfiguration = config
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.makeKeyAndVisible()
        
        setRoot()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func setRoot() {
        let tabBC = UITabBarController()
        UITabBar.appearance().tintColor = lightBlueColor
        
        //let attributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        //UINavigationBar.appearance().titleTextAttributes =  attributes
        
        
        /*
        let todoVC = npcViewController(.ToDo, identifier: "ToDoListViewController") as! ToDoListViewController
        //let todoNav = ImNNavigationController(rootViewController: todoVC)
        let todoNav = npcViewController(.Main, identifier: "ImNNavigationController") as! ImNNavigationController
        todoNav.setViewControllers([todoVC], animated: false)
        todoNav.title = "Todo"
        todoNav.tabBarItem.image = UIImage(named: "tabbar_todo")
        todoNav.tabBarItem.selectedImage = UIImage(named: "tabbar_todo_filled")
         */
        
        let npcVC = npcViewController(.NPC, identifier: "NoviceVillageViewController") as! NoviceVillageViewController
        //let taskPoolNav = ImNNavigationController(rootViewController: taskPoolVC)
        let npcNav = npcViewController(.Main, identifier: "ImNNavigationController") as! ImNNavigationController
        npcNav.setViewControllers([npcVC], animated: false)
        npcNav.title = "新手村"
        npcNav.tabBarItem.image = UIImage(named: "tabbar_todo")
        npcNav.tabBarItem.selectedImage = UIImage(named: "tabbar_todo_filled")
        
        let taskPoolNav = npcViewController(.TaskPool, identifier: "TaskPoolNav") as! UINavigationController
        taskPoolNav.title = "任务池"
        taskPoolNav.tabBarItem.image = UIImage(named: "tabbar_taskpool")
        taskPoolNav.tabBarItem.selectedImage = UIImage(named: "tabbar_taskpll_filled")
        
        let walletVC = npcViewController(.Wallet, identifier: "WalletViewController") as! WalletViewController
        //let walletNav = ImNNavigationController(rootViewController: walletVC)
        let walletNav = npcViewController(.Main, identifier: "ImNNavigationController") as! ImNNavigationController
        walletNav.setViewControllers([walletVC], animated: false)
        walletNav.title = "钱包"
        walletNav.tabBarItem.image = UIImage(named: "tabbar_wallet")
        walletNav.tabBarItem.selectedImage = UIImage(named: "tabbar_wallet_filled")
        
        tabBC.setViewControllers([npcNav, taskPoolNav, walletNav], animated: false)
        //tabBC.setViewControllers([todoNav, walletNav], animated: false)
        window?.rootViewController = tabBC
        
    }


}

