//
//  Cyc2018_leetcode+x.swift
//  CommandLine
//
//  Created by unravel on 2022/4/14.
//

import Foundation
extension Cyc2018_leetcode {
    class DataStructure_String {
        // MARK: 字符串循环移位
        // 编程之美 2.17
        // 将 abcd123 中的 abcd 和 123 单独翻转，得到 dcba321，然后对整个字符串进行翻转，得到 123abcd
        func cycleMove(_ s: String, _ k: Int) -> String {
            let sChars = Array(s), k1 = sChars.count - k % sChars.count
            return String(sChars[k1...] + sChars[..<k1])
        }
        
        // MARK: 字符串循环移位 包含子串
        // 编程之美 3.1
        func cycInclude(_ s1: String, _ s2: String) -> Bool {
            let s1Chars = Array(s1)
            for i in (0..<s1Chars.count).reversed() {
                // 逐个移位比较
                let moved = String(s1Chars[i...] + s1Chars[0..<i])
                if moved.contains(s2) {
                    return true
                }
            }
            return false
        }
        
        // MARK: 字符串中单词的翻转
        // https://leetcode.cn/problems/fan-zhuan-dan-ci-shun-xu-lcof/submissions/
        // 程序员代码面试指南
        // 将每个单词翻转，然后将整个字符串翻转
        func revertWords(_ s: String) -> String {
            
            var sChars = Array(s), sCharCount = sChars.count
            // 反转单词
            func revertWord(_ i: Int, _ j: Int) {
                var i = i, j = j
                while i < j {
                    (sChars[i], sChars[j]) = (sChars[j], sChars[i])
                    i += 1
                    j -= 1
                }
            }
            
            var start = 0, end = 0
            while end <= sCharCount {
                // 到达末尾或者遇到了空格
                if end == sCharCount || sChars[end] == " " {
                    revertWord(start, end - 1)
                    start = end + 1
                }
                end += 1
            }
            revertWord(0, sCharCount - 1)
            return String(sChars)
        }
        
        // MARK: 两个字符串包含的字符是否完全相同（字符和数量）
        // https://leetcode-cn.com/problems/valid-anagram/description/
        func isAnagram(_ s: String, _ t: String) -> Bool {
            let sChars = Array(s), tChars = Array(t)
            if sChars.count != tChars.count { return false }
            // 统计字符出现的次数
            var ch2Count = [Character: Int]()
            for c in sChars {
                ch2Count[c, default: 0] += 1
            }
            
            for c in tChars {
                // 如果包含第一个字典里不包含的key，直接返回false
                if ch2Count[c] == nil {
                    return false
                }
                ch2Count[c]! -= 1
            }
            // 判断是否都已经是0了
            return ch2Count.allSatisfy { $0.1 == 0 }
        }
        
        // MARK: 计算一组字符集合可以组成的回文字符串的最大长度
        // https://leetcode-cn.com/problems/longest-palindrome/description/
        func longestPalindrome(_ s: String) -> Int {
            let sChars = Array(s)
            // 统计字符出现的次数
            let ch2Count = sChars.reduce(into: [Character: Int]()) { partialResult, ch in
                partialResult[ch, default: 0] += 1
            }
            
            var palindrome = 0
            // 统计字符个数为偶数的和
            _ = ch2Count.mapValues { palindrome += ($0 / 2) * 2 }
            
            if palindrome < sChars.count {
                // 这个条件下 s 中一定有单个未使用的字符存在，可以把这个字符放到回文的最中间
                palindrome += 1
            }
            return palindrome
        }
        
        // MARK: 字符串同构
        // https://leetcode-cn.com/problems/isomorphic-strings/description/
        func isIsomorphic(_ s: String, _ t: String) -> Bool {
            if s.count != t.count { return false }
            // foo bar
            let sChars = Array(s), tChars = Array(t), dfValue = 0
            var sCh2Cnt = [Character:Int](), tCh2Cnt = [Character:Int]()
            for i in 0..<sChars.count {
                let sc = sChars[i], tc = tChars[i]
                // 处理一个为空，另一个不为空
                // 或者 都不为空，但是值不相等的情况
                if sCh2Cnt[sc, default: dfValue] != tCh2Cnt[tc, default: dfValue] {
                    return false
                }
                
                sCh2Cnt[sc] = i + 1
                tCh2Cnt[tc] = i + 1
            }
            return true
        }
        
        // MARK: 回文子字符串个数
        // https://leetcode-cn.com/problems/palindromic-substrings/description/
        func countSubstrings(_ s: String) -> Int {
            let sChars = Array(s)
            var cnt = 0
            func extendSubString(_ start: Int, _ end: Int) {
                var start = start, end = end
                while start >= 0 &&
                        end < sChars.count &&
                        sChars[start] == sChars[end] {
                    start -= 1
                    end += 1
                    cnt += 1
                }
            }
            
            for  i in 0..<sChars.count {
                // 奇数长度
                extendSubString(i, i)
                // 偶数长度
                extendSubString(i, i + 1)
            }
            return cnt
        }
        
        // MARK: 判断一个整数是否是回文数
        // https://leetcode-cn.com/problems/palindrome-number/description/
        func isPalindrome(_ x: Int) -> Bool {
            if x == 0 { return true }
            if x < 0 || x % 10 == 0 { return false }
            
            var x = x, right = 0
            while x > right {
                right = right * 10 + x % 10
                x /= 10
            }
            return x == right || x == right / 10
        }
        
        // MARK: 统计二进制字符串中连续 1 和连续 0 数量相同的子字符串个数
        // https://leetcode-cn.com/problems/count-binary-substrings/description/
        func countBinarySubstrings(_ s: String) -> Int {
            let sChars = Array(s)
            var preLen = 0, curLen = 1, count = 0
            for i in 1..<sChars.count {
                if sChars[i] == sChars[i - 1] {
                    curLen += 1
                }
                else {
                    preLen = curLen
                    curLen = 1
                }
                if preLen >= curLen {
                    count += 1
                }
            }
            return count
        }
    }
}
