//
//  Algorithm4Review.swift
//  CommandLine
//
//  Created by unravel on 2022/4/1.
//

import Foundation
public class Algorithm4Review {
    // MARK: 有15个瓶子，其中最多有一瓶有毒，现在有四只老鼠，喝了有毒的水之后，第二天就会死。
    // 如何在第二天就可以判断出哪个瓶子有毒？
    // http://cloverkim.com/mouse-drug-water.html
    // 核心思想：第n个老鼠喝二进制表示的第n位上为1的瓶子里的水
    // mices为老鼠的存活状态 0011
    func bottles15(mices: [Int]) {
        let miceNum: Int = 4
        guard mices.count == miceNum else {
            return
        }
        
        var drug: Int = 0
        for i in 0..<miceNum {
            drug |= (mices[i] << (miceNum - i - 1))
        }
        
        if drug == 0 {
            print("无毒")
        }
        else {
            print("有毒的瓶子是第 \(drug) 瓶")
        }
    }
    
    // MARK: 一个乱序数组，求符合 一个 比它前面的数都大，比它后面的数都小的数 组成的子数组
    // 核心思想：使用栈先进后出的特性，判断要进的数比栈顶的大就直接进，比栈顶的数小就一直弹栈到比它大为止
    func printMinMaxArray() {
        let array = [1, 2, 7, 3, 10, 9, 11, 1, 5, 38, 12, 25, 56, 100]
        var stack = Stack<Int>()
        
        if array.count > 0 {
            var maxValue = array[0]
            stack.push(maxValue)
            
            for value in array {
                if value > maxValue {
                    maxValue = value
                    stack.push(maxValue)
                }
                else {
                    while let topValue = stack.top, topValue > value {
                        stack.pop()
                    }
                }
            }
        }
        print("获取到结果 \(stack.toArray)")
    }
    
    // MARK: 构建并打印倒三角形
    // 核心思想：找规律，先竖着找行之间的规律，再横着找列之间的规律
    func printInvertedtriangle(_ numLines: Int) {
        let count = numLines + 1
        
        var ret = [[Int]](repeating: [Int](repeating: 0, count: count),
                          count: count)
        ret[0][0] = 1
        for i in 0..<numLines {
            // 两行之间相差的数
            let rowdet = i + 1
            // 竖着的，每一行比上一行 大row+1
            ret[i + 1][0] = ret[i][0] + rowdet
            print("\(ret[i][0]) ", separator: "", terminator: "")
            
            // 剩多少列
            let colNum = numLines - i - 1
            
            for j in 0..<colNum {
                // 两列之间相差的数
                let coldet = j + 1
                ret[i][j + 1] = ret[i][j] + rowdet + coldet
                print("\(ret[i][j + 1]) ", separator: "", terminator: "")
            }
            print("\n")
        }
    }
    
    // MARK: 给定两个排好序的数组A,B，请写一个函数，从中找到它们的公共元素
    // 核心思想：使用双指针同时遍历数组
    func findCommon(arrA: [Int], arrB: [Int]) -> [Int] {
        if arrA.count == 0 ||
            arrB.count == 0 {
            return []
        }
        
        let aCount = arrA.count, bCount = arrB.count
        var indexA = 0, indexB = 0
        
        var ret: [Int] = []
        while indexA < aCount && indexB < bCount {
            let valA = arrA[indexA]
            let valB = arrB[indexB]
            
            if valA < valB {
                indexA += 1
            }
            else if valA == valB {
                indexA += 1
                indexB += 1
                ret.append(valA)
            }
            else {
                indexB += 1
            }
        }
        return ret
    }
    
    // MARK: 斐波那契
    func fiboacci(_ n: Int) -> Int {
        if n <= 1 {
            return 1
        }
        return fiboacci(n - 1) + fiboacci(n - 2)
    }
    
    //  MARK: 是否是一个质数（只能被1和自身整除）
    func isPrime(_ n: Int) -> Bool {
        for i in 2...Int(sqrt(Double(n))) {
            if n % i == 0 {
                return false
            }
        }
        return true
    }
    
