//
//  Cyc2018_swordOffer+数学.swift
//  CommandLine
//
//  Created by unravel on 2022/5/10.
//

import Foundation
extension Cyc2018_swordOffer {
    class Cyc2018_swordOffer_Math {
        // MARK: 数组中出现次数超过一半的数字
        // 思想:  计数一个数最大的出现次数，相同加1不同减1，为0时就换数字
        func moreThanHalfNum_Solution(_ nums: [Int]) -> Int {
            return Cyc2018_leetcode.Think_Math().majorityElement(nums)
        }
        
        // MARK: 圆圈中最后剩下的数
        // https://leetcode.cn/problems/yuan-quan-zhong-zui-hou-sheng-xia-de-shu-zi-lcof/
        // 思想:  约瑟夫环问题
        func lastRemaining(_ n: Int, _ m: Int) -> Int {
            // 特殊输入的处理，没有人的时候就找不到最后一个剩下的人
            if n == 0 {
                return -1
            }
            
            // 递归返回条件，只有一个人的时候，说明返回的就是这个人，又由于人是从0开始增的，所以第一个人是0
            if n == 1 {
                return 0
            }
            
            return (lastRemaining(n-1, m) + m) % n
        }
        
        func lastRemaining2(_ n: Int, _ m: Int) -> Int {
            // 特殊输入的处理，没有人的时候就找不到最后一个剩下的人
            if n == 0 {
                // 一个没有人时的默认返回值，可以是-1，也可以是-999或任何约定好的数字
                return -1
            }
            
            // 递归返回条件，只有一个人的时候，说明返回的就是这个人，又由于人是从0开始增的，所以第一个人是0
            if n == 1 {
                return 0
            }
            
            var last = 0
            // 最后一轮剩下2个人，所以从2开始反推
            for i in 2...n {
                last = (last + m) % i
            }
            return last
        }
        
        // MARK: 从 1 到 n 整数中 1 出现的次数
        // 思想: 按照个位、十位、百位上的1来计算出现的1的个数
        func numberOf1Between1AndN_Solution(_ n: Int) -> Int {
            var cnt = 0
            var digit = 1
            while digit <= n {
                let high = n / digit, reminder = n % digit
                cnt += (high + 8) / 10 * digit + (high % 10 == 1 ? reminder + 1 : 0)
                
                digit *= 10
            }
            return cnt
        }
    }
}
