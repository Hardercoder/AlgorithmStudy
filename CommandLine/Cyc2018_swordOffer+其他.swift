//
//  Cyc2018_swordOffer+其他.swift
//  CommandLine
//
//  Created by unravel on 2022/5/10.
//

import Foundation
extension Cyc2018_swordOffer {
    class Cyc2018_swordOffer_Others {
        // MARK: 打印从 1 到最大的 n 位数
        // https://leetcode.cn/problems/da-yin-cong-1dao-zui-da-de-nwei-shu-lcof/
        // 思想:  通过定义一个数组，递归操作它对应的位数（个位，十位，百位，千位等）
        func print1ToMaxOfNDigits(_ n:Int) {
            if n <= 0 {
                return
            }
            
            // 申请N个长度的数组，这个长度只是容量
            var number = [Int](repeating: 0, count: n)
            
            // 打印存储数字数组，不满足位数的用前导零填充了
            func printNumber() {
                guard let startInd = number.firstIndex(where: { $0 > 0 }) else {
                    return
                }
                let numStr = String(number[startInd...].map { Character("\($0)") })
                print(numStr)
            }
            
            // 递归方法，需要传入存储数据的数组和当前处理的额数字位数
            func print1ToMaxOfNDigitsFrom(_ digit: Int) {
                if digit == n {
                    printNumber()
                    return
                }
                // 在单个位置上遍历
                for i in 0..<10 {
                    number[digit] = i
                    print1ToMaxOfNDigitsFrom(digit + 1)
                }
            }
            
            // 从0开始增长
            print1ToMaxOfNDigitsFrom(0)
        }
        
        func printNumbers(_ n: Int) -> [Int] {
            let end = Int(pow(10, Double(n))) - 1
            return [Int](1...end)
        }
        
        // MARK: 正则表达式匹配 包括 '.' 和 '*' 的正则表达式
        // https://leetcode.cn/problems/regular-expression-matching/
        func match(str: String, pattern: String) -> Bool {
            let strChars = Array(str), patternChars = Array(pattern)
            let m = strChars.count, n = patternChars.count
            // dp[i][j]:表示s的前i个字符，p的前j个字符是否能够匹配
            var dp = Array(repeating: Array(repeating: false, count: n + 1), count: m + 1)
            // 初期值
            // s为空，p为空，能匹配上
            dp[0][0] = true
            // p为空，s不为空，必为false(boolean数组默认值为false，无需处理)
            
            // s为空，p不为空，由于*可以匹配0个字符，所以有可能为true
            for i in 1...n {
                if patternChars[i - 1] == "*" {
                    dp[0][i] = dp[0][i - 2]
                }
            }
            
            for i in 1...m {
                for j in 1...n {
                    if strChars[i - 1] == patternChars[j - 1] ||
                        patternChars[j - 1] == "." {
                        // 如果s[i-1] == t[j-1]那么dp[i][j]的结果和dp[i-1][j-1]的结果一致
                        dp[i][j] = dp[i - 1][j - 1]
                    }
                    else if patternChars[j - 1] == "*" {
                        if strChars[i - 1] == patternChars[j - 2] ||
                            patternChars[j - 2] == "." {
                            /**
                             a* counts as single a
                             dp[i][j] |= dp[i][j - 1];
                             a* counts as multiple a
                             dp[i][j] |= dp[i - 1][j];
                             a* counts as empty
                             dp[i][j] |= dp[i][j - 2];
                             */
                            dp[i][j] = dp[i][j - 1] || dp[i - 1][j] || dp[i][j - 2]
                        }
                        else {
                            // * 只能配0次
                            dp[i][j] = dp[i][j - 2]
                        }
                    }
                }
            }
            return dp[m][n]
        }
        
        // MARK: 表示数值的字符串
        // https://leetcode.cn/problems/biao-shi-shu-zhi-de-zi-fu-chuan-lcof/
        func isNumeric(str: String) -> Bool {
            /**
             * 按照字符串从左到右的顺序，定义以下 9 种状态
             *
             0. 开始的空格
             1. 幂符号前的正负号
             2. 小数点前的数字
             3. 小数点、小数点后的数字
             4. 当小数点前为空格时，小数点、小数点后的数字
             5. 幂符号
             6. 幂符号后的正负号
             7. 幂符号后的数字
             8. 结尾的空格
             */
            let state0 = [" ": 0, "s": 1, "d": 2, ".": 4]
            let state1 = ["d": 2, ".": 4]
            let state2 = ["d": 2, ".": 3, "e": 5, " ": 8]
            let state3 = ["d": 3, "e": 5, " ": 8]
            let state4 = ["d": 3]
            let state5 = ["s": 6, "d": 7]
            let state6 = ["d": 7]
            let state7 = ["d": 7, " ": 8]
            let state8 = [" ": 8]
            let states = [
                state0,
                state1,
                state2,
                state3,
                state4,
                state5,
                state6,
                state7,
                state8
            ]
            let zero2nineChars = (0...9).map { Character("\($0)") }
            var p = 0
            for c in str {
                var t = c
                if zero2nineChars.contains(c) {
                    t = "d"
                }
                else if c == "+" || c == "-" {
                    t = "s"
                }
                else if c == "e" || c == "E" {
                    t = "e"
                }
                else if c == "." || c == " " {
                    t = c
                }
                else {
                    t = "?"
                }
                
                if (states[p][String(t)] == nil) {
                    return false
                }
                p = states[p][String(t)]!
            }
            return p == 2 || p == 3 || p == 7 || p == 8
        }
        
