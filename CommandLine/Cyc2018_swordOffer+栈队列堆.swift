//
//  Cyc2018_swordOffer+StackQueueHeap.swift
//  CommandLine
//
//  Created by unravel on 2022/2/28.
//

import Foundation

/// 栈、队列、堆
extension Cyc2018_swordOffer {
    class Cyc2018_swordOffser_StackQueueHeap {
        // MARK: 用两个栈实现队列
        // https://leetcode.cn/problems/yong-liang-ge-zhan-shi-xian-dui-lie-lcof/
        // 思想:  一个用于进栈，进栈时被反转，出栈时进入另一个栈，这个栈再出栈。此时反转了两次之后实现了FIFO
        class CQueue {
            init() {}
            // 数组模拟栈，仅允许调用append和removeLast进行进栈和出栈
            // 进栈所使用的的栈结构，作为私有数据
            private var inStack = Array<Int>()
            // 出栈
            private var outStack = Array<Int>()
            
            func appendTail(_ value: Int) {
                inStack.append(value)
            }
            
            func deleteHead() -> Int {
                // 出栈为空时，将入栈的数据翻转放到出栈队列。
                if outStack.isEmpty {
                    while !inStack.isEmpty {
                        outStack.append(inStack.removeLast())
                    }
                }
                
                if outStack.isEmpty {
                    return -1
                }
                
                return outStack.removeLast()
            }
        }
        
        // MARK: 包含min函数的栈
        // https://leetcode.cn/problems/bao-han-minhan-shu-de-zhan-lcof/submissions/
        // 思想:  双栈，一个存正常数，一个存最小数
        class MinStack {
            // 数组模拟栈，仅允许调用append和removeLast进行进栈和出栈
            private var dataStack = Array<Int>()
            private var minStack = Array<Int>()
            
            init() {}
            
            // 存放数据时，同时也判断并存放到最小栈里
            func push(_ x: Int) {
                dataStack.append(x)
                
                if minStack.isEmpty {
                    minStack.append(x)
                }
                else {
                    let topValue: Int = minStack.last!
                    minStack.append(topValue <= x ? topValue : x)
                }
            }
            
            // 出栈时，同步出栈最小值的栈
            func pop() {
                if !dataStack.isEmpty {
                    dataStack.removeLast()
                }
                if !minStack.isEmpty {
                    minStack.removeLast()
                }
            }
            
            func top() -> Int {
                if !dataStack.isEmpty {
                    return dataStack.last!
                }
                else {
                    return -1
                }
            }
            
            func min() -> Int {
                if minStack.isEmpty {
                    return -1
                }
                else {
                    return minStack.last!
                }
            }
        }
        
        // MARK: 栈的压入、弹出序列
        // https://leetcode.cn/problems/zhan-de-ya-ru-dan-chu-xu-lie-lcof/
        // 思想:  使用pushSequence模拟入栈，出栈时进行匹配popSequence，若最后都弹出来了，说明是它的弹出序列
        func validateStackSequences(_ pushed: [Int],
                                    _ popped: [Int]) -> Bool {
            if pushed.count != popped.count {
                return false
            }
            // 数组模拟栈，仅允许调用append和removeLast进行进栈和出栈
            var stack = Array<Int>()
            
            var popIndex = 0
            for pushValue in pushed {
                // 入栈
                stack.append(pushValue)
                while !stack.isEmpty && stack.last! == popped[popIndex] {
                    _ = stack.removeLast()
                    popIndex += 1
                }
            }
            return stack.isEmpty
        }
        
        // MARK: 最小的 K 个数
        // https://leetcode.cn/problems/zui-xiao-de-kge-shu-lcof/submissions/
        // 思想:  快速选择
        func getLeastNumbers(_ arr: [Int], _ k: Int) -> [Int] {
            var ret = [Int]()
            if k > arr.count || k <= 0 {
                return ret
            }
            // 因为会进行排序，就用mNums接收
            var mNums = arr
            // 元素交换
            func swap(_ i: Int , _ j: Int) {
                (mNums[i], mNums[j]) = (mNums[j], mNums[i])
            }
            
            // 切分，使用双路快排
            func partition(_ l: Int , _ h: Int ) -> Int {
                // 切分标准
                let p = mNums[l]
                
                var i = l, j = h + 1
                while true {
                    while i != h {
                        i += 1
                        if mNums[i] >= p {
                            break
                        }
                    }
                    
                    while j != l {
                        j -= 1
                        if mNums[j] <= p {
                            break
                        }
                    }
                    if i >= j {
                        break
                    }
                    swap(i, j)
                }
                swap(l, j)
                return j
            }
            
            func findKthSmallest(_ k: Int) {
                var l = 0, h = mNums.count - 1
                while l < h {
                    let j = partition(l, h)
                    if j == k {
                        break
                    }
                    if j > k {
                        h = j - 1
                    }
                    else {
                        l = j + 1
                    }
                }
            }
            
            // 双路快排
            findKthSmallest(k - 1)
            /* findKthSmallest 会改变数组，使得前 k 个数都是最小的 k 个数 */
            for i in 0..<k {
                ret.append(mNums[i])
            }
            return ret
        }
        
