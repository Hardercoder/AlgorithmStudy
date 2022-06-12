//
//  Cyc2018_leetcode+x.swift
//  CommandLine
//
//  Created by unravel on 2022/4/14.
//

import Foundation
extension Cyc2018_leetcode {
    class DataStructure_StackAndQueue {
        // MARK:  用栈实现队列
        // https://leetcode-cn.com/problems/implement-queue-using-stacks/description/
        class MyQueue {
            var inStack = Stack<Int>(), outStack = Stack<Int>()
            init() {
                
            }
            
            func in2out() {
                if outStack.isEmpty {
                    while !inStack.isEmpty {
                        outStack.push(inStack.pop()!)
                    }
                }
            }
            
            func push(_ x: Int) {
                inStack.push(x)
            }
            
            func pop() -> Int? {
                in2out()
                return outStack.pop()
            }
            
            func peek() -> Int? {
                in2out()
                return outStack.top
            }
            
            func empty() -> Bool {
                return inStack.isEmpty && outStack.isEmpty
            }
        }
        
        // MARK: 用队列实现栈
        // https://leetcode-cn.com/problems/implement-stack-using-queues/description/
        class MyStack {
            var queue = Queue<Int>()
            init() {}
            
            func push(_ x: Int) {
                queue.enqueue(x)
                var cnt = queue.count
                // 将最后一个保留，其余的出队，再入队，保证插入到最后
                while cnt > 1 {
                    cnt -= 1
                    queue.enqueue(queue.dequeue()!)
                }
            }
            
            func pop() -> Int? {
                queue.dequeue()
            }
            
            func top() -> Int? {
                return queue.front!
            }
            
            func empty() -> Bool {
                return queue.isEmpty
            }
        }
        
        // MARK: 最小值栈
        // https://leetcode-cn.com/problems/min-stack/description/
        class MinStack {
            private var dataStack = Stack<Int>()
            private var minStack = Stack<Int>()
            private var minValue = Int.max
            init() {
                
            }
            
            func push(_ val: Int) {
                dataStack.push(val)
                minValue = min(minValue, val)
                minStack.push(minValue)
            }
            
            func pop() {
                _ = dataStack.pop()
                _ = minStack.pop()
                minValue = minStack.isEmpty ? Int.max : minStack.top!
            }
            
            func top() -> Int {
                return dataStack.top!
            }
            
            func getMin() -> Int {
                return minStack.top!
            }
        }
    }
    
    class MinStackArray {
        private var dataStack = Array<Int>()
        private var minStack = Array<Int>()
        private var minValue = Int.max
        init() {
            
        }
        
        func push(_ val: Int) {
            dataStack.append(val)
            minValue = min(minValue, val)
            minStack.append(minValue)
        }
        
        func pop() {
            _ = dataStack.popLast()
            _ = minStack.popLast()
            minValue = minStack.isEmpty ? Int.max : minStack.last!
        }
        
        func top() -> Int {
            return dataStack.last!
        }
        
        func getMin() -> Int {
            return minStack.last!
        }
    }
    
    // MARK: 用栈实现括号匹配
    // https://leetcode-cn.com/problems/valid-parentheses/description/
    func isValid(_ s: String) -> Bool {
        var stack = Stack<Character>()
        for c in s {
            if c == "(" ||
                c == "{" ||
                c == "[" {
                stack.push(c)
            }
            else {
                if stack.isEmpty {
                    return false
                }
                let cStack = stack.pop()!
                let b1 = c == ")" && cStack != "("
                let b2 = c == "}" && cStack != "{"
                let b3 = c == "]" && cStack != "["
                if b1 || b2 || b3 {
                    return false
                }
            }
        }
        return stack.isEmpty
    }
    
    // MARK: 数组中元素与下一个比它大的元素之间的距离
    // https://leetcode-cn.com/problems/daily-temperatures/description/
    func dailyTemperatures(_ temperatures: [Int]) -> [Int] {
        // 默认每个元素是0的一个数组
        var dist = [Int](repeating: 0,
                         count: temperatures.count)
        // indexs 是一个递减栈
        var indexs = Array<Int>()
        for (tIndex, tValue) in temperatures.enumerated() {
            // 一直出栈，直到堆栈 top值大于等于value
            while !indexs.isEmpty && tValue > temperatures[indexs.last!] {
                let preIndex = indexs.removeLast()
                // 给数组中对应位置的元素赋值，按位置赋值哦
                dist[preIndex] = tIndex - preIndex
            }
            indexs.append(tIndex)
        }
        return dist
    }
    
    // MARK: 循环数组中比当前元素大的下一个元素
    // https://leetcode-cn.com/problems/next-greater-element-ii/description/
    func nextGreaterElements(_ nums: [Int]) -> [Int] {
        // [1,2,3,4,3]
        // [2,3,4,-1,4]
        
        let numsCount = nums.count
        // 默认每个元素是-1的一个数组
        var next = [Int](repeating: -1, count: numsCount)
        var pre = Array<Int>()
        for i in 0..<(2 * numsCount) {
            // 循环取值
            let num = nums[i % numsCount]
            while !pre.isEmpty && nums[pre.last!] < num {
                // 设置对应位置里应该存的值
                let preIndex = pre.removeLast()
                next[preIndex] = num
            }
            // 入栈一个循环里的下标
            if i < numsCount {
                pre.append(i)
            }
        }
        return next
    }
}
