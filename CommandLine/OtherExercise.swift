//
//  OtherExercise.swift
//  CommandLine
//
//  Created by unravel on 2021/5/12.
//

import Foundation
import Combine
// 步进
func practiceStride() {
    print(#function)
    print("stride(from: 1, to: 20, by: 2)")
    for v in stride(from: 1, to: 20, by: 2) {
        print(v, terminator: " ")
    }
    print("stride(from: 1, to: 20, by: 2)")
    
    print("stride(from: 0, through: 20, by: 2)")
    for v in stride(from: 0, through: 20, by: 2) {
        print(v, terminator: " ")
    }
    print("stride(from: 0, through: 20, by: 2)")
}

func practiceForIn() {
    print(#function)
    do {
        print("\n")
        defer {
            print("\n")
        }
        print("数组")
        print("for in")
        let nums = [1,3,5,15,51,25,2]
        for val in nums {
            print("\(val)")
        }
        print("\nfor in enumerated")
        for (index, value) in nums.enumerated() {
            print("\(index) => \(value)")
        }
    }
    
    do {
        print("\n")
        defer {
            print("\n")
        }
        print("字符串")
        print("for in ")
        let ss = "acdefgh"
        for c in ss {
            print("\(c)")
        }
        print("\nfor in enumerated ")
        for (ind, c) in ss.enumerated() {
            print("\(ind) => \(c)")
        }
    }
    
    do {
        print("\n")
        defer {
            print("\n")
        }
        print("字典")
        let dd = [1: "a", 2 : "b", 3: "c", 4: "d"]
        print("for in ")
        for tuple in dd {
            print("\(tuple)")
        }
        print("\nor in enumerated ")
        for (ind, tuple) in dd.enumerated() {
            print("\(ind) => \(tuple)")
        }
    }
}

func practiceFormat() {
    print(String(format: "%3d", 23))
    print(String(format: "%@", "bbbb"))
    print(String(format: "%-.36f", 23.22))
}

func practiceStrIndx() {
    let str = "1234556"
    //    let starInd = str.startIndex
    //    let i = str.index(starInd, offsetBy: 4, limitedBy: str.endIndex)
    let j = str.index(str.startIndex, offsetBy: 7, limitedBy: str.endIndex)
    //    print(i)
    //    print(j)
    if j != nil && j != str.endIndex {
        print("sadasf")
    }
}

func practiceFor() {
    let str = [1,2,3,5,6,7]
    for i in str {
        print("外层 =", i)
        // 每次都生成一个新的数组
        for j in str.dropFirst() {
            print("内层 ", j)
            if j == 5 {
                print("内层 5 break")
                break
            }
        }
        print("内层for循环结束")
    }
}

func practiceMultiParam() {
    func test(a: Int..., b: String, _ c: String...) {
        print(a,b)
    }
    
    test(a: 1,23,5, b: "str", "sds", "sdf", "sdf")
}

func practiceDifference() {
    let s1 = [1, 2, 3, 5, 6, 8]
    let s2 = [23, 2, 3, 5, 6, 8]
    let diff = s1.difference(from: s2)
    print(diff.insertions.count == diff.removals.count && diff.insertions.count == 1)
    if case .insert(let ioffset, _, _) = diff.insertions.first! ,
       case .remove(let roffset, _, _) = diff.removals.first!{
        print(ioffset == roffset)
    }
    
    print(diff)
}

func practiceTaskGroup() {
    Task(priority: .low) {
        print("有继承关系的异步任务")
        await withTaskGroup(of: Int.self) { group in
            // 添加子任务
            group.addTask {
                print("default priority task")
                return 1
            }
            
            group.addTask(priority: .low) {
                print("low priority task")
                return 2
            }
            
            //            group.addTaskUnlessCancelled {
            //                print("add task when not cancelled")
            //                return 3
            //            }
            //
            //            group.addTaskUnlessCancelled(priority: .high) {
            //                print("add task when not cancelled with high priority")
            //                return 4
            //            }
            //
            
            for await ret in group {
                print(ret)
            }
        }
    }
    
    
    Task.detached {
        print("无继承关系的任务")
    }
    
    // 在原来oc的基础上，添加async await的调用
//    URLSession(configuration: .default).dataTask(with: URL(string: "")!) { data, response, error in
//        withCheckedContinuation { continuation in
//            continuation.resume()
//        }
//    }
}

protocol UsernameWidget {
    func get() -> String
}

protocol AgeWidget {
    func get() -> String
}

struct Form {
    var username: String
    var age: Int
}

extension Form : UsernameWidget, AgeWidget {
    func get() -> String {
        return self.username
    }
    func get() -> Int {
        return self.age
    }
}

func practiveMulPro() {
    let form = Form(username: "name", age: 18)
    print((form as UsernameWidget).get())
    print((form as AgeWidget).get())
}

func practicePublished() {
    // https://mp.weixin.qq.com/s/USGJbLnR-l8Ajgcj8Vb7_A
//    class Weather {
//        @Published var temperature: Double
//        init(temperature: Double) {
//            self.temperature = temperature
//        }
//    }
//
//    let weather = Weather(temperature: 20)
//    let cancellable = weather.$temperature.sink {
//        print("Temperature now: \($0)")
//    }
//    weather.temperature = 25
    
//    class Weather: ObservableObject {
//        @Published var temperature: Double
//        init(temperature: Double) {
//            self.temperature = temperature
//        }
//    }
//
//    let weather = Weather(temperature: 20)
//    let cancellable = weather.objectWillChange.sink {
//        print("weather will change")
//    }
//    weather.temperature = 25
    
//    class Weather: ObservableObject {
//        var temperature: Double {
//            willSet {
//                self.objectWillChange.send()
//            }
//        }
//        init(temperature: Double) {
//            self.temperature = temperature
//        }
//    }
//
//    let weather = Weather(temperature: 20)
//    let cancellable = weather.objectWillChange.sink {
//        print("weather will change")
//    }
//    weather.temperature = 25
    
//    class TT: ObservableObject {
//        @MyPublished var name = "fat"
//        init() {}
//    }
//    let object = TT()
//    let c1 = object.objectWillChange.sink {
//        print("object will change")
//    }
//    let c2 = object.$name.sink {
//        print("name will get new value \($0)")
//    }
//    object.name = "bob"
    
    
}

@propertyWrapper
public struct MyPublished<Value> {
    public init(wrappedValue: Value) {
        // init里不会调用属性的willSet
        self.wrappedValue = wrappedValue
        publisher = Publisher(wrappedValue)
    }
    
    public var wrappedValue: Value {
        willSet {
            // 修改 wrappedValue 之前
            publisher.subject.send(newValue)
        }
    }

    public var projectedValue: Publisher {
        publisher
    }

    private var publisher: Publisher
    // @Published 的 projectedValue 的类型为 Published.Publisher<Value,Never>
    public struct Publisher: Combine.Publisher {
        public typealias Output = Value
        public typealias Failure = Never

        // 通过对 CurrentValueSubject 的包装，即可轻松地创建自定义 Publisher
        var subject: CurrentValueSubject<Value, Never>
        // PassthroughSubject 会缺少初始话赋值的调用

        public func receive<S>(subscriber: S) where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            subject.subscribe(subscriber)
        }

        init(_ output: Output) {
            subject = .init(output)
        }
    }

    public static subscript<OuterSelf: ObservableObject>(
        _enclosingInstance observed: OuterSelf,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<OuterSelf, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<OuterSelf, Self>
    ) -> Value {
        get {
            observed[keyPath: storageKeyPath].wrappedValue
        }
        set {
            if let subject = observed.objectWillChange as? ObservableObjectPublisher {
                // 调用包裹类实例的 objectWillChange 和给 projectedValue 的订阅者发送信息均应在更改 wrappedValue 之前
                subject.send()
                // 修改 wrappedValue 之前
                observed[keyPath: storageKeyPath].wrappedValue = newValue
            }
        }
    }
}


@propertyWrapper
public struct PublishedObject<Value: ObservableObject> {
    // wrappedValue 要求符合 ObservableObject
    public var wrappedValue: Value

    public init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }

    public static subscript<OuterSelf: ObservableObject>(
        _enclosingInstance observed: OuterSelf,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<OuterSelf, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<OuterSelf, Self>
    ) -> Value where OuterSelf.ObjectWillChangePublisher == ObservableObjectPublisher {
        get {
            if observed[keyPath: storageKeyPath].cancellable == nil {
                // 只会执行一次
                observed[keyPath: storageKeyPath].setup(observed)
            }
            return observed[keyPath: storageKeyPath].wrappedValue
        }
        set {
            observed.objectWillChange.send() // willSet
            observed[keyPath: storageKeyPath].wrappedValue = newValue
        }
    }

    private var cancellable: AnyCancellable?
    // 订阅 wrappedvalue 的 objectWillChange
    // 每当 wrappedValue 发送通知时，调用 _enclosingInstance 的 objectWillChange.send。
    // 使用闭包对 _enclosingInstance 进行弱引用
    private mutating func setup<OuterSelf: ObservableObject>(_ enclosingInstance: OuterSelf) where OuterSelf.ObjectWillChangePublisher == ObservableObjectPublisher {
        cancellable = wrappedValue.objectWillChange.sink(receiveValue: { [weak enclosingInstance] _ in
            (enclosingInstance?.objectWillChange)?.send()
        })
    }
}
