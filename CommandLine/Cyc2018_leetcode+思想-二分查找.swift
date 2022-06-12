//
//  Cyc2018_leetcode+x.swift
//  CommandLine
//
//  Created by unravel on 2022/4/14.
//

import Foundation
extension Cyc2018_leetcode {
    // 思想之二分查找
    class Think_BinarySearch {
        // MARK: 在已排序数组中 二分查找key
        func binarySearch(_ nums: [Int], _ key: Int) -> (Bool, Int) {
            var l = 0, h = nums.count - 1
            while l <= h {
                let m = l + (h - l) / 2
                if nums[m] == key {
                    return (true, m)
                }
                else if nums[m] > key {
                    h = m - 1
                }
                else {
                    l = m + 1
                }
            }
            return (false, -1)
        }
        
        // MARK: 在一个有重复元素的数组中查找 key 的最左位置
        func binarySearch2(_ nums: [Int], _ key: Int) -> Int {
            var l = 0, h = nums.count - 1
            // 在 h 的赋值表达式为 h = m 的情况下，如果循环条件为 l <= h，那么会出现循环无法退出的情况，因此循环条件只能是 l < h
            while l < h {
                let m = l + (h - l) / 2
                if nums[m] >= key {
                    // 在 nums[m] >= key 的情况下，可以推导出最左 key 位于 [l, m] 区间中，这是一个闭区间。
                    // h 的赋值表达式为 h = m，因为 m 位置也可能是解
                    h = m
                }
                else {
                    l = m + 1
                }
            }
            return nums[l] == key ? l : -1
        }
        
        // MARK: 求开方
        // https://leetcode-cn.com/problems/sqrtx/description/
        func mySqrt(_ x: Int) -> Int {
            if x <= 1 {
                return x
            }
            // 对于 x = 8，它的开方是 2.82842...，最后应该返回 2 而不是 3。
            // 在循环条件为 l <= h 并且循环退出时，h 总是比 l 小 1，也就是说 h = 2，l = 3，因此最后的返回值应该为 h 而不是 l
            var l = 1, h = x
            while l <= h {
                let mid = l + (h - l) / 2
                let sqrt = x / mid
                
                if mid == sqrt {
                    return mid
                }
                else if mid > sqrt {
                    // 说明mid * sqrt < x，需要在左半区域寻找
                    h = mid - 1
                }
                else {
                    l = mid + 1
                }
            }
            return h
        }
        
        // MARK: 大于给定元素的最小元素
        // https://leetcode-cn.com/problems/find-smallest-letter-greater-than-target/description/
        // 给定一个有序的字符数组 letters 和一个字符 target，要求找出 letters 中大于 target 的最小字符，如果找不到就返回第 1 个字符
        func nextGreatestLetter(_ letters: [Character], _ target: Character) -> Character {
            let n = letters.count
            var l = 0, h = n - 1
            while l <= h {
                let m = l + (h - l) / 2
                // 如果中间的字母比target小，说明我们应该在右半区域寻找
                if letters[m] <= target {
                    l = m + 1
                }
                else {
                    h = m - 1
                }
            }
            return l < n ? letters[l] : letters[0]
        }
        
        // MARK: 有序数组的 Single Element
        // https://leetcode-cn.com/problems/single-element-in-a-sorted-array/description/
        // 一个有序数组只有一个数不出现两次，找出这个数
        func singleNonDuplicate(_ nums: [Int]) -> Int {
            var l = 0, h = nums.count - 1
            while l < h {
                var m = l + (h - l) / 2
                if m % 2 == 1 {
                    // 保证 l/h/m 都在偶数位，使得查找区间大小一直都是奇数
                    m -= 1
                }
                if nums[m] == nums[m + 1] {
                    // 说明左半区域是成双成对的
                    l = m + 2
                }
                else {
                    h = m
                }
            }
            return nums[l]
        }
        
        // MARK: 第一个错误的版本
        // https://leetcode-cn.com/problems/first-bad-version/description/
        // 给定一个元素 n 代表有 [1, 2, ..., n] 版本，在第 x 位置开始出现错误版本，导致后面的版本都错误。可以调用 isBadVersion(int x) 知道某个版本是否错误，要求找到第一个错误的版本
        func firstBadVersion(_ n: Int) -> Int {
            func isBadVersion(_ n1: Int) -> Bool {
                if n1 > 5  {
                    return true
                }
                return false
            }
            
            var l = 1, h = n
            while l < h {
                let mid = l + (h - l) / 2
                if isBadVersion(mid) {
                    h = mid
                }
                else {
                    l = mid + 1
                }
            }
            return l
        }
        
        // MARK: 旋转数组的最小数字
        // https://leetcode-cn.com/problems/find-minimum-in-rotated-sorted-array/description/
        func findMin(_ nums: [Int]) -> Int {
            var l = 0, h = nums.count - 1
            while l < h {
                let m = l + (h - l) / 2
                if nums[m] <= nums[h] {
                    h = m
                }
                else {
                    l = m + 1
                }
            }
            return nums[l]
        }
        
        // MARK: 查找区间
        // https://leetcode-cn.com/problems/find-first-and-last-position-of-element-in-sorted-array/
        // 给定一个有序数组 nums 和一个目标 target，要求找到 target 在 nums 中的第一个位置和最后一个位置。
        func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
            func binarySearch(_ lower: Bool) -> Int {
                var left = 0, right = nums.count - 1, ans = nums.count
                while left <= right {
                    let mid = left + (right - left) / 2
                    if nums[mid] > target || (lower && nums[mid] >= target) {
                        right = mid - 1
                        ans = mid
                    }
                    else {
                        left = mid + 1
                    }
                }
                return ans
            }
            
            let leftIdx = binarySearch(true)
            let rightIdx = binarySearch(false) - 1
            if leftIdx <= rightIdx &&
                rightIdx < nums.count &&
                nums[leftIdx] == target &&
                nums[rightIdx] == target {
                return [leftIdx, rightIdx]
            }
            else {
                return [-1, -1]
            }
        }
    }
}
