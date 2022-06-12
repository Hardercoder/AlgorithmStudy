//
//  Cyc2018_leetcode+x.swift
//  CommandLine
//
//  Created by unravel on 2022/4/14.
//

import Foundation
extension Cyc2018_leetcode {
    // 递归和动态规划都是将原问题拆成多个子问题然后求解
    // 他们之间最本质的区别是，动态规划保存了子问题的解，避免重复计算
    class Think_DynamicPlan {
        // MARK: 斐波那契数列
        // MARK: 爬楼梯 dp[i] = dp[i - 1] + dp[i - 2]
        // https://leetcode-cn.com/problems/climbing-stairs/description/
        func climbStairs(_ n: Int) -> Int {
            if n <= 2 {
                return n
            }
            
            // 考虑到 dp[i] 只与 dp[i - 1] 和 dp[i - 2] 有关
            // 因此可以只用两个变量来存储 dp[i - 1] 和 dp[i - 2]，使得原来的 O(N) 空间复杂度优化为 O(1) 复杂度。
            // 前面倒数第二个，前面倒数第一个
            var pre2 = 1, pre1 = 2
            for _ in 2..<n {
                // dp[i] = dp[i - 1] + dp[i - 2]
                let cur = pre1 + pre2
                pre2 = pre1
                pre1 = cur
            }
            return pre1
        }
        
        // MARK: 强盗抢劫 dp[i] = max(dp[i - 2] + nums[i], dp[i - 1])
        // https://leetcode-cn.com/problems/house-robber/description/
        func rob(_ nums: [Int]) -> Int {
            var pre2 = 0, pre1 = 0
            for i in 0..<nums.count {
                // dp[i] = max(dp[i - 2] + nums[i], dp[i - 1])
                let cur = max(pre2 + nums[i], pre1)
                pre2 = pre1
                pre1 = cur
            }
            return pre1
        }
        
        // MARK: 强盗在环形街区抢劫
        // https://leetcode-cn.com/problems/house-robber-ii/description/
        func rob2(_ nums: [Int]) -> Int {
            // 一户也没有，直接返回0
            if nums.count == 0 {
                return 0
            }
            // 获取有多少户
            let n = nums.count
            // 只有一户，最大也就是这一户的钱
            if n == 1 {
                return nums[0]
            }
            // 盗窃从first到last用户的钱
            func rob(_ first: Int, _ last: Int) -> Int {
                if last < first {
                    return 0
                }
                
                var pre2 = 0, pre1 = 0
                for i in first...last {
                    // dp[i] = max(dp[i - 2] + nums[i], dp[i - 1])
                    let cur = max(pre2 + nums[i], pre1)
                    pre2 = pre1
                    pre1 = cur
                }
                return pre1
            }
            // 返回盗窃0到n-2和盗窃1到n-1的最大值
            return max(rob(0, n - 2), rob(1, n - 1))
        }
        
        // MARK: 信件错排 dp[i] = (i - 1) * dp[i - 2] + (i - 1) * dp[i - 1]
        // 答案不一定正确
        func errorEnvelopes(_ n: Int) -> Int {
            if n <= 1 {
                return 0
            }
            if n == 2 {
                return 1
            }
            // dp[i] = (i - 1) * dp[i - 2] + (i - 1) * dp[i - 1]
            var pre2 = 0, pre1 = 1
            for i in 2..<n {
                let cur = (i - 1) * pre2 + (i - 1) * pre1
                pre2 = pre1
                pre1 = cur
            }
            return pre1
        }
        
        // MARK: 母牛生产 dp[i] = dp[i - 1] + dp[i - 3]
        // 程序员代码面试指南-P181
        func cows(_ n: Int) -> Int {
            if n <= 3 {
                return n
            }
            // dp[i] = dp[i - 1] + dp[i - 3]
            return cows(n - 1) + cows(n - 3)
        }
        
        // MARK: 矩阵路径
        // MARK: 矩阵的最小路径和 dp[i][j] = min(dp[i - 1][j], dp[i][j - 1]) + grid[i][j]
        // https://leetcode-cn.com/problems/minimum-path-sum/description/
        // 答案对，但不好理解
        //        func minPathSum(_ grid: [[Int]]) -> Int {
        //            if grid.count == 0 ||
        //                grid[0].count == 0 {
        //                return 0
        //            }
        //            let m = grid.count, n = grid[0].count
        //            var dp = [Int](repeating: 0, count: n)
        //            for i in 0..<m {
        //                for j in 0..<n {
        //                    if j == 0 {
        //                        // 只能从上侧走到该位置
        //                        dp[j] = dp[j]
        //                    }
        //                    else if i == 0 {
        //                        // 只能从左侧走到该位置
        //                        dp[j] = dp[j - 1]
        //                    }
        //                    else {
        //                        dp[j] = min(dp[j - 1], dp[j])
        //                    }
        //                    dp[j] += grid[i][j]
        //                }
        //            }
        //            return dp[n - 1]
        //        }
        
