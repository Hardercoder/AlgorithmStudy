//
//  Cyc2018_leetcode+x.swift
//  CommandLine
//
//  Created by unravel on 2022/4/14.
//

import Foundation
extension Cyc2018_leetcode {
    // 思想之贪心思想
    // 保证每次操作都是局部最优的，并且最后得到的结果是全局最优的
    class Think_Greed {
        // MARK: 分配饼干
        // https://leetcode-cn.com/problems/assign-cookies/description/
        // 题目中应该是有个隐性条件，一个孩子只能分配一个饼干
        // 同时对小孩和饼干升序排序，排完序后，遍历饼干，从最小的孩子开始满足
        func findContentChildren(_ g: [Int], _ s: [Int]) -> Int {
            if g.count == 0 || s.count == 0 {
                return 0
            }
            
            // 对孩子和饼干进行升序排序
            let mGrid = g.sorted(), mGridCount = mGrid.count
            let mSize = s.sorted(), mSizeCount = mSize.count
            
            var gi = 0, si = 0
            // 遍历孩子和饼干，找到能满足孩子的最小饼干
            while gi < mGridCount && si < mSizeCount {
                if mGrid[gi] <= mSize[si] {
                    gi += 1
                }
                si += 1
            }
            return gi
        }
        
        // MARK: 计算让一组区间不重叠所需要移除的区间个数
        // https://leetcode-cn.com/problems/non-overlapping-intervals/description/
        // 按照区间尾进行升序排序，然后从第一个开始遍历，找不重合的区间，然后做差法
        /*
         ------------------------------------------------------
         -----
         -----------
         -------------
         -------------------------
         -------
         -------
         ----
         */
        // 找不重合区间：只需要找start >= 最小end的就可以，同时更新最小end。
        func eraseOverlapIntervals(_ intervals: [[Int]]) -> Int {
            if intervals.count == 0 {
                return 0
            }
            // 按区间的结尾进行排序
            let mIntervals = intervals.sorted { arr1, arr2 -> Bool in
                return arr1[1] < arr2[1]
            }
            
            var cnt = 1
            var end = mIntervals.first![1]
            // 从第一个开始，每次选择结尾最小，并且和前一个区间不重叠的区间。
            for interval in mIntervals.dropFirst() {
                if interval[0] < end {
                    continue
                }
                end = interval[1]
                cnt += 1
            }
            return mIntervals.count - cnt
        }
        
        // MARK: 投飞镖刺破气球，和上面的一题很相似
        // https://leetcode-cn.com/problems/minimum-number-of-arrows-to-burst-balloons/description/
        func findMinArrowShots(_ points: [[Int]]) -> Int {
            if points.count == 0 {
                return 0
            }
            
            let mPoints = points.sorted { arr1, arr2 -> Bool in
                return arr1[1] < arr2[1]
            }
            
            var cnt = 1
            var end = mPoints.first![1]
            for point in mPoints.dropFirst() {
                if point[0] <= end {
                    continue
                }
                end = point[1]
                cnt += 1
            }
            return cnt
        }
        
        // MARK: 根据身高和序号重组队列
        // https://leetcode-cn.com/problems/queue-reconstruction-by-height/description/
        func reconstructQueue(_ people: [[Int]]) -> [[Int]] {
            if people.count == 0 {
                return people
            }
            
            // 身高 h 降序、个数 k 值升序
            let mSortedPeople = people.sorted { firstP, secondP -> Bool in
                if firstP[0] == secondP[0] {
                    return firstP[1] < secondP[1]
                }
                else {
                    return firstP[0] > secondP[0]
                }
            }
            
            // 然后将某个学生插入队列的第 k 个位置中
            var queue = Array<[Int]>()
            for p in mSortedPeople {
                queue.insert(p, at: p[1])
            }
            
            return queue
        }
        
        // MARK: 买卖股票最大的收益
        // https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock/description/
        // 只要记录前面的最小价格，将这个最小价格作为买入价格，然后将当前的价格作为售出价格，查看当前收益是不是最大收益。
        func maxProfit(_ prices: [Int]) -> Int {
            if prices.count == 0 {
                return 0
            }
            var soFarMin = prices[0]
            var maxProfit = 0
            for i in 1..<prices.count {
                if soFarMin > prices[i] {
                    // 至今为止最小的波谷
                    soFarMin = prices[i]
                }
                else {
                    // 至今为止最大的波峰
                    maxProfit = max(maxProfit, prices[i] - soFarMin)
                }
            }
            return maxProfit
        }
        