        // MARK: 数字序列中的某一位数字
        // https://leetcode.cn/problems/shu-zi-xu-lie-zhong-mou-yi-wei-de-shu-zi-lcof/
        // 思想:  循环处理1位数字，2位数字。。。最终把index转到第n位数字上。之后取到n位数字的起始数字，然后用index/n就相当于起始数字加几之后的数字，
        // 然后index%n 去取这个数字的第几位
        func getDigitAtIndex(_ n: Int) -> Int {
            if n < 0 {
                return -1
            }
            /**
             * place 位数的数字组成的字符串长度
             * 10, 90, 900, ...
             */
            func getAmountOfPlace(_ place: Int) -> Int {
                if place == 1 {
                    return 10
                }
                
                return Int(pow(10, Double(place - 1)) * 9)
            }
            
            /**
             * place 位数的起始数字
             * 0, 10, 100, ...
             */
            func getBeginNumberOfPlace(_ place: Int) -> Int {
                if place == 1 {
                    return 0
                }
                return Int(pow(10, Double(place - 1)))
            }
            
            /**
             * 在 place 位数组成的字符串中，第 index 个数
             */
            func getDigitAtIndex(_ index: Int, _ place: Int) -> Int {
                let beginNumber = getBeginNumberOfPlace(place)
                let shiftNumber = index / place
                let numberIndex = index % place
                let numbers = "\(beginNumber + shiftNumber)".map { Int("\($0)")! }
                return numbers[numberIndex]
            }
            
            var place = 1 // 1 表示个位，2 表示 十位...
            var nIndex = n
            
            while true {
                let amount = getAmountOfPlace(place)
                let totalAmount = amount * place
                if nIndex < totalAmount {
                    return getDigitAtIndex(nIndex, place)
                }
                nIndex -= totalAmount
                place += 1
            }
        }
        
        func findNthDigit(_ n: Int) -> Int {
            var digit = 1, start = 1, count = 9, n = n
            // 1. 确定所求数位的所在数字的位数
            while n > count {
                n -= count
                digit += 1
                start *= 10
                count = digit * start * 9
            }
            // 2. 确定所求数位所在的数字
            let num = start + (n-1) / digit
            let numInd = (n-1) % digit
            // 3. 确定所求数位在 numnum 的哪一数位
            return "\(num)".map { Int("\($0)")! }[numInd]
        }
        
        // MARK: 把数字翻译成字符串
        // 思想:  动态规划算法
        func numDecodings(_ s: String) -> Int {
            return Cyc2018_leetcode.Think_DynamicPlan().numDecodings(s)
        }
        
        // MARK: 扑克牌顺子
        func isContinuous(_ nums: [Int]) -> Bool {
            if nums.count < 5 {
                return false
            }
            
            // 对数字进行排序
            let sortedNums = nums.sorted()
            
            // 统计癞子数量
            var cnt = 0
            for num in sortedNums {
                if num == 0 {
                    cnt += 1
                }
            }
            
            // 使用癞子去补全不连续的顺子
            for i in cnt..<(sortedNums.count - 1) {
                if sortedNums[i + 1] == sortedNums[i] {
                    return false
                }
                
                cnt -= sortedNums[i + 1] - nums[i] - 1
            }
            
            return cnt >= 0
        }
        
        func isStraight(_ nums: [Int]) -> Bool {
            var joker = 0
            let sNums = nums.sorted()
            for i in 0..<4 {
                // 统计大小王数量
                if sNums[i] == 0 {
                    joker += 1
                }
                else if sNums[i] == sNums[i + 1] {
                    // 若有重复，提前返回 false
                    return false
                }
            }
            // 最大牌 - 最小牌 < 5 则可构成顺子
            return sNums[4] - sNums[joker] < 5
        }
        
        // MARK: 求 1+2+3+...+n
        // 麻烦 swift中必须得是强制的类型转换，没有隐式转换
        func sum_Solution(_ n: Int) -> Int {
            guard n > 0 else {
                return 0
            }
            return n + sum_Solution(n - 1)
        }
        
        // MARK: 不用加减乘除做加法
        func add(_ a: Int, _ b: Int) -> Int {
            return Cyc2018_leetcode.DataStructure_BitOperation().getSum(a, b)
        }
        
        // MARK: 把字符串转换成整数
        func strToInt(_ str: String) -> Int {
            if str.count == 0 {
                return 0
            }
            
            let chars = Array(str)
            
            let isNegative = chars[0] == "-"
            let zeroAsciiValue = Character("0").asciiValue!
            var ret = 0
            for i in 0..<chars.count {
                let c = chars[i]
                /* 符号判定 */
                if i == 0 && (c == "+" || c == "-") {
                    continue
                }
                if c < "0" || c > "9" {                /* 非法输入 */
                    return 0
                }
                ret = ret * 10 + Int(c.asciiValue! - zeroAsciiValue)
            }
            return isNegative ? -ret : ret
        }
    }
    
}