        func minPathSum2(_ grid: [[Int]]) -> Int {
            if grid.count == 0 || grid[0].count == 0 { return 0 }
            let rows = grid.count, columns = grid[0].count
            var dp = [[Int]](repeating: [Int](repeating: 0, count: columns), count: rows)
            // 记录第一个值
            dp[0][0] = grid[0][0]
            // 初始化上面第一个行，从左到右依次累加
            for i in 1..<rows {
                dp[i][0] = dp[i - 1][0] + grid[i][0]
            }
            // 初始化左边第一列，从上到下依次累加
            for j in 1..<columns {
                dp[0][j] = dp[0][j - 1] + grid[0][j]
            }
            // 左边或者上边较小的一个值 + grid[i][j]
            for i in 1..<rows {
                for j in 1..<columns {
                    // 左边或者上边的一个较小值，累加grid中的当前值
                    dp[i][j] = min(dp[i - 1][j], dp[i][j - 1]) + grid[i][j]
                }
            }
            return dp[rows - 1][columns - 1]
        }
        
        // MARK: 矩阵的总路径数 dp[i][j] = dp[i - 1][j] + dp[i][j - 1]
        // https://leetcode-cn.com/problems/unique-paths/description/
        //        func uniquePaths(_ m: Int, _ n: Int) -> Int {
        //            var dp = [Int](repeating: 1, count: n)
        //            for _ in 1..<m {
        //                for j in 1..<n {
        //                    dp[j] = dp[j] + dp[j - 1]
        //                }
        //            }
        //            return dp[n - 1]
        //        }
        
        func uniquePaths2(_ m: Int, _ n: Int) -> Int {
            var dp = [[Int]](repeating: [Int](repeating: 0, count: n), count: m)
            // 从0.0走到i.0 只有垂直一条路径
            for i in 0..<m {
                dp[i][0] = 1
            }
            // 从0.0走到0.j 只有水平一条路径
            for j in 0..<n {
                dp[0][j] = 1
            }
            
            for i in 1..<m {
                for j in 1..<n {
                    dp[i][j] = dp[i - 1][j] + dp[i][j - 1]
                }
            }
            return dp[m - 1][n - 1]
        }
        
        func uniquePaths3(_ m: Int, _ n: Int) -> Int {
            let S = m + n - 2 // 总共的移动次数
            let D = m - 1 // 向下的移动次数
            var ret = 1
            for i in 1...D {
                ret = ret * (S - D + i) / i
            }
            return ret
        }
        
        // MARK: 数组区间
        // MARK: 数组区间和 total[i] = total[i - 1] + nums[i - 1]
        // https://leetcode-cn.com/problems/range-sum-query-immutable/description/
        class NumArray {
            private var total: [Int]
            init(_ nums: [Int]) {
                // 生成n+1个长度的数组，要存储0，0-1,0-2,0-n总计n+1个prefix的和
                total = [Int](repeating: 0, count: nums.count + 1)
                for i in 1...nums.count {
                    total[i] = total[i - 1] + nums[i - 1]
                }
            }
            
            func sumRange(_ left: Int, _ right: Int) -> Int {
                return total[right + 1] - total[left]
            }
        }
        
        // MARK: 数组中等差递增子区间的个数
        // https://leetcode-cn.com/problems/arithmetic-slices/description/
        func numberOfArithmeticSlices(_ nums: [Int]) -> Int {
            if nums.count < 2 {
                return 0
            }
            
            let n = nums.count
            var dp = [Int](repeating: 0, count: n)
            for i in 2..<n {
                // 如果是等差数列
                if nums[i] - nums[i - 1] == nums[i - 1] - nums[i - 2] {
                    dp[i] = dp[i - 1] + 1
                }
            }
            return dp.reduce(0) { $0 + $1 }
        }
        
        //        func numberOfArithmeticSlices2(_ nums: [Int]) -> Int {
        //            if nums.count < 2 {
        //                return 0
        //            }
        //            let n = nums.count
        //            var d = nums[0] - nums[1], t = 0
        //            var ans = 0
        //            for i in 2..<n {
        //                if nums[i - 1] - nums[i] == d {
        //                    t += 1
        //                }
        //                else {
        //                    t = 0
        //                    d = nums[i - 1] - nums[i]
        //                }
        //                ans += t
        //            }
        //            return ans
        //        }
        
