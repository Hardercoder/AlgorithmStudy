//
//  Cyc2018_swordOffer+Greed.swift
//  CommandLine
//
//  Created by unravel on 2022/2/28.
//

import Foundation
/// 贪心思想
extension Cyc2018_swordOffer {
    class Cyc2018_swordOffer_Greed {
        // MARK: 剪绳子
        // 思想:  动态规划
        func integerBreak(_ n: Int) -> Int {
            return Cyc2018_leetcode.Think_DynamicPlan().integerBreak(n)
        }
        
        // MARK: 股票的最大利润
        func maxProfit(_ prices: [Int]) -> Int {
            return Cyc2018_leetcode.Think_Greed().maxProfit(prices)
        }
    }
}
