//
//  Cyc2018_leetcode+DoublePointer.swift
//  CommandLine
//
//  Created by unravel on 2022/2/28.
//

import Foundation
extension Cyc2018_swordOffer {
    class Cyc2018_swordOffer_DoublePointer {
        // MARK:  和为S的两个数字
        // https://leetcode.cn/problems/he-wei-sde-liang-ge-shu-zi-lcof/
        // 思想：从两个方向往中间挤
        func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
            var i = 0, j = nums.count - 1
            while i < j {
                let iValue = nums[i]
                let jValue = nums[j]
                let sumValue = iValue + jValue
                if sumValue == target {
                    return [iValue, jValue]
                }
                else if sumValue < target {
                    i += 1
                }
                else {
                    j -= 1
                }
            }
            return []
        }
        
        // MARK: 和为 S 的连续正数序列
        // https://leetcode.cn/problems/he-wei-sde-lian-xu-zheng-shu-xu-lie-lcof/
        // 序列内按照从小至大的顺序，序列间按照开始数字从小到大的顺序
        // 思想： 双指针分别指向连续序列的开头和结尾
        func findContinuousSequence(_ target: Int) -> [[Int]] {
            var ret = [[Int]]()
            var start = 1, end = 2
            var curSum = start + end
            while end < target {
                if curSum < target {
                    // 说明区间还可以增长，区间右侧增长
                    end += 1
                    curSum += end
                }
                else if curSum > target {
                    // 说明区间过长，需要缩短，只能从start缩
                    curSum -= start
                    start += 1
                }
                else {
                    // 相等的时候，需要把start到end的区间组合成一个序列
                    ret.append([Int](start...end))
                    // 试着保持等长区间
                    curSum -= start
                    start += 1
                    end += 1
                    curSum += end
                }
            }
            return ret
        }
        
        // MARK: 翻转单词顺序
        // https://leetcode.cn/problems/fan-zhuan-dan-ci-shun-xu-lcof/
        // 思想：先翻转内部单个单词，再整体翻转句子
        func reverseSentence(_ s: String) -> String {
            return s.split(separator: " ")
                .compactMap { $0 == " " ? nil : $0 }
                .reversed()
                .joined(separator: " ")
        }
        
        // MARK: 左旋转字符串
        // https://leetcode.cn/problems/zuo-xuan-zhuan-zi-fu-chuan-lcof/submissions/
        func leftRotateString(_ str: String, _ n: Int) -> String {
            if n < 0 || n >= str.count {
                return str
            }
            
            var sChars = Array(str), sCharsCnt = sChars.count
            
            func reverse(_ i: Int, _ j: Int) {
                var mulI = i, mulJ = j
                while mulI < mulJ {
                    (sChars[mulI], sChars[mulJ]) = (sChars[mulJ], sChars[mulI])
                    mulI += 1
                    mulJ -= 1
                }
            }
            
            reverse(0, n - 1)
            reverse(n, sCharsCnt - 1)
            reverse(0, sCharsCnt - 1)
            return String(sChars)
        }
        
        func reverseLeftWords(_ s: String, _ n: Int) -> String {
            let sChars = Array(s)
            if n < 0 || n > sChars.count {
                return s
            }
            return String(sChars[n...] + sChars[..<n])
        }
    }
}