        // MARK: 分割整数
        // MARK: 分割整数的最大乘积 curMax = max(curMax, max(j * dp[i - j], j * (i - j)))
        // https://leetcode-cn.com/problems/integer-break/description/
        func integerBreak(_ n: Int) -> Int {
            if n <= 3 {
                return n - 1
            }
            var dp = [Int](repeating: 0, count: n + 1)
            for i in 2...n {
                var curMax = 0
                for j in 1..<i {
                    // 一种拆分i-j，一种不拆分i-j
                    curMax = max(curMax, max(j * dp[i - j], j * (i - j)))
                }
                dp[i] = curMax
            }
            return dp[n]
        }
        
        func integerBreak2(_ n: Int) -> Int {
            if n <= 3 {
                return n - 1
            }
            let quotient = Double(n / 3), remainder = n % 3
            if remainder == 0 {
                return Int(pow(3, quotient))
            }
            else if remainder == 1 {
                return Int(pow(3, quotient - 1) * 4)
            }
            else {
                return Int(pow(3, quotient) * 2)
            }
        }
        
        // MARK: 按平方数来分割整数 minn = min(minn, dp[i - square] + 1)
        // https://leetcode-cn.com/problems/perfect-squares/description/
        //        func numSquares(_ n: Int) -> Int {
        //            var f = [Int](repeating: 0, count: n + 1)
        //
        //            for i in 1...n {
        //                var minn = Int.max
        //                var j = 1
        //                while j * j <= i {
        //                    minn = min(minn, f[i - j * j])
        //                    j += 1
        //                }
        //                f[i] = minn + 1
        //            }
        //            return f[n]
        //        }
        
        func numSquares2(_ n: Int) -> Int {
            // 生成小于n的所有可用的平方数
            func generateSquareList(_ n: Int) -> [Int] {
                var square = 1, diff = 3
                var squareList = [Int]()
                while square <= n {
                    squareList.append(square)
                    square += diff
                    diff += 2
                }
                return squareList
            }
            
            let squares = generateSquareList(n)
            var dp = [Int](repeating: 0, count: n + 1)
            for i in 1...n {
                var minn = Int.max
                for square in squares {
                    if square > i {
                        break
                    }
                    minn = min(minn, dp[i - square] + 1)
                }
                dp[i] = minn
            }
            return dp[n]
        }
        
        // MARK: 分割整数构成字母字符串
        // https://leetcode-cn.com/problems/decode-ways/description/
        func numDecodings(_ s: String) -> Int {
            if s.count == 0 {
                return 0
            }
            // 转换为数字数组
            let sChars = s.map { Int(String($0))! }, sCharsCount = sChars.count
            var dp = [Int](repeating: 0, count: sCharsCount + 1)
            // 空串视为有一种解决方案
            dp[0] = 1
            // 有一个字符且是字符'0',因为数字0没有对应的映射，所以返回0。其余的返回1
            dp[1] = sChars[0] == 0 ? 0 : 1
            
            if sCharsCount >= 2 {
                for i in 2...sCharsCount {
                    // 第一种情况，使用了一个字符
                    let one = sChars[i - 1]
                    if one != 0 {
                        dp[i] += dp[i - 1]
                    }
                    // 第二种情况，使用了两个字符
                    if sChars[i - 2] == 0 {
                        continue
                    }
                    let two = sChars[i-2] * 10 + sChars[i-1]
                    if two <= 26 {
                        dp[i] += dp[i - 2]
                    }
                }
            }
            return dp[sCharsCount]
        }
        
        // MARK: 最长递增子序列的长度 maxV = max(maxV, dp[j] + 1)
        // https://leetcode-cn.com/problems/longest-increasing-subsequence/description/
        func lengthOfLIS(_ nums: [Int]) -> Int {
            let n = nums.count
            var dp = [Int](repeating: 0, count: n)
            for i in 0..<n {
                // 自己至少算一条
                var maxV = 1
                let numI = nums[i]
                for j in 0..<i {
                    // 如果是nums[i]拼接到后面，还是可以构成一条递增子序列，那么dp[j] + 1
                    if numI > nums[j] {
                        maxV = max(maxV, dp[j] + 1)
                    }
                }
                dp[i] = maxV
            }
            return dp.max()!
        }
        
        // MARK: 一组整数对能够构成的最长链
        // https://leetcode-cn.com/problems/maximum-length-of-pair-chain/description/
        func findLongestChain(_ pairs: [[Int]]) -> Int {
            if pairs.count == 0 {
                return 0
            }
            // 按照区间头升序排序
            let pairs = pairs.sorted { a, b in
                a[0] < b[0]
            }, n = pairs.count
            var dp = [Int](repeating: 1, count: n)
            for i in 1..<n {
                let preHead = pairs[i][0]
                var maxV = 1
                for j in 0..<i {
                    // 如果j的尾小于preHead
                    if preHead > pairs[j][1] {
                        maxV = max(maxV, dp[j] + 1)
                    }
                }
                dp[i] = maxV
            }
            return dp.max()!
        }
        // 贪心算法
        //        func findLongestChain2(_ pairs: [[Int]]) -> Int {
        //            let pairs = pairs.sorted { a, b in
        //                a[1] < b[1]
        //            }
        //            var cur = Int.min, ans = 0
        //            for pair in pairs {
        //                if cur < pair[0] {
        //                    cur = pair[1]
        //                    ans += 1
        //                }
        //            }
        //            return ans
        //        }
        
