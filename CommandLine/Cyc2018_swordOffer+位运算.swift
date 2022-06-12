//
//  Cyc2018_swordOffer+位运算.swift
//  CommandLine
//
//  Created by unravel on 2022/5/10.
//

import Foundation
extension Cyc2018_swordOffer {
    class Cyc2018_swordOffer_BitOperation {
        // MARK: 二进制中 1 的个数
        // 思想:  n & (n - 1) 会将二进制中最右侧的1变为0
        func numberOf1In(n: Int) -> Int {
            var cnt = 0
            var mN = n
            while mN != 0 {
                mN &= (mN - 1)
                cnt += 1
            }
            return cnt
        }
        
        // MARK:  数组中只出现一次的数字
        // 思想：
        func findNumsAppearOnce(_ nums: [Int]) -> (Int, Int) {
            var bitmask = 0
            // 异或到最后，就相当于是那两个数字的异或
            for num in nums {
                bitmask ^= num
            }
            
            // x & -x 会将得到x中最右侧为1的位
            let diff = bitmask & (-bitmask)
            
            var res = (0, 0)
            
            for num in nums {
                if num & diff == 0 {
                    res.0 ^= num
                }
                else {
                    res.1 ^= num
                }
            }
            return res
        }
    }
}
