//
//  Cyc2018_leetcode+x.swift
//  CommandLine
//
//  Created by unravel on 2022/4/14.
//

import Foundation
extension Cyc2018_leetcode {
    class DataStructure_Hash {
        // MARK: 数组中两个数的和为给定值，返回他们的下标
        // https://leetcode-cn.com/problems/two-sum/description/
        func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
            var indexForNum = [Int: Int]()
            for (index, value) in nums.enumerated() {
                let remind = target - value
                if indexForNum[remind] != nil {
                    return [indexForNum[remind]!, index]
                }
                else {
                    indexForNum[value] = index
                }
            }
            return []
        }
        
        // MARK: 给一个整型数组和一个目标值，判断数组中是否有两个数字之和等于目标值
        func twoSum1(nums: [Int], _ target: Int) -> Bool {
            var set = Set<Int>()
            
            for num in nums {
                if set.contains(target - num) {
                    return true
                }
                set.insert(num)
            }
            return false
        }
        
        // MARK: 判断数组是否含有重复元素
        // https://leetcode-cn.com/problems/contains-duplicate/description/
        func containsDuplicate(_ nums: [Int]) -> Bool {
            let set = Set<Int>(nums)
            return set.count != nums.count
        }
        
        // MARK: 数组中元素能够组成的最长和谐序列的长度
        // https://leetcode-cn.com/problems/longest-harmonious-subsequence/description/
        func findLHS(_ nums: [Int]) -> Int {
            // 调用reduce方法，构建一个key为num value为出现次数的字典
            let countForNum = nums.reduce(into: [Int:Int]()) { partialResult, num in
                // 这里partialResut是一个inout参数，可以直接修改它的值
                partialResult[num, default: 0] += 1
            }
            
            var longest = 0
            for (num, cnt) in countForNum {
                // 遍历countForNum，获取是否有x和x+1，如果有，将它们出现的次数相加
                if countForNum[num + 1] != nil {
                    longest = max(longest, cnt + countForNum[num + 1]!)
                }
            }
            return longest
        }
        
        // MARK: 数组中的元组能够组成的最长连续序列的长度
        // https://leetcode-cn.com/problems/longest-consecutive-sequence/description/
        func longestConsecutive(_ nums: [Int]) -> Int {
            // 调用reduce方法，构建一个key为num value为出现次数的字典
            var countForNum = nums.reduce(into: [Int:Int]()) { partialResult, num in
                partialResult[num] = 1
            }
            func forward(_ num: Int) -> Int {
                guard var cnt = countForNum[num] else {
                    return 0
                }
                if cnt > 1 {
                    return cnt
                }
                cnt = 1 + forward(num + 1)
                countForNum[num] = cnt
                return cnt
            }
            func maxCount() -> Int {
                var maxCnt = 0
                for (_, v) in countForNum {
                    maxCnt = max(maxCnt, v)
                }
                return maxCnt
            }
            
            for num in nums {
                _  = forward(num)
            }
            return maxCount()
        }
        
        func longestConsecutive2(_ nums: [Int]) -> Int {
            // 转换成一个集合set
            let num_set = Set<Int>(nums)
            // 保存最长的序列长度
            var longestStreak = 0
            // 遍历集合处理，
            for num in num_set {
                // 如果不包含num - 1，说明最长序列
                if !num_set.contains(num - 1) {
                    var currentNum = num, currentStreak = 1
                    while num_set.contains(currentNum + 1) {
                        currentNum += 1
                        currentStreak += 1
                    }
                    longestStreak = max(longestStreak, currentStreak)
                }
            }
            return longestStreak
        }
    }
}
