//
//  Cyc2018_swordOffer+BinarySearch.swift
//  CommandLine
//
//  Created by unravel on 2022/2/28.
//

import Foundation

// 二分查找
extension Cyc2018_swordOffer {
    class Cyc2018_swordOffer_BinarySearch {
        // MARK: 旋转数组的最小数字
        // 思想:  使用二分法找到非递增的那个子数组，那个子数组也可以简单的看做一个小的旋转数组
        // 针对数组中有重复数字的情况
        func minNumberInRotateArray2(nums: [Int]) -> Int {
            if nums.count == 0 {
                return 0
            }
            
            // 切换到顺序查找，找前一个数大于后一个数的位置，返回后面那个数
            func minNumber(l: Int, h:Int) -> Int {
                for i in l..<h {
                    if nums[i] > nums[i + 1] {
                        return nums[i + 1]
                    }
                }
                return nums[l]
            }
            
            
            var l = 0, h = nums.count - 1
            while (l < h) {
                let m = l + (h - l) / 2
                // 如果头中尾都相等，最小值一定在这个数组中
                if nums[l] == nums[m] && nums[m] == nums[h] {
                    return minNumber(l: l, h: h)
                }
                else if nums[m] <= nums[h] {
                    h = m
                }
                else {
                    l = m + 1
                }
            }
            return nums[l]
        }
        
        // 针对数组中没有重复数字的情况
        func minNumberInRotateArray(nums: [Int]) -> Int {
            return Cyc2018_leetcode.Think_BinarySearch().findMin(nums)
        }
        
        // MARK:  数字在排序数组中出现的次数
        // 思想：  使用二分查找，查找到它出现的第一个位置和最后一个位置
        func getNumberOfK(_ nums: [Int], _ k: Int) -> Int {
            let range = Cyc2018_leetcode.Think_BinarySearch().searchRange(nums, k)
            return abs(range[1] - range[0])
        }
    }
}
