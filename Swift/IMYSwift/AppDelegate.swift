//
//  AppDelegate.swift
//  IMYSwift
//
//  Created by suzhiqiu on 2019/6/2.
//  Copyright © 2019 suzhiqiu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        var str = self.doLog(str:"124");
        print(str);
        
        return true
    }
    
    /*
     1.语法过渡
      Swift                                           OC
     let:常量
     var:变量 不会覆给初始值
     String:字符串  String(i)类型转换                    是NSString
     数组声明 ["数组变量1","数组变量2"]                    @[@"",@""]
     字典声明 ["key1":"value1","key2":"value2"]         @{@"key1":@"value1","key2":"value2"]}
     打印 print  \(插入变量)                             NSlog
     ?和！
     
     
     */
    
    func doLog(str:String) -> String {
        
        let numInstance=5;
        let strInstance="cde";
        var str1="abc";
        str1=str1+strInstance+String(numInstance);
        
        var array = ["数组变量1","数组变量2"];
        var dic=["key1":"value1","key2":"value2"];
        print("array:\(array[1]),dic:\(dic["key1"]) ");
        return str1;
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

