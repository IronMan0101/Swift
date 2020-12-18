//
//  AppDelegate.swift
//  IMYSwift
//
//  Created by suzhiqiu on 2019/6/2.
//  Copyright © 2019 suzhiqiu. All rights reserved.
//


//https://www.jianshu.com/p/6004b9b2c7e7

import UIKit

/*
  分类
 */
 extension UIView {
     public var x: CGFloat {
         get {
            return self.frame.origin.x;
         }
         set {
            var rect = self.frame
            rect.origin.x = newValue
            self.frame = rect
         }
     }
 }
/*
 协议
 */
protocol UIViewProtocol : class {
    func read() -> String
}

class MyClass: UIViewProtocol {
    func read() -> String {
        return "read"
    }
}

/*
block
*/
typealias ClickBlock = (Int)->Void

class YouVC : UIViewController {
    /*
       声明代理
       */
     // weak var delegate: UIViewProtocol?
    weak var delegate: UIViewProtocol?
    
    var clickBlock:ClickBlock?
    
    func read() {
        if let txt = self.delegate?.read() { //必须得解码出来
            var ss:String = txt
            print(ss)
        } else  {
            print("为空了")
        }
        
        if let clickIndexBock = clickBlock {
            clickIndexBock(5)
        }
        /*
         Swift 通知
        */
        NotificationCenter.default.post(name: NSNotification.Name("Notify"), object: nil, userInfo: nil)
    }
    
}
/*
kvo
*/

/*下标*/
class DayWeaks {
    private  var days = ["OneDay","TwoDay","ThreeDay"]
    
    subscript(index:Int) -> String {
        get {
            return days[index]
        }
        set (newValue) {
            self.days[index] = newValue
        }
    }
    
}