    // MARK: 给一个字符串，将其按照单词顺序进行反转。
    // 比如说 s 是 "the sky is blue", 那么反转就是 "blue is sky the"。
    /*
     * 核心思想
     * 整个字符串翻转，"the sky is blue" -> "eulb si yks eht"
     * 每个单词作为一个字符串单独翻转，"eulb si yks eht" -> "blue is sky the"
     */
    func reverseWords(s: String?) -> String? {
        guard let s = s else {
            return nil
        }
        var chars = Array(s), start = 0
        
        func reverse(_ start: Int,
                     _ end: Int) {
            var start = start, end = end
            
            while start < end {
                (chars[start], chars[end]) = (chars[end], chars[start])
                
                start += 1
                end -= 1
            }
        }
        
        reverse( 0, chars.count - 1)
        
        for i in 0 ..< chars.count {
            if i == chars.count - 1 || chars[i + 1] == " " {
                reverse(start, i)
                start = i + 2
            }
        }
        
        return String(chars)
    }
    
    // MARK: 给一个链表和一个值 x，要求将链表中所有小于 x 的值放到左边，所有大于等于 x 的值放到右边。原链表的节点顺序不能变
    // 例：1->5->3->2->4->2，给定x = 3。则我们要返回1->2->2->5->3->4
    // 思想：先处理左边（比 x 小的节点），然后再处理右边（比 x 大的节点），最后再把左右两边拼起来
    func partition(_ head: ListNode?,
                   _ x: Int) -> ListNode? {
        // 引入Dummy节点
        let prevDummy = ListNode(0), postDummy = ListNode(0)
        var prev = prevDummy, post = postDummy
        
        var node = head
        
        // 用尾插法处理左边和右边
        while node != nil {
            if node!.val < x {
                prev.next = node
                prev = node!
            }
            else {
                post.next = node
                post = node!
            }
            node = node!.next
        }
        
        // 防止构成环
        post.next = nil
        // 左右拼接
        prev.next = postDummy.next
        return prevDummy.next
    }
    
    
    // MARK: 判断一颗二叉树是否为二叉查找树
    func isValidBST(root: TreeNode?) -> Bool {
        func _helper(_ node: TreeNode?,
                     _ min: Int,
                     _ max: Int) -> Bool {
            guard let node = node else {
                return true
            }
            // 所有右子节点都必须大于根节点
            if node.val <= min {
                return false
            }
            // 所有左子节点都必须小于根节点
            if node.val >= max {
                return false
            }
            return _helper(node.left, min, node.val) && _helper(node.right, node.val, max)
        }
        
        return _helper(root, Int.min, Int.max)
    }
}

// MARK: 冒泡排序，升序
extension Array where Element: Comparable {
    public mutating func bubbleSort() {
        let count = self.count
        for i in 0..<count {
            for j in 0..<(count - 1 - i) {
                if self[j] > self[j + 1] {
                    (self[j], self[j + 1]) = (self[j + 1], self[j])
                }
            }
        }
    }
}

// MARK: 选择排序，升序
extension Array where Element: Comparable {
    public mutating func selectionSort() {
        let count = self.count
        for i in 0..<count {
            var minIndex = i
            for j in (i+1)..<count {
                if self[j] < self[minIndex] {
                    minIndex = j
                }
            }
            (self[i], self[minIndex]) = (self[minIndex], self[i])
        }
    }
}

// MARK: 插入排序，升序
extension Array where Element: Comparable {
    public mutating func insertionSort() {
        let count = self.count
        guard count > 1 else {
            return
        }
        for i in 1..<count {
            var preIndex = i - 1
            let currentValue = self[i]
            while preIndex >= 0 && currentValue < self[preIndex] {
                self[preIndex + 1] = self[preIndex]
                preIndex -= 1
            }
            self[preIndex + 1] = currentValue
        }
    }
}

// MARK: 快速排序，升序
extension Array where Element: Comparable {
    public mutating func quickSort() {
        func quickSort(left: Int, right: Int) {
            guard left < right else { return }
            // 使用最左侧值定义一个key，找出大于它和小于它中间的splitInd
            let key = self[left]
            // ind遍历所用的index，splitInd用于分隔所用的index
            var splitInd = left
            for ind in (left + 1)...right {
                if self[ind] < key {
                    splitInd += 1
                    // 这一步就是为了保证分为左右两半，左边半半比key小，右边半半比key大
                    (self[ind], self[splitInd]) = (self[splitInd], self[ind])
                }
            }
            (self[left], self[splitInd]) = (self[splitInd], self[left])
            // 左侧区域
            quickSort(left: left, right: splitInd - 1)
            // 右侧区域
            quickSort(left: splitInd + 1, right: right)
        }
        // 整个区域
        quickSort(left: 0, right: self.count - 1)
    }
}