        // MARK: 最长摆动子序列
        // https://leetcode-cn.com/problems/wiggle-subsequence/description/
        func wiggleMaxLength(_ nums: [Int]) -> Int {
            let n = nums.count
            if n < 2 {
                return n
            }
            var up = 1, down = 1
            for i in 1..<n {
                if nums[i] > nums[i - 1] {
                    up = down + 1
                }
                else if nums[i] < nums[i - 1] {
                    down = up + 1
                }
            }
            return max(up, down)
        }
        
        // MARK: 最长公共子序列
        // https://leetcode-cn.com/problems/longest-common-subsequence/
        func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
            let chars1 = Array(text1),
                chars1Count = chars1.count,
                chars2 = Array(text2),
                chars2Count = chars2.count
            var dp = [[Int]](repeating: [Int](repeating: 0,
                                              count: chars2Count + 1),
                             count: chars1Count + 1)
            for i in 1...chars1Count {
                for j in 1...chars2Count {
                    // 相同时，等于[i-1][j-1] + 1
                    if chars1[i - 1] == chars2[j - 1] {
                        dp[i][j] = dp[i-1][j-1] + 1
                    }
                    else {
                        // 不同时，取[i-1][j],[i][j-1]较大值
                        dp[i][j] = max(dp[i-1][j], dp[i][j-1])
                    }
                }
            }
            return dp[chars1Count][chars2Count]
        }
        
        // MARK: 0-1 背包
        // W 为背包总体积
        // N 为物品数量
        // weights 数组存储N个物品的重量
        // values 数组存储N个物品的价值
        func knapsack(_ W: Int,
                      _ N: Int,
                      _ weights: [Int],
                      _ values: [Int]) -> Int {
            var dp = [[Int]](repeating: [Int](repeating: 0, count: W + 1), count: N + 1)
            for i in 1...N {
                let w = weights[i - 1], v = values[i - 1]
                for j in 1...W {
                    if j >= w {
                        // 第 i 件物品添加到背包中，dp[i][j] = dp[i-1][j-w] + v
                        dp[i][j] = max(dp[i-1][j], dp[i-1][j-w] + v)
                    }
                    else {
                        // 第 i 件物品没添加到背包，总体积不超过 j 的前 i 件物品的最大价值就是总体积不超过 j 的前 i-1 件物品的最大价值，dp[i][j] = dp[i-1][j]
                        dp[i][j] = dp[i-1][j]
                    }
                }
            }
            return dp[N][W]
        }
        
        func knapsack2(_ W: Int,
                       _ N: Int,
                       _ weights: [Int],
                       _ values: [Int]) -> Int {
            /**
             前 i 件物品的状态仅与前 i-1 件物品的状态有关，因此可以将 dp 定义为一维数组，
             其中 dp[j] 既可以表示 dp[i-1][j] 也可以表示 dp[i][j]
             */
            var dp = [Int](repeating: 0, count: W + 1)
            for i in 1...N {
                let w = weights[i - 1], v = values[i - 1]
                for j in 1...W {
                    if j >= w {
                        dp[j] = max(dp[j], dp[j-w] + v)
                    }
                }
            }
            return dp[W]
        }
        
        // MARK: 划分数组为和相等的两部分
        // https://leetcode-cn.com/problems/partition-equal-subset-sum/description/
        func canPartition(_ nums: [Int]) -> Bool {
            // 划分为相等的两部分，那么总和一定是偶数
            let totalSum = nums.reduce(0) { $0 + $1 }
            if totalSum % 2 != 0 {
                return false
            }
            // 分半
            let W = totalSum / 2
            var dp = [Bool](repeating: false, count: W + 1)
            dp[0] = true
            // 遍历数组进行处理
            for num in nums {
                // 0 - 1 背包，一个物品只能使用一次，这里指的是num
                // j 从W -- 直到 num
                var j = W
                while j >= num {
                    // 从后往前，先计算dp[j]再计算dp[j-num]
                    dp[j] = dp[j] || dp[j-num]
                    j -= 1
                }
            }
            return dp[W]
        }
        