@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate ,UIViewProtocol{

    var window: UIWindow?

    func read() -> String {
        return "继承协议";
    }
    
//    func testFunc(param1:String,param2:Int) -> Bool {
//    func testFunc(lablel param1:String,param2:Int) -> Bool {
    func testFunc(_ param1:String,param2:Int) -> Bool {
        
        print("param1:\(param1),param2:\(param2)")
         return true
    }
    
    func backward(_ s1: String, _ s2: String) -> Bool {
        return s1 > s2
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //1.集合声明与遍历
        var array:[Int] = [1,2,3,4]
        
        for (index,value) in array.enumerated() {
            print(index,value);
            print("");
        }
        let someDic:[Int:String] = [1:"s",2:"p"]
        for (key,value) in someDic {
            print("key:\(key) value:\(value) ")
            print("")
        }
        print("input param value is : \(someDic[1])")
        
        //2.字符串的操作
        var test:String  = "123456";
        test.insert("7", at: test.endIndex);
        test.append("100")
        test.insert("9", at: test.index(test.startIndex, offsetBy: 5));
        print(test);
        
        //3.条件语句 guard else
        guard array[0]==1 else {
            print("条件必须为真")
            return false;
        }
        //4.switch与枚举
        
        
        //5.函数
//        self.testFunc(param1: "woailuo", param2: 123)
//        self.testFunc(lablel: "woailuo", param2: 123)
        self.testFunc("woailuo", param2: 123)
        
        //6.闭包
        let names = ["bb","ss"]
        //(String, String) -> Bool
        let reversed0 = names.sorted(by: backward)
        
        let reversed1  = names.sorted(by:{ (s1:String, s2:String) -> Bool in
                        print(s1)
                        print(s2)
                            return s1 > s2
                          })
        let reversed2  = names.sorted(by:{ $0>$1 })
  
        
        print("reversed0:\(reversed0)")
        print("reversed1:\(reversed1)")
        print("reversed2:\(reversed2)")
  
        
        let sumFunc = { (a :Int ,b :Int) -> Int  in
                         return  a+b
                      }
        
        print("value is \(sumFunc(4,5)) ")
        
        //6.1尾随闭包
        /*
         将一个很长的闭包表达式作为最后一个参数传递给函数
         函数和闭包都是引用类型
         **/
        let reversed3  = names.sorted(){ $0>$1 }
        let reversed4  = names.sorted{ $0>$1 }
        print("reversed3:\(reversed3)")
        print("reversed4:\(reversed4)")
        //6.2自动闭包
        /*
         自动闭包是一种自动创建的闭包，用于包装传递给函数作为参数的表达式
         */
        var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        print("customersInLine1:\(customersInLine.count)")
        let autoClose = { customersInLine.remove(at: 0) };
        print("customersInLine2:\(customersInLine.count)")
        let ss:String  = autoClose();
        print("customersInLine3:\(customersInLine.count) ,ss:\(ss)")
        
        //6.3逃逸闭包
        /*
         当一个闭包作为参数传到一个函数中，在函数返回之后才被执行。参数名之前标注 @escaping
         **/
        // customersInLine i= ["Barry", "Daniella"]
        var customerProviders: [() -> String] = []
        func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
            customerProviders.append(customerProvider)
        }
        collectCustomerProviders(customersInLine.remove(at: 0))
        collectCustomerProviders(customersInLine.remove(at: 0))

        print("Collected \(customerProviders.count) closures.")
        // 打印“Collected 2 closures.”
        for customerProvider in customerProviders {
            print("Now serving \(customerProvider())!")
        }
        //7.枚举
        enum Rank: Int {
             case ace = 1
             case two, three, four, five, six, seven, eight, nine, ten
             case jack, queen, king

             func simpleDescription() -> String {
                 switch self {
                 case .ace:
                     return "ace_desc"
                 case .jack:
                     return "jack_desc"
                 case .queen:
                     return "queen_desc"
                 case .three:
                     return "three_desc"
                 default:
                     return String(self.rawValue)
                 }
             }
         }
        
        print(Rank.ace.simpleDescription())
        let emuRand = Rank.ace
        switch emuRand {
        case .ace:
            print(".ace_switch")
        default:
            print("nothing")
        }
        //关联值 7.1
        enum Barcode {
            case upc(Int, Int, Int, Int)
            case qrCode(String)
        }
        
        var productBarcode = Barcode.upc(8, 85909, 51226, 3)
        productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
        //提取每个关联值作为一个常量（用 let 前缀）或者作为一个变量（用 var 前缀）
        switch productBarcode {
        case .upc(let numberSystem, let manufacturer, let product, let check):
            print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
        case .qrCode(let productCode):
            print("QR code: \(productCode).")
        }
        // 打印“QR code: ABCDEFGHIJKLMNOP.”
        
        //8.类以及结构体
        /*
         “相同”（用三个等号表示，===）与“等于”（用两个等号表示，==）的不同。“相同”表示两个类类型（class type）的常量或者变量引用同一个类实例。“等于”表示两个实例的值“相等”或“等价”
         类是引用类型
         **/
        class SomeClass {
            // 在这里定义类
            var width:Int = 3
            var height:Int = 2
            
            //只有 getter 没有 setter 的计算属性叫只读计算属性
            var content:Int {
                return  width*height
            }
            
            var content2:Int {
                get {
                    return width*2
                }
                set {
                    width = newValue*100
                }
                
            }
            
        }
        
        var cls1: SomeClass = SomeClass()
        var cls2: SomeClass = SomeClass()
        var cls3 = cls1
        
        if (cls1 === cls3) {
            print("相同")
        }
        print("content:\(cls1.content)")
        print("content:\(cls1.content2),width:\(cls1.width)")
        cls1.content2 = 100
        print("content:\(cls1.content2),width:\(cls1.width)")
      
        //9.属性
        //延时加载存储属性  包装器
        
        //10.方法
        /*
         结构体和枚举是值类型。默认情况下，值类型的属性不能在它的实例方法中被修改。
         常量不能调用可变方法
         */
        struct Point {
            var x = 0.0, y = 0.0
            mutating func moveBy(x deltaX: Double, y deltaY: Double) {
                x += deltaX
                y += deltaY
            }
        }
        var somePoint = Point(x: 1.0, y: 1.0)
        somePoint.moveBy(x: 2.0, y: 3.0)
        print("The point is now at (\(somePoint.x), \(somePoint.y))")
        // 打印“The point is now at (3.0, 4.0)”
        
//        let fixedPoint = Point(x: 3.0, y: 3.0)
//        fixedPoint.moveBy(x: 2.0, y: 3.0)
        
        
        class SomeClass1 {
            class func someTypeMethod() {
                // 在这里实现类型方法
                print("+号方法")
            }
        }
        SomeClass1.someTypeMethod()
        
        //11.继承
        class Vehicle  {
            var gear = 1
            func read() {
                print("Vehicle..read")
            }
            init() {
                print("Vehicle...init")
            }
            deinit {
                print("Vehicle...dealloc")
            }
        }
        class Car: Vehicle {
            override func read() {
                print("Car..read")
            }
        }
        
        var car:Car = Car()
        print(car.read())
        //12.构造过程
        /*
         指定构造器必须总是向上代理。便利构造器必须总是横向代理 。便利构造器最后必须调用指定构造器。
         失败构造器?
         */
        class Food {
            var name: String
            init(name: String) {
                self.name = name
            }

            convenience init() {
                self.init(name: "[Unnamed]")
            }
        }
        //13.可选链
        /*
         通过在想调用的属性、方法，或下标的可选值后面放一个问号（?），可以定义一个可选链。
         这一点很像在可选值后面放一个叹号（!）来强制解包它的值。它们的主要区别在于当可选值为空时可选链式调用只会调用失败，
         然而强制解包将会触发运行时错误
         */
        class Person {
            var residence: Residence?
        }

        class Residence {
            var numberOfRooms = 1
        }
        let john = Person()
//        john.residence = Residence()
//        let roomCount = john.residence!.numberOfRooms
//        print(roomCount)
        
        if let roomCount = john.residence?.numberOfRooms {
            print("roomCount:\(roomCount)")
            print("")
        } else {
            print("Unable to retrieve the number of rooms.")
        }
       //14.类型转化
        class MediaItem {
            var name: String
            init(name: String) {
                self.name = name
            }
        }
        class Movie: MediaItem {
            var director: String
            init(name: String, director: String) {
                self.director = director
                super.init(name: name)
            }
        }

        class Song: MediaItem {
            var artist: String
            init(name: String, artist: String) {
                self.artist = artist
                super.init(name: name)
            }
        }
        let library = [
            Movie(name: "Casablanca", director: "Michael Curtiz"),
            Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
            Movie(name: "Citizen Kane", director: "Orson Welles"),
            Song(name: "The One And Only", artist: "Chesney Hawkes"),
            Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
        ]
        var movieCount = 0
        var songCount = 0

        for item in library {
            if item is Song {
                movieCount += 1
            } else if item is Movie {
                songCount += 1
            }
        }

        print("Media library contains \(movieCount) movies and \(songCount) songs")
        // 打印“Media library contains 2 movies and 3 songs”
       // 向下转型 as? as!
        for item in library {
            if let movie = item as? Movie {
                print("Movie: \(movie.name), dir. \(movie.director)")
            } else if let song = item as? Song {
                print("Song: \(song.name), by \(song.artist)")
            }
        }
        //14.2 Any 和 AnyObject 的类型转换
        /*Any 可以表示任何类型，包括函数类型。
        AnyObject 可以表示任何类类型的实例。
        */
        var things = [Any] ()
        things.append("字符串")
        things.append(12)
        
        
        
        //7.通知
       NotificationCenter.default.addObserver(self, selector: #selector(notifyMethod), name: NSNotification.Name("Notify"), object: nil)

        
    //
        return true
    }
    

    


    func doWork(block:()->()) {
        print("header")
        block()
        print("footer")
    }
    func doWorkAsync(block: @escaping () -> ()) {
        DispatchQueue.main.async {
            block()
        }
    }

    
    
    
    @objc func notifyMethod() {
        print("notifyMethod")
    }
    
    /*
    GCD
    */
    func gcd() {
        DispatchQueue.main.async {
            print("main",Thread.current)
        }
        
        let queue = DispatchQueue(label: "queque", qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit)
        queue.async {
             print("queue" , Thread.current)
        }
    }
    
    /*
     声明数组
     */
    var exampleany = [Any]()
    
    /*
     声明代理
     */
    weak var delegate: UIViewProtocol?
  
    
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