// MARK: 随机快排，升序
extension Array where Element: Comparable {
    public mutating func randomQuickSort() {
        func quickSort(left: Int, right: Int) {
            guard left < right else { return }
            let randomIndex = Int.random(in: left...right)
            // 交换之后，就和使用最左侧值作为key是一样的了
            (self[left], self[randomIndex]) = (self[randomIndex], self[left])
            let key = self[left]
            
            var splitInd = left
            for ind in (left + 1)...right {
                if self[ind] < key {
                    splitInd += 1
                    (self[ind], self[splitInd]) = (self[splitInd], self[ind])
                }
            }
            (self[left], self[splitInd]) = (self[splitInd], self[left])
            // 左侧区域
            quickSort(left: left, right: splitInd - 1)
            // 右侧区域
            quickSort(left: splitInd + 1, right: right)
        }
        // 整个区域
        quickSort(left: 0, right: self.count - 1)
    }
}

// MARK: 双路快排，升序
extension Array where Element: Comparable {
    public mutating func doubleQuickSort() {
        func quickSort(left: Int, right: Int) {
            guard left < right else { return }
            let randomIndex = Int.random(in: left...right)
            // 交换之后，就和使用最左侧值作为key是一样的了
            (self[left], self[randomIndex]) = (self[randomIndex], self[left])
            let key = self[left]
            
            var l = left + 1, r = right
            while true {
                // 找到小于key的最大的下标
                while l <= r && self[l] < key {
                    l += 1
                }
                // 找到大于key的最小的下标
                while l < r && key < self[r] {
                    r -= 1
                }
                
                if l > r { break }
                (self[l], self[r]) = (self[r], self[l])
                l += 1
                r -= 1
            }
            (self[r], self[left]) =  (self[left], self[r])
            // 左侧区域
            quickSort(left: left, right: r - 1)
            // 右侧区域
            quickSort(left: r + 1, right: right)
        }
        // 整个区域
        quickSort(left: 0, right: self.count - 1)
    }
}

// MARK: 三路快排，升序
extension Array where Element: Comparable {
    public mutating func tripleQuickSort() {
        func quickSort(left: Int, right: Int) {
            guard left < right else { return }
            let randomIndex = Int.random(in: left...right)
            // 交换之后，就和使用最左侧值作为key是一样的了
            (self[left], self[randomIndex]) = (self[randomIndex], self[left])
            let key = self[left]
            
            var lt = left, gt = right
            var i = left + 1
            
            while i <= gt {
                if self[i] == key {
                    i += 1
                }
                else if self[i] < key {
                    (self[i], self[lt + 1]) = (self[lt + 1], self[i])
                    lt += 1
                    i += 1
                }
                else {
                    (self[i], self[gt]) = (self[gt], self[i])
                    gt -= 1
                }
            }
            
            (self[left], self[lt]) =  (self[lt], self[left])
            // 左侧区域
            quickSort(left: left, right: lt - 1)
            // 右侧区域
            quickSort(left: gt + 1, right: right)
        }
        // 整个区域
        quickSort(left: 0, right: self.count - 1)
    }
    
    // MARK: 二进制求和
    func addBinary(_ a: String, _ b: String) -> String {
        // 形参和实参名字可以一样，但是，其实他们是不一样的东西
        let a = [Character](a), b = [Character](b)
        
        var res = "",
            carry = 0,
            i = a.count - 1,
            j = b.count - 1
        
        while i >= 0 || j >= 0 || carry > 0 {
            var sum = 0
            if i >= 0 {
                sum += Int(String(a[i]))!
                i -= 1
            }
            
            if j >= 0 {
                sum += Int(String(b[j]))!
                j -= 1
            }
            
            res = "\(sum % 2)" + res
            carry = sum / 2
        }
        return res
    }
    
    // MARK: 获取数组的第K个最大的数
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        return nums.sorted()[nums.count-k]
    }
    
    // MARK: 获取一个整数的二进制周期
    func getBinaryPeriodForInt(_ n: Int) -> Int {
        var nn = n
        var d = [Int]()
        var l = 0, res = -1
        while l > 0 {
            d[l] = nn % 2
            nn /= 2
            l += 1
        }
        for p in 1..<l {
            if p < l / 2 {
                var ok = true
                for i in 0..<l-p {
                    if d[i] != d[i+p] {
                        ok = false
                        break
                    }
                }
                if ok {
                    res = p
                }
            }
        }
        return res
    }
}