        // MARK: 改变一组数的正负号使得它们的和为一给定数
        // https://leetcode-cn.com/problems/target-sum/description/
        // 因此只要找到一个子集，令它们都取正号，并且和等于 (target + sum(nums))/2，就证明存在解。
        // 使用动态规划解法，不对
        //        func findTargetSumWays(_ nums: [Int], _ target: Int) -> Int {
        //            let totalSum = nums.reduce(0) { $0 + $1 }
        //            if totalSum < target || (target + totalSum) % 2 == 1 {
        //                return 0
        //            }
        //            let W = (totalSum + target) / 2
        //            var dp = [Int](repeating: 0, count: W + 1)
        //            dp[0] = 1
        //            for num in nums {
        //                var j = W
        //                while j >= num {
        //                    // 从后往前，先计算dp[j]再计算dp[j-num]
        //                    dp[j] = dp[j] + dp[j-num]
        //                    j -= 1
        //                }
        //            }
        //            return dp[W]
        //        }
        func findTargetSumWays(_ nums: [Int], _ target: Int) -> Int {
            let totalSum = nums.reduce(0) { $0 + $1 }
            let diff = totalSum - target
            if diff < 0 || diff % 2 != 0 {
                return 0
            }
            let neg = diff / 2
            var dp = [Int](repeating: 0, count: neg + 1)
            dp[0] = 1
            for num in nums {
                var j = neg
                while j >= num {
                    dp[j] = dp[j] + dp[j-num]
                    j -= 1
                }
            }
            return dp[neg]
        }
        
        // 回溯
        func findTargetSumWays2(_ nums: [Int], _ target: Int) -> Int {
            var count = 0
            func findTargetSumWays(_ index: Int, _ sum: Int) {
                if index == nums.count {
                    if sum == target {
                        count += 1
                    }
                    return
                }
                let indexVal = nums[index]
                findTargetSumWays(index + 1, sum + indexVal)
                findTargetSumWays(index + 1, sum - indexVal)
            }
            findTargetSumWays(0, 0)
            return count
        }
        
        // MARK: 01 字符构成最多的字符串
        // https://leetcode-cn.com/problems/ones-and-zeroes/description/
        func findMaxForm(_ strs: [String], _ m: Int, _ n: Int) -> Int {
            if strs.count == 0 {
                return 0
            }
            var dp = [[Int]](repeating: [Int](repeating: 0, count: n + 1), count: m + 1)
            // 转换为character数组
            let strs = strs.map { Array($0) }
            for s in strs {
                // 对0和1进行计数
                var ones = 0, zeros = 0
                for c in s {
                    if c == "0" {
                        zeros += 1
                    }
                    else {
                        ones += 1
                    }
                }
                if m >= zeros && n >= ones {
                    for i in (zeros...m).reversed() {
                        for j in (ones...n).reversed() {
                            dp[i][j] = max(dp[i][j], dp[i-zeros][j-ones] + 1)
                        }
                    }
                }
            }
            return dp[m][n]
        }
        
        // MARK: 找零钱的最少硬币数
        // https://leetcode-cn.com/problems/coin-change/description/
        func coinChange(_ coins: [Int], _ amount: Int) -> Int {
            if amount == 0 || coins.count == 0 {
                return 0
            }
            var dp = [Int](repeating: 0, count: amount + 1)
            for coin in coins {
                // 将逆序遍历改为正序遍历
                if amount >= coin {
                    for i in coin...amount {
                        if i == coin {
                            dp[i] = 1
                        }
                        else if dp[i] == 0 && dp[i-coin] != 0 {
                            dp[i] = dp[i-coin] + 1
                        }
                        else if dp[i-coin] != 0 {
                            dp[i] = min(dp[i], dp[i-coin] + 1)
                        }
                    }
                }
            }
            return dp[amount] == 0 ? -1 : dp[amount]
        }
        