        // MARK: 数据流中的中位数
        // https://leetcode.cn/problems/shu-ju-liu-zhong-de-zhong-wei-shu-lcof/
        // 思想:  采用堆排序
        // 答案不对，因为这里大顶堆和小顶堆未定义出来
        class MedianFinder {
            private var A = PriorityQueue()
            private var B = PriorityQueue()
            init() {
                
            }
            
            func addNum(_ num: Int) {
                if A.size != B.size {
                    A.enQueue(num)
                    B.enQueue(A.deQueue())
                }
                else {
                    B.enQueue(num)
                    A.enQueue(B.deQueue())
                }
            }
            
            func findMedian() -> Double {
                if A.size != B.size {
                    return Double(A.array.last!)
                }
                else {
                    return Double(A.array.last! + B.array.last!) / 2
                }
            }
        }
        
        // MARK: 字符流中第一个不重复的字符
        func firstUniqueCharIn(_ s: String) -> Character {
            // 使用统计数组来统计每个字符出现的次数
            var charCount = [Character:Int]()
            // 使用队列来存储到达的字符，并在每次有新的字符从字符流到达时移除队列头部那些出现次数不再是一次的元素
            var queue = Array<Character>()
            func insert(_ ch: Character) {
                charCount[ch, default: 0] += 1
                
                queue.append(ch)
                while !queue.isEmpty,
                      let count = charCount[queue.first!],
                      count > 1 {
                    _ = queue.removeLast()
                }
            }
            
            return queue.isEmpty ? "#" : queue.first!
        }
        
        // MARK: 滑动窗口的最大值
        // https://leetcode.cn/problems/hua-dong-chuang-kou-de-zui-da-zhi-lcof/
        func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
            if nums.count == 0 || k == 0 {
                return []
            }
            let n = nums.count
            var deque = [Int](), res = [Int](repeating: 0, count: n - k + 1)
            // 未形成窗口
            for i in 0..<k {
                let numValue = nums[i]
                // 保证是单调递减队列
                while !deque.isEmpty && deque.last! < numValue {
                    deque.removeLast()
                }
                
                deque.append(numValue)
            }
            // 第一个窗口的最大值就是队列的第一位
            res[0] = deque.first!
            // 形成窗口后
            for i in k..<n {
                // 如果上一个窗口的最大值正好是那个窗口的第一个的话，需要出队列
                if deque.first! == nums[i-k] {
                    deque.removeFirst()
                }
                let numValue = nums[i]
                // 保证是单调递减队列
                while !deque.isEmpty && deque.last! < numValue {
                    deque.removeLast()
                }
                deque.append(numValue)
                res[i-k+1] = deque.first!
            }
            return res
        }
        
        func maxSlidingWindow2(_ nums: [Int], _ k: Int) -> [Int] {
            if nums.count == 0 || k == 0 {
                return []
            }
            let n = nums.count,
                windowsLRange = (1-k)..<(n-k+1),
                windowsRRange = 0..<n
            var deque = [Int](),
                res = [Int](repeating: 0, count: n - k + 1)
            // i和j分别是每个窗口的左边界和右边界，同时i也代表是第几个窗口
            for (i, j) in zip(windowsLRange, windowsRRange) {
                // 如果上一个窗口的最大值正好是它的第一个的话，本次需要出队列
                if i > 0 && deque.first! == nums[i-1] {
                    deque.removeFirst()
                }
                // 保证是单调递减队列
                while !deque.isEmpty && deque.last! < nums[j] {
                    deque.removeLast()
                }
                
                deque.append(nums[j])
                // 记录窗口最大值
                if i >= 0 {
                    res[i] = deque.first!
                }
            }
            return res
        }
    }
}
