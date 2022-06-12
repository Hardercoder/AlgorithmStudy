//
//  Cyc2018_leetcode+x.swift
//  CommandLine
//
//  Created by unravel on 2022/4/14.
//

import Foundation
extension Cyc2018_leetcode {
    // 思想之双指针
    class Think_DoublePointer {
        // MARK: 在有序数组中找出两个数，使它们的和为 target
        // 数组中的元素最多遍历一次，时间复杂度为 O(N)。只使用了两个额外变量，空间复杂度为 O(1)
        // https://leetcode-cn.com/problems/two-sum-ii-input-array-is-sorted/description/
        func twoSum(_ numbers: [Int],
                    _ target: Int) -> [Int] {
            if numbers.count == 0 {
                return [-1, -1]
            }
            
            var i = 0, j = numbers.count - 1
            while i < j {
                let sum = numbers[i] + numbers[j]
                if (sum == target) {
                    return [i, j]
                }
                else if (sum < target) {
                    i += 1
                }
                else {
                    j -= 1
                }
            }
            return [-1, -1]
        }
        
        // MARK: 判断一个非负整数是否为两个整数的平方和
        // 因为最多只需要遍历一次 0~sqrt(target)，所以时间复杂度为 O(sqrt(target))。又因为只使用了两个额外的变量，因此空间复杂度为 O(1)。
        // https://leetcode-cn.com/problems/sum-of-square-numbers/description/
        func judgeSquareSum(_ c: Int) -> Bool {
            if c < 0 {
                return false
            }
            
            var i = 0, j = Int(sqrt(Double(c)))
            while i <= j {
                let powSum = i * i + j * j
                if powSum == c {
                    return true
                }
                else if powSum > c {
                    j -= 1
                }
                else {
                    i += 1
                }
            }
            return false
        }
        
        // MARK: 反转字符串中的元音字符
        // https://leetcode-cn.com/problems/reverse-vowels-of-a-string/submissions/
        /*
         时间复杂度为 O(N)：只需要遍历所有元素一次
         空间复杂度 O(1)：只需要使用两个额外变量
         */
        func reverseVowels(_ s: String) -> String {
            if s.count == 0 {
                return s
            }
            let vowels: Set<Character> = ["a", "e", "i", "i", "o", "u", "A", "E", "I", "O", "U"]
            var result = Array<Character>(s)
            
            var i = 0, j = result.count - 1
            while i <= j {
                if !vowels.contains(result[i]) {
                    i += 1
                    continue
                }
                
                if !vowels.contains(result[j]) {
                    j -= 1
                    continue
                }
                
                (result[i], result[j]) = (result[j], result[i])
                i += 1
                j -= 1
            }
            return String(result)
        }
        
        // MARK: 可以删除一个字符，判断是否能构成回文字符串
        // https://leetcode-cn.com/problems/valid-palindrome-ii/submissions/
        func validPalindrome(_ s: String) -> Bool {
            let chars = Array<Character>(s)
            // 是否是回文串
            func isPalindrome(_ i: Int, _ j: Int) -> Bool {
                var ii = i
                var jj = j
                while ii < jj {
                    if (chars[ii] != chars[jj]) {
                        return false
                    }
                    ii += 1
                    jj -= 1
                }
                return true
            }
            
            var i = 0, j = chars.count - 1
            while i < j {
                if (chars[i] != chars[j]) {
                    // 只需要判断剩余的子串是不是回文串
                    return isPalindrome(i, j - 1) || isPalindrome(i + 1, j)
                }
                i += 1
                j -= 1
            }
            return true
        }
        
        // MARK: 归并两个有序数组，把归并结果存到第一个数组上
        // https://leetcode-cn.com/problems/merge-sorted-array/description/
        func merge(_ nums1: inout [Int], _ nums2: [Int]) {
            var index1 = nums1.count - nums2.count - 1, index2 = nums2.count - 1
            var indexMerge = nums1.count - 1
            
            while index2 >= 0 {
                if index1 < 0 {
                    // 把nums2依次加到末尾
                    nums1[indexMerge] = nums2[index2]
                    index2 -= 1
                }
                else if nums1[index1] > nums2[index2] {
                    nums1[indexMerge] = nums1[index1]
                    index1 -= 1
                }
                else {
                    nums1[indexMerge] = nums2[index2]
                    index2 -= 1
                }
                indexMerge -= 1
            }
        }
        
        // MARK: 判断链表是否存在环
        // https://leetcode-cn.com/problems/linked-list-cycle/description/
        func hasCycle(_ head: ListNode?) -> Bool {
            if head == nil {
                return false
            }
            
            var l1 = head, l2 = head!.next
            while l1 != nil &&
                    l2 != nil &&
                    l2!.next != nil {
                if l1 === l2 {
                    return true
                }
                l1 = l1?.next
                l2 = l2?.next?.next
            }
            return false
        }
        
        // MARK: 最长子序列，删除 s 中的一些字符，使得它构成字符串列表 d 中的一个字符串，找出能构成的最长字符串。如果有多个相同长度的结果，返回字典序的最小字符串
        // https://leetcode-cn.com/problems/longest-word-in-dictionary-through-deleting/
        func findLongestWord(_ s: String, _ dictionary: [String]) -> String {
            let sChars = Array<Character>(s),
                sCharsCount = sChars.count
            // 判断 target是否是由s中的字符构成的字符串
            func isSubstrOfS(_ target: String) -> Bool {
                let targetChars = [Character](target),
                    targetCharsCount = targetChars.count
                var i = 0, j = 0
                while i < sCharsCount && j < targetCharsCount {
                    if sChars[i] == targetChars[j] {
                        j += 1
                    }
                    i += 1
                }
                return j == targetChars.count
            }
            
            var longestWord = ""
            // 遍历 dictionary中的每一个target，判断target是否是s的子串
            for target in dictionary {
                let l1 = longestWord.count, l2 = target.count
                if (l1 > l2 || (l1 == l2 && longestWord < target)) {
                    continue
                }
                if isSubstrOfS(target) {
                    longestWord = target
                }
            }
            return longestWord
        }
    }
}
