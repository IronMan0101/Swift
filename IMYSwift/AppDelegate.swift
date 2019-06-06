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
     ?和！
     
     float Double                                     CGFloat
     String:字符串  String(i)类型转换                    是NSString
     数组声明 ["数组变量1","数组变量2"]                   @[@"",@""]
     字典声明 ["key1":"value1","key2":"value2"]        @{@"key1":@"value1","key2":"value2"]}
     打印 print  \(插入变量)                            NSlog
     */

    
    func func2(str:String) -> String {
        return  "fun2->"+str
    }
    
    func func1(funx:(String)->String) -> String {//函数作为参数
        return "fun1调用:"+funx("value");//函数内部传参
    }
    func doLog(str:String) -> String {
        
        let numInstance:Double=5;
        let strInstance="cde";
        var str1="abc";
        str1=str1+strInstance+String(numInstance);
        
        var array = ["数组变量1","数组变量2"];
        var dic=["key1":"value1","key2":"value2"];
        print("instance:\(numInstance) array:\(array[1]),dic:\(dic["key1"]) ");
        
        
        //?和!
        var str:String? = "12"//可能为nil
        //str = nil;
        if (str != nil){
            str! = "123";  //赋值时候类型是确定的  同时str不为nil
        }
        //any 和 anyObject
        var objects = [Any]()
        
        objects.append(3)
        objects.append(3.141592653)
        objects.append("圆周率")
        
        for item in objects {
            switch item {
            case let someInt as Int:
                print("This is Int class \(someInt)")
            case let someDouble as Double:
                print("This is Double class \(someDouble)")
            default:
                print("This is String class \(item)")
            }
        }
        
        let swiftArr1 = ["a", "b", "c"]
        let swiftStr1 = "hello world"
        
        var array1 = [Any]()
        array1.append(swiftArr1)
        array1.append(swiftStr1)
        
        let swiftArr2 = ["a", "b", "c"]
        let swiftStr2 = "hello world"
        
        var array2 = [AnyObject]()
        array2.append(swiftArr2 as AnyObject)
        array2.append(swiftStr2 as AnyObject)
    
        // if let 对上面进行解包 并且得安全解包
        if  let name = str  as? String { //判断解包 后对象 是不是String 类型的
            print("解包 后对象 是String 类型的")
        }else {
            print("解包 后对象 不是String 类型的")
        }
        
        //闭包 函数参数
        var funStr = self.func1(funx: func2);
        var funStr2 = self.func1(funx: {//匿名
            (str:String)->String  in  //  in  来分割
            return "我爱罗"+str;
        });
        print ("fun result:\(funStr)") ;
        print ("no name fun result:\(funStr2)") ;
        //变量名 get set
        print("time:\(self.time)");
        self.time=50;
        print("timeCount:\(String(describing: self.timeCount))");
        //枚举类型  是一种类
        let rank = Rank.one
        print("Desc:"+rank.Desc())
        
        let rankString = RankString.one
        switch rankString {
        case .one:
            print("is RankOne")
        case .two:
            print("is RankTwo")
        default:
            print("no Rank")
        }
        let rankValue = RankValue.one(buy1: "100万", sale1: 10000);//可以传值
        switch rankValue {
        case .one(let buy1,let sale1)://let?
            print("buy:\(buy1) sale :\(sale1)")
        default:
            print("no RankValue")
        }
        //泛型
        print( "RankT:"+String( RankT<Int>.One(100).Desc() ))
   
        
    
        
        return str1;
    }
    
    //成员变量
    var timeCount : Double?
    var time: Double{
        set{
            timeCount = newValue/20
        }
        get{
            return 500
        }
    }
    //枚举类型
    enum Rank{
        case one
        case two
        func Desc() -> String {
            switch self {
            case .one:
                return "oneString"
            default:
                return "two"
            }
        }
        var  value:Int{
            switch self {
            case .one:
                return 100;
            default:
                return 200;
            }
        }
    }
    enum RankString :String {//其他类型
        case one="one"
        case two="two"
    }
    enum RankValue {
        case one(buy1:String,sale1:Int)
        case two(buy2:String,sale2:Int)
    }
    enum RankT<T> {
        case One(T)
        case Two(T)
        func Desc() -> T {
            switch self {
            case .One(let value):
                return value
            case .Two(let value):
                return value
            }
        }
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

