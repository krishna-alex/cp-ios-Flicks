//
//  AppDelegate.swift
//  Flicks
//
//  Created by Krishna Alex on 3/30/17.
//  Copyright © 2017 Krishna Alex. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
 //       self.window = UIWindow(frame: UIScreen.main.bounds)
//        self.window?.rootViewController = navigationController
      /*  self.window = UIWindow(frame: UIScreen.main.bounds)
        let nav1 = UINavigationController()
        let mainView = MovieListViewController(nibName: nil, bundle: nil) //ViewController = Name of your controller
        nav1.viewControllers = [mainView]
        self.window!.rootViewController = nav1
        self.window?.makeKeyAndVisible()*/

        
        let tabBarController = UITabBarController()
        //let nav1 = UINavigationController()
        let tabViewController1 = NowPlayingViewController()
        
        let tabViewController2 = TopRatedViewController()
      //  let movieDetailController = MovieDetailsViewController()
        
//        let tabViewController1 = NowPlayingViewController(nibName: "MovieListViewController", bundle: nil)
//        
//        let tabViewController2 = TopRatedViewController(nibName:"MovieListViewController", bundle: nil)
        
        let controllers = [tabViewController1,tabViewController2]
        //tabBarController.viewControllers = [tabViewController1,tabViewController2]
        tabBarController.viewControllers = controllers
        //nav1.viewControllers = controllers
        
        let navigationController = UINavigationController(rootViewController: tabBarController)
        
     /*   self.window = UIWindow(frame: UIScreen.main.bounds)
        let nav1 = UINavigationController()
        let mainView = MovieListViewController(nibName: nil, bundle: nil) //ViewController = Name of your controller
        nav1.viewControllers = [mainView]
        self.window!.rootViewController = navigationController
        self.window?.makeKeyAndVisible()*/
        
        tabViewController1.tabBarItem = UITabBarItem(
            title: "NowPlaying",
            image: UIImage(named: "Rating"),
            tag: 1)
        tabViewController2.tabBarItem = UITabBarItem(
            title: "TopRated",
            image:UIImage(named: "Rating") ,
            tag:2)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
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


}

