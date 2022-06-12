//
//  Cyc2018_swordOffer+DynamicPlan.swift
//  CommandLine
//
//  Created by unravel on 2022/2/28.
//

import Foundation
extension Cyc2018_swordOffer {
    class Cyc2018_swordOffer_DynamicPlan {
        var fibs = [0, 1]
        
        // MARK: 斐波那契数列
        func fibonacci1(_ n: Int) -> Int {
            if n <= 1 {
                return n
            }
            
            var fib = [Int](repeating: 0, count: n + 1)
            fib[1] = 1
            
            for i in 2...n {
                fib[i] = fib[i - 1] + fib[i - 2]
            }
            return fib[n]
        }
        
        func fibonacci2(_ n: Int) -> Int {
            if n <= 1 {
                return n
            }
            
            
            var pre2 = 0, pre1 = 1
            var fib = 0
            for _ in 2...n {
                fib = pre2 + pre1
                pre2 = pre1
                pre1 = fib
            }
            return fib
        }
        
        
        // 思想:  当前数为它之前两个数的和
        func fibonacci3(at n:Int) -> Int {
            // 类似于memory函数
            if n < fibs.count {
                return fibs[n]
            }
            else {
                // 进行扩容
                fibs += Array(repeating: 0, count: n + 1 - fibs.count)
            }
            
            var pre2 = 0, pre1 = 1
            var fib = 0
            for i in 2..<n {
                fib = pre2 + pre1
                pre2 = pre1
                pre1 = fib
                
                fibs[i] = fib
            }
            return fib
        }
        
        // MARK: 矩形覆盖
        // 思想:  和斐波那契数列一样，只是起始值不同
        func rectCover(_ n: Int) -> Int {
            if n <= 2 {
                return n
            }
            
            var pre2 = 1, pre1 = 2
            var result = 0
            for _ in 3...n {
                result = pre2 + pre1
                pre2 = pre1
                pre1 = result
                
            }
            return result
        }
        
        // MARK: 跳台阶
        func jumpFloor(_ n: Int) -> Int {
            if n <= 2 {
                return n
            }
            var pre2 = 1, pre1 = 2
            var result = 0
            for _ in 3...n {
                result = pre2 + pre1
                pre2 = pre1
                pre1 = result
                
            }
            return result
        }
        
        // MARK: 变态跳台阶
        func jumpFloor2(_ n: Int) -> Int {
            var dp = Array(repeating: 1, count: n)
            for i in 1..<n {
                for j in 0..<i {
                    dp[i] += dp[j]
                }
            }
            return dp[n - 1]
        }
        
        func jumpFloor22(_ n: Int) -> Int {
            return Int(pow(2, Double(n - 1)))
        }
        
        // MARK: 连续子数组的最大和
        func findGreatestSumOfSubArray(_ nums: [Int]) -> Int {
            return Cyc2018_leetcode.Think_Greed().maxSubArray(nums)
        }
        
        // MARK: 礼物的最大价值
        // 思想:  动态规划算法，说实在的动态规划我感觉我理解不太了，这是纯翻译的大神代码。以后有机会还得多研读
        func getMost(_ values: [[Int]]) -> Int {
            if values.count == 0 || values[0].count == 0 {
                return 0
            }
            
            let n = values[0].count
            var dp = Array<Int>(repeating: 0, count: n)
            
            for value in values {
                dp[0] += value[0]
                
                for j in 1..<n {
                    dp[j] = max(dp[j], dp[j - 1]) + value[j]
                }
            }
            return dp[n - 1]
        }
        
        // 这是leetcoder上棒棒的解法
        func getMost1(_ grid: [[Int]]) -> Int {
            return Cyc2018_leetcode.Think_DynamicPlan().minPathSum2(grid)
        }
        
        // MARK: 最长不含重复字符的子字符串长度
        // 因为swift中处理字符串比较麻烦，我们可以演变为一个整数数组中，最长的不包含相同数字的最长子数组长度
        func longestSubStringWithoutDuplication(_ nums: [Int]) -> Int {
            var curLen = 0, maxLen = 0
            var preIndexs = [Int](repeating: -1, count: 26)
            
            for curI in 0..<nums.count {
                let c = nums[curI]
                
                let preI = preIndexs[c]
                if preI == -1 || curI - preI > curLen {
                    curLen += 1
                }
                else {
                    maxLen = max(maxLen, curLen)
                    curLen = curI - preI
                }
                
                preIndexs[c] = curI
            }
            
            maxLen = max(maxLen, curLen)
            return maxLen
        }
        
        // MARK: 按从小到大的顺序的第 N 个丑数
        func getUglyNumber_Solution(_ n: Int) -> Int {
            if n <= 6 {
                return n
            }
            
            var i2 = 0, i3 = 0, i5 = 0
            var dp = Array<Int>(repeating: 0, count: n)
            dp[0] = 1
            
            for i in 1..<n {
                let next2 = dp[i2] * 2, next3 = dp[i3] * 3, next5 = dp[i5] * 5
                dp[i] = min(next2, next3, next5)
                
                if dp[i] == next2 {
                    i2 += 1
                }
                if dp[i] == next3 {
                    i3 += 1
                }
                if dp[i] == next5 {
                    i5 += 1
                }
            }
            return dp[n - 1]
        }
        
        // MARK: n 个骰子的点数
        // 思想： 其实这里没有看懂，只是照搬过来了
        func dicesSum(_ n: Int) -> [[Int:Double]] {
            let face = 6
            let pointNum = face * n
            // dp[i][j] 表示前 i 个骰子产生点数 j 的次数
            var dp = Array<[Int]>(repeating: Array<Int>(repeating: 0, count: pointNum + 1), count: n + 1)
            for i in 1...face {
                dp[1][i] = 1
            }
            // 使用几个筛子
            for i in 2...n {
                // 使用 i 个骰子最小点数为 i，点数范围
                for j in i...pointNum {
                    //
                    for k in 1...min(face, j) {
                        dp[i][j] += dp[i-1][j-k]
                    }
                }
            }
            
            let totalNum = pow(6, Double(n))
            var ret = [[Int:Double]]()
            for i in n...pointNum {
                ret.append([i:Double(dp[n][i])/totalNum])
            }
            return ret
        }
        
        func dicesSum2(_ n: Int) -> [[Int:Double]] {
            let face = 6
            let pointNum = face * n
            var dp = Array<[Int]>(repeating: Array<Int>(repeating: 0, count: pointNum + 1), count: n + 1)
            for i in 1...face {
                dp[1][i] = 1
            }
            /* 旋转标记 */
            var flag = 1
            for i in 2...n {
                for j in 0...pointNum {
                    // 旋转数组清零
                    dp[flag][j] = 0
                }
                for j in i...pointNum {
                    for k in 1...(min(j, face)) {
                        dp[flag][j] += dp[1 - flag][j - k]
                    }
                }
                
                flag = 1 - flag
            }
            let totalNum = Double(powf(6, Float(n)))
            var ret = [[Int:Double]]()
            for i in n...pointNum {
                ret.append([i:Double(dp[1-flag][i])/totalNum])
            }
            return ret
        }
        
        // MARK: 构建乘积数组
        func multiply(_ a: [Int]) -> [Int] {
            return Cyc2018_leetcode.Think_Math().productExceptSelf(a)
        }
    }
}
