//
//  Cyc2018_leetcode+x.swift
//  CommandLine
//
//  Created by unravel on 2022/4/14.
//

import Foundation
extension Cyc2018_leetcode {
    class DataStructure_BitOperation {
        // MARK: 统计两个数的二进制表示有多少位不同
        // https://leetcode-cn.com/problems/hamming-distance/
        // 对两个数进行异或操作，位级表示不同的那一位为 1，统计有多少个 1 即可。
        func hammingDistance(_ x: Int, _ y: Int) -> Int {
            var z = x ^ y
            var cnt = 0
            while z != 0 {
                z &= (z - 1)
                cnt += 1
            }
            return cnt
        }
        
        func hammingDistance2(_ x: Int, _ y: Int) -> Int {
            let z = x ^ y
            return z.nonzeroBitCount
        }
        
        // MARK: 数组中唯一一个不重复的元素
        // https://leetcode-cn.com/problems/single-number/description/
        // 两个相同的数异或的结果为 0，对所有数进行异或操作，最后的结果就是单独出现的那个数
        func singleNumber(_ nums: [Int]) -> Int {
            var ret = 0
            for num in nums {
                ret ^= num
            }
            return ret
        }
        
        // MARK: 找出数组中缺失的那个数
        // https://leetcode-cn.com/problems/missing-number/description/
        func missingNumber(_ nums: [Int]) -> Int {
            var ret = 0
            for (ind, num) in nums.enumerated() {
                ret ^= ind ^ num
            }
            return ret ^ nums.count
        }
        
        func missingNumber2(_ nums: [Int]) -> Int {
            var ret = 0
            for num in nums {
                ret ^= num
            }
            
            let n = nums.count
            for i in 0...n {
                ret ^= i
            }
            return ret
        }
        
        // MARK: 数组中不重复的两个元素
        // https://leetcode-cn.com/problems/single-number-iii/description/
        func singleNumber(_ nums: [Int]) -> [Int] {
            var diff = 0
            for num in nums {
                diff ^= num
            }
            // 得到最右一位
            diff &= -diff
            var ret = [Int](repeating: 0, count: 2)
            for num in nums {
                if num & diff == 0 {
                    ret[0] ^= num
                }
                else {
                    ret[1] ^= num
                }
            }
            return ret
        }
        
        func singleNumber2(_ nums: [Int]) -> [Int] {
            var xorsum = 0
            for num in nums {
                xorsum ^= num
            }
            // 防止溢出，同时得到 type1和type2用于区分的最后一位
            let lsb = (xorsum == Int.min) ? xorsum : xorsum & (-xorsum)
            var type1 = 0, type2 = 0
            for num in nums {
                if num & lsb == 0 {
                    type1 ^= num
                }
                else {
                    type2 ^= num
                }
            }
            return [type1, type2]
        }
        
        // MARK: 翻转一个数的比特位
        // https://leetcode-cn.com/problems/reverse-bits/description/
        func reverseBits(_ n: Int) -> Int {
            var ret = 0
            var mutN = n
            for _ in 0..<32 {
                // ret左移一位，用于后面处理移过去的这一位
                ret <<= 1
                // 设置ret的最后一位
                ret |= (mutN & 1)
                // 右移一位
                mutN >>= 1
            }
            return ret
        }
        
        // MARK: 不用额外变量交换两个整数
        // 程序员代码面试指南 ：P317
        func swap(_ a: Int, _ b: Int) {
            var a = a, b = b
            a = a ^ b
            b = a ^ b
            a = a ^ b
        }
        
        // MARK: 判断一个数是不是 2 的 n 次方
        // https://leetcode-cn.com/problems/power-of-two/description/
        func isPowerOfTwo(_ n: Int) -> Bool {
            return n > 0 && n.nonzeroBitCount == 1
        }
        
        func isPowerOfTwo2(_ n: Int) -> Bool {
            return n > 0 && (n & (n - 1)) == 0
        }
        
        // MARK: 判断一个数是不是 4 的 n 次方
        // https://leetcode-cn.com/problems/power-of-four/
        // 这种数在二进制表示中有且只有一个奇数位为 1
        func isPowerOfFour(_ n: Int) -> Bool {
            //            return n > 0 && (n & (n - 1)) == 0 && (n & 0b01010101010101010101010101010101) != 0
            //            return n > 0 && (n & (n - 1)) == 0 && (n & 0xaaaaaaaa) != 0
            return n > 0 && (n & (n - 1)) == 0 && n % 3 == 1
        }
        
        // MARK: 判断一个数的位级表示是否不会出现连续的 0 和 1
        // https://leetcode-cn.com/problems/binary-number-with-alternating-bits/description/
        func hasAlternatingBits(_ n: Int) -> Bool {
            let a = n ^ (n >> 1)
            return (a & (a + 1)) == 0
        }
        
        // MARK: 求一个数的补码
        // https://leetcode-cn.com/problems/number-complement/description/
        func findComplement(_ num: Int) -> Int {
            if num == 0 { return 1 }
            var mask = 1 << 30
            while num & mask == 0 {
                mask >>= 1
            }
            mask = (mask << 1) - 1
            return num & mask
        }
        
        // MARK: 实现整数的加法
        // https://leetcode-cn.com/problems/sum-of-two-integers/description/
        func getSum(_ a: Int, _ b: Int) -> Int {
            return b == 0 ? a : getSum((a ^ b), (a & b) << 1)
        }
        
        // MARK: 字符串数组最大乘积
        // https://leetcode-cn.com/problems/maximum-product-of-word-lengths/description/
        func maxProduct(_ words: [String]) -> Int {
            let n = words.count
            var val = [Int](repeating: 0, count: n)
            let aCharAscii = Character("a").asciiValue!
            for i in 0..<n {
                let s = words[i]
                for c in Array(s) {
                    // 存储每个字符是否出现过
                    val[i] |= 1 << (c.asciiValue! - aCharAscii)
                }
            }
            
            var ret = 0
            for i in 0..<n {
                for j in (i+1)..<n {
                    if val[i] & val[j] == 0 {
                        ret = max(ret, words[i].count * words[j].count)
                    }
                }
            }
            return ret
        }
        
        
        // MARK: 统计从 0 ~ n 每个数的二进制表示中 1 的个数
        // https://leetcode-cn.com/problems/counting-bits/description/
        func countBits(_ n: Int) -> [Int] {
            var ret = [Int](repeating: 0, count: n + 1)
            if n > 0 {
                for i in 1...n {
                    ret[i] = ret[i & (i-1)] + 1
                }
            }
            return ret
        }
        
        
        func countBits2(_ n: Int) -> [Int] {
            var ret = [Int](repeating: 0, count: n + 1)
            ret[0] = 0
            if n > 0 {
                for i in 1...n {
                    if i % 2 == 1 {
                        ret[i] = ret[i - 1] + 1
                    }
                    else {
                        ret[i] = ret[i / 2]
                    }
                }
            }
            return ret
        }
    }
}