        // MARK: 买卖股票的最大收益 II
        // https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock-ii/description/
        // 对于 [a, b, c, d]，如果有 a <= b <= c <= d ，那么最大收益为 d - a。而 d - a = (d - c) + (c - b) + (b - a)
        // 因此当访问到一个 prices[i] 且 prices[i] - prices[i-1] > 0，那么就把 prices[i] - prices[i-1] 添加到收益中。
        func maxProfit2(_ prices: [Int]) -> Int {
            var profit = 0
            for i in 1..<prices.count {
                // 只要有得赚，就可以累计
                let mProfit = prices[i] - prices[i - 1]
                if mProfit > 0 {
                    profit += mProfit
                }
            }
            return profit
        }
        
        // MARK: 种植花朵
        // https://leetcode-cn.com/problems/can-place-flowers/description/
        // flowerbed 数组中 1 表示已经种下了花朵。花朵之间至少需要一个单位的间隔，求解是否能种下 n 朵花。
        func canPlaceFlowers(_ flowerbed: [Int], _ n: Int) -> Bool {
            var mFlowerbed = flowerbed
            let len = mFlowerbed.count
            var cnt = 0
            for i in 0..<len {
                if flowerbed[i] == 1 {
                    continue
                }
                let pre = i == 0 ? 0 : mFlowerbed[i - 1]
                let next = i == len - 1 ? 0 : mFlowerbed[i + 1]
                if pre == 0 && next == 0 {
                    cnt += 1
                    mFlowerbed[i] = 1
                }
            }
            return cnt >= n
        }
        
        // MARK: 判断是否为子序列
        // https://leetcode-cn.com/problems/is-subsequence/description/
        func isSubsequence(_ s: String, _ t: String) -> Bool {
            let targetChars = Array(t),
                sChars = Array(s),
                targetCharsCount = targetChars.count,
                sCharsCount = sChars.count
            
            var i = 0, j = 0
            while i < sCharsCount && j < targetCharsCount {
                if sChars[i] == targetChars[j] {
                    i += 1
                }
                j += 1
            }
            return i == sCharsCount
        }
        
        // MARK: 判断一个数组是否能只修改一个数就成为非递减数组
        // https://leetcode-cn.com/problems/non-decreasing-array/description/
        func checkPossibility(_ nums: [Int]) -> Bool {
            var cnt = 1
            var mNums = nums
            for i in 1..<mNums.count {
                // 如果这个数比前面一个数要小，那么需要进行调换
                if mNums[i] < mNums[i - 1] {
                    // cnt记录可调换的次数，调换一次减一
                    if cnt == 0 {
                        return false
                    }
                    cnt -= 1
                    // 如果这个数比前面倒数第二个数还要小
                    if i >= 2 && mNums[i] < mNums[i - 2] {
                        // 只能把前一个数赋值到这个数，否则调换之后，它还是比倒是第二个数小
                        mNums[i] = mNums[i - 1]
                    }
                    else {
                        mNums[i - 1] = mNums[i]
                    }
                }
            }
            return true
        }
        
        // MARK: 子数组最大的和
        // https://leetcode-cn.com/problems/maximum-subarray/description/
        func maxSubArray(_ nums: [Int]) -> Int {
            if nums.count == 0 {
                return 0
            }
            
            var preSum = nums[0]
            var maxSum = preSum
            
            for i in 1..<nums.count {
                preSum = preSum > 0 ? preSum + nums[i] : nums[i]
                maxSum = max(maxSum, preSum)
            }
            return maxSum
        }
        
        // MARK: 分隔字符串使同种字符出现在一起
        // https://leetcode-cn.com/problems/partition-labels/description/
        func partitionLabels(_ s: String) -> [Int] {
            // ababcbacadefegdehijhklij
            let sChars = Array(s)
            // 存放字母和它的最远位置
            var maxPos = [Character: Int]()
            for (index, c) in sChars.enumerated() {
                maxPos[c] = index
            }
            
            var partitions = [Int]()
            // 待切割的起始位置
            var start = 0
            // 已扫描的字符中最远的位置
            var scannedCharMaxPos = 0
            for i in 0..<sChars.count {
                // 当前扫描的字符的最远位置，每一轮curCharMaxPos肯定比上一轮大
                let curCharMaxPos = maxPos[sChars[i]]!
                // 更新【已扫描的字符中最远的位置]
                scannedCharMaxPos = max(scannedCharMaxPos, curCharMaxPos)
                
                if i == scannedCharMaxPos {
                    // 正好扫描到【已扫描的字符的最原位置】，到达切割点
                    partitions.append(i - start + 1)
                    start = i + 1 // 更新下一个待切割的字符串的起始位置
                }
            }
            return partitions
        }
    }
}