        // MARK: 找零钱的硬币数组合
        // https://leetcode-cn.com/problems/coin-change-2/description/
        func change(_ amount: Int, _ coins: [Int]) -> Int {
            var dp = [Int](repeating: 0, count: amount + 1)
            dp[0] = 1
            for coin in coins {
                if amount >= coin {
                    for i in coin...amount {
                        dp[i] += dp[i-coin]
                    }
                }
            }
            return dp[amount]
        }
        // MARK: 字符串按单词列表分割
        // https://leetcode-cn.com/problems/word-break/description/
        func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
            let sChars = Array(s), sCharsCount = sChars.count
            var dp = [Bool](repeating: false, count: sCharsCount + 1)
            dp[0] = true
            for i in 1...sCharsCount {
                for word in wordDict {
                    let len = word.count
                    if len <= i && word == String(sChars[(i-len)..<i]) {
                        dp[i] = dp[i] || dp[i-len]
                    }
                }
            }
            return dp[sCharsCount]
        }
        
        // MARK: 组合总和
        // https://leetcode-cn.com/problems/combination-sum-iv/description/
        func combinationSum4(_ nums: [Int], _ target: Int) -> Int {
            if nums.count == 0 {
                return 0
            }
            var maximum = [Int](repeating: 0, count: target + 1)
            maximum[0] = 1
            let nums = nums.sorted()
            for i in 1...target {
                for num in nums {
                    if num <= i {
                        maximum[i] &+= maximum[i - num]
                    }
                    else {
                        break
                    }
                }
            }
            return maximum[target]
        }
        
        // MARK: 股票交易
        // https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock-with-cooldown/description/
        
        // MARK: 需要冷却期的股票交易
        // https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock-with-cooldown/description/
        func maxProfit1(_ prices: [Int]) -> Int {
            if prices.count == 0 {
                return 0
            }
            let N = prices.count
            var buy = [Int](repeating: 0, count: N)
            var s1 = [Int](repeating: 0, count: N)
            var sell = [Int](repeating: 0, count: N)
            var s2 = [Int](repeating: 0, count: N)
            
            buy[0] = -prices[0]
            s1[0] = buy[0]
            
            s2[0] = 0
            sell[0] = s2[0]
            
            if N > 0 {
                for i in 1..<N {
                    buy[i] = s2[i-1] - prices[i]
                    s1[i] = max(buy[i-1], s1[i-1])
                    sell[i] = max(buy[i-1], s1[i-1]) + prices[i]
                    s2[i] = max(s2[i-1], sell[i-1])
                }
            }
            return max(sell[N-1], s2[N-1])
        }
        
        func maxProfit1_1(_ prices: [Int]) -> Int {
            let n = prices.count
            if n <= 1 {
                return 0
            }
            var dp = [[Int]](repeating: [Int](repeating: 0, count: 3), count: n)
            // dp[i][0] 不持股且当前没卖出的最大收益
            dp[0][0] = 0
            // dp[i][1] 持股的最大收益
            dp[0][1] = -prices[0]
            // 不持股且当天卖出的最大收益
            dp[0][2] = 0
            for i in 1..<n {
                // 我今天 不是因为卖股票才没股票，是因为昨天有股票且卖了或者昨天也没股票
                // 所以总的利润是 昨天不持有股票的利润和昨天有股票但是卖了，他俩的较大值
                dp[i][0] = max(dp[i-1][0], dp[i-1][2])
                // 我今天有股票，是因为昨天有股票或者今天买了股票
                // 所以总的利润是 昨天持有的股票的利润与昨天没有股票的利润-今天买股票花的钱，他俩的较大值
                dp[i][1] = max(dp[i-1][1], dp[i-1][0] - prices[i])
                // 我今天 是因为卖股票卖才没股票
                // 所以总的利润是 昨天持有股票的利润+今天卖的钱
                dp[i][2] = dp[i-1][1] + prices[i]
            }
            // 不持股状态的最大值
            return max(dp[n-1][0], dp[n-1][2])
        }
        
        func maxProfit1_2(_ prices: [Int]) -> Int {
            let n = prices.count
            if n <= 1 {
                return 0
            }
            
            // dp[i][0] 不持股且当前没卖出的最大收益
            var f0 = 0
            // dp[i][1] 持股的最大收益
            var f1 = -prices[0]
            // 不持股且当天卖出的最大收益
            var f2 = 0
            for i in 1..<n {
                // 我今天 不是因为卖股票才没股票，是因为昨天有股票且卖了或者昨天也没股票
                // 所以总的利润是 昨天不持有股票的利润和昨天有股票但是卖了，他俩的较大值
                let nF0 = max(f0, f2)
                // 我今天有股票，是因为昨天有股票或者今天买了股票
                // 所以总的利润是 昨天持有的股票的利润与昨天没有股票的利润-今天买股票花的钱，他俩的较大值
                let nF1 = max(f1, f0 - prices[i])
                // 我今天 是因为卖股票卖才没股票
                // 所以总的利润是 昨天持有股票的利润+今天卖的钱
                let nF2 = f1 + prices[i]
                f0 = nF0
                f1 = nF1
                f2 = nF2
            }
            // 不持股状态的最大值
            return max(f0, f2)
        }
        
        // MARK: 需要交易费用的股票交易
        // https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock-with-transaction-fee/description/
        func maxProfit2(_ prices: [Int], _ fee: Int) -> Int {
            if prices.count == 0 {
                return 0
            }
            let N = prices.count
            var buy = [Int](repeating: 0, count: N)
            var s1 = [Int](repeating: 0, count: N)
            var sell = [Int](repeating: 0, count: N)
            var s2 = [Int](repeating: 0, count: N)
            
            buy[0] = -prices[0]
            s1[0] = buy[0]
            
            s2[0] = 0
            sell[0] = s2[0]
            
            if N > 0 {
                for i in 1..<N {
                    buy[i] = max(sell[i-1], s2[i-1]) - prices[i]
                    s1[i] = max(buy[i-1], s1[i-1])
                    sell[i] = max(buy[i-1], s1[i-1]) - fee + prices[i]
                    s2[i] = max(s2[i-1], sell[i-1])
                }
            }
            return max(sell[N-1], s2[N-1])
        }
        
        func maxProfit2_1(_ prices: [Int], _ fee: Int) -> Int {
            let n = prices.count
            if n <= 1 {
                return 0
            }
            var dp = [[Int]](repeating: [Int](repeating: 0, count: 2), count: n)
            // dp[i][0] 不持股的最大收益
            dp[0][0] = 0
            // dp[i][1] 持股的最大收益
            dp[0][1] = -prices[0]
            for i in 1..<n {
                // 我今天不持股
                // 所以总的利润是 昨天不持有股票的利润和昨天有股票但是今天卖了，他俩的较大值
                dp[i][0] = max(dp[i-1][0], dp[i-1][1] + prices[i] - fee)
                // 我今天持股
                // 所以总的利润是 昨天持有的股票的利润与昨天没有股票的利润-今天买股票花的钱，他俩的较大值
                dp[i][1] = max(dp[i-1][1], dp[i-1][0] - prices[i])
            }
            // 不持股状态的最大值
            return dp[n-1][0]
        }
        
        func maxProfit2_2(_ prices: [Int], _ fee: Int) -> Int {
            let n = prices.count
            if n <= 1 {
                return 0
            }
            var sell = 0, buy = -prices[0]
            for i in 1..<n {
                // 今天卖股票的利润 = 昨天已卖股票的利润和昨天买的股票的利润+今天卖的钱 他俩的较大值
                sell = max(sell, buy + prices[i] - fee)
                // 今天买股票的利润 = 昨天已买股票的利润和昨天已卖掉股票的利润-今天要买股票的钱  他俩的较大值
                buy = max(buy, sell - prices[i])
            }
            return sell
        }
        
        // MARK: 只能进行两次的股票交易
        // https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock-iii/description/
        func maxProfit3(_ prices: [Int]) -> Int {
            var firstBuy = Int.min, firstSell = 0
            var secondBuy = Int.min, secondSell = 0
            for curPrice in prices {
                if firstBuy < -curPrice {
                    firstBuy = -curPrice
                }
                if firstSell < firstBuy + curPrice {
                    firstSell = firstBuy + curPrice
                }
                
                if secondBuy < firstSell - curPrice {
                    secondBuy = firstSell - curPrice
                }
                if secondSell < secondBuy + curPrice {
                    secondSell = secondBuy + curPrice
                }
            }
            return secondSell
        }
        
        func maxProfit3_1(_ prices: [Int]) -> Int {
            // 第一次买入状态，第一个卖出状态
            var firstBuy = Int.min, firstSell = 0
            // 第二次买入状态，第二次卖出状态
            var secondBuy = Int.min, secondSell = 0
            for curPrice in prices {
                // 怎么变为第一次买入状态呢
                // 1. 保持昨天首次买入状态不变
                // 2. 之前什么操作也没有，今天首次买入
                firstBuy = max(firstBuy, -curPrice)
                // 怎么变为首次卖出状态呢
                // 1. 保持昨天首次卖出状态不变
                // 2. 昨天买的，今天卖
                firstSell = max(firstSell, firstBuy + curPrice)
                // 怎么变为第二次买入状态呢
                // 1. 保持昨天第二次买入状态不变
                // 2. 昨天卖出，今天买入
                secondBuy = max(secondBuy, firstSell - curPrice)
                // 怎么变成第二次卖出状态呢
                // 1. 保持昨天第二次卖出状态不变
                // 2. 昨天买的，今天卖
                secondSell = max(secondSell, secondBuy + curPrice)
            }
            return secondSell
        }
        
        // MARK: 只能进行 k 次的股票交易
        // https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock-iv/description/
        func maxProfit4(_ k: Int, _ prices: [Int]) -> Int {
            let n = prices.count
            if n <= 1 {
                return 0
            }
            if k >= n / 2 {
                // 这种情况下，该问题退化为普通的股票交易问题
                var maxProfit = 0
                for i in 1..<n {
                    if prices[i] > prices[i-1] {
                        maxProfit += prices[i] - prices[i-1]
                    }
                }
                return maxProfit
            }
            var maxProfitValue = [[Int]](repeating: [Int](repeating: 0, count: n), count: k + 1)
            if k >= 1 {
                for i in 1...k {
                    var localMax = maxProfitValue[i-1][0] - prices[0]
                    for j in 1..<n {
                        maxProfitValue[i][j] = max(maxProfitValue[i][j-1], prices[j] + localMax)
                        localMax = max(localMax, maxProfitValue[i-1][j] - prices[j])
                    }
                }
            }
            return maxProfitValue[k][n-1]
        }
        
        func maxProfit4_1(_ k: Int, _ prices: [Int]) -> Int {
            let n = prices.count
            if n <= 1 {
                return 0
            }
            // 因为一次交易至少涉及两天，所以如果k大于总天数的一半，就直接取天数一半即可，多余的交易次数是无意义的
            let kCnt = min(k, n / 2)
            /*
             dp定义：dp[i][j][k]代表 第i天交易了k次时的最大利润，其中j代表当天是否持有股票，0不持有，1持有
             */
            var dp = [[[Int]]](repeating: [[Int]](repeating: [Int](repeating: 0, count: kCnt + 1), count: 2), count: n)
            for k in 0...kCnt {
                dp[0][0][k] = 0
                dp[0][1][k] = -prices[0]
            }
            
            /*状态方程：
             dp[i][0][k]，当天不持有股票时，看前一天的股票持有情况
             dp[i][1][k]，当天持有股票时，看前一天的股票持有情况
             */
            if n > 1 && kCnt >= 1 {
                for i in 1..<n {
                    for k in 1...kCnt {
                        dp[i][0][k] = max(dp[i-1][0][k], dp[i-1][1][k] + prices[i])
                        dp[i][1][k] = max(dp[i-1][1][k], dp[i-1][0][k-1] - prices[i])
                    }
                }
            }
            return dp[n-1][0][kCnt]
        }
        
        // MARK: 删除两个字符串的字符使它们相等
        // https://leetcode-cn.com/problems/delete-operation-for-two-strings/description/
        // 可以转换为求两个字符串的最长公共子序列问题。
        func minDistance(_ word1: String, _ word2: String) -> Int {
            let chars1 = Array(word1),
                chars1Count = chars1.count,
                chars2 = Array(word2),
                chars2Count = chars2.count
            var dp = [[Int]](repeating: [Int](repeating: 0,
                                              count: chars2Count + 1),
                             count: chars1Count + 1)
            for i in 1...chars1Count {
                for j in 1...chars2Count {
                    // 相同时，等于[i-1][j-1] + 1
                    if chars1[i - 1] == chars2[j - 1] {
                        dp[i][j] = dp[i-1][j-1] + 1
                    }
                    else {
                        // 不同时，取[i-1][j],[i][j-1]较大值
                        dp[i][j] = max(dp[i-1][j], dp[i][j-1])
                    }
                }
            }
            return chars1Count + chars2Count - 2 * dp[chars1Count][chars2Count]
        }
        
        // MARK: 编辑距离
        // https://leetcode-cn.com/problems/edit-distance/description/
        func minDistance2(_ word1: String, _ word2: String) -> Int {
            let aChars = [Character](word1), aLen = aChars.count
            let bChars = [Character](word2), bLen = bChars.count
            
            var dp = Array(repeating: Array(repeating: 0,
                                            count: bLen + 1),
                           count: aLen + 1)
            // 第一行
            if aLen > 0 {
                for x in 1...aLen {
                    dp[x][0] = dp[x-1][0] + 1
                }
            }
            
            // 第一列
            if bLen > 0 {
                for y in 1...bLen {
                    dp[0][y] = dp[0][y-1] + 1
                }
            }
            
            if aLen > 0 && bLen > 0 {
                for x in 1...aLen {
                    for y in 1...bLen {
                        if aChars[x - 1] == bChars[y - 1] {
                            dp[x][y] = dp[x - 1][y - 1]
                        }
                        else {
                            dp[x][y] = min(dp[x-1][y-1], dp[x-1][y], dp[x][y-1]) + 1
                        }
                    }
                }
            }
            return dp[aLen][bLen]
        }
        
        // MARK: 复制粘贴字符
        // https://leetcode-cn.com/problems/2-keys-keyboard/description/
        // 分解质因数
        func minSteps(_ n: Int) -> Int {
            var ans = 0, i = 2, mutN = n
            while i * i <= mutN {
                while mutN % i == 0 {
                    mutN /= i
                    ans += i
                }
                i += 1
            }
            if mutN > 1 {
                ans += mutN
            }
            return ans
        }
        
        // 动态规划
        //        func minSteps2(_ n: Int) -> Int {
        //            var dp = [Int](repeating: 0, count: n + 1)
        //            let h = Int(sqrt(Double(n)))
        //            for i in 2...n {
        //                dp[i] = i
        //                var j = 2
        //                while j <= h {
        //                    if i % j == 0 {
        //                        dp[i] = dp[j] + dp[i / j]
        //                    }
        //                    j += 1
        //                }
        //            }
        //            return dp[n]
        //        }
    }
}
