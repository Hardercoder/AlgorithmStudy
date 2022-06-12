//
//  Cyc2018_leetcode+x.swift
//  CommandLine
//
//  Created by unravel on 2022/4/14.
//

import Foundation
extension Cyc2018_leetcode {
    // http://www.cyc2018.xyz/%E7%AE%97%E6%B3%95/Leetcode%20%E9%A2%98%E8%A7%A3/Leetcode%20%E9%A2%98%E8%A7%A3%20-%20%E6%95%B0%E5%AD%A6.html#%E7%B4%A0%E6%95%B0%E5%88%86%E8%A7%A3
    class Think_Math {
        // MARK: 计数质数
        // https://leetcode-cn.com/problems/count-primes/description/
        func countPrimes(_ n: Int) -> Int {
            var notPrimes = [Bool](repeating: false, count: n + 1)
            var count = 0
            for i in 2..<n {
                if notPrimes[i] {
                    continue
                }
                count += 1
                // 从 i*i开始，因为k<i,那么k*i在之前就已经被去除过了
                var j = i * i
                while j < n {
                    notPrimes[j] = true
                    j += i
                }
            }
            return count
        }
        
        // 枚举法
        func countPrimes1(_ n: Int) -> Int {
            var ans = 0
            func isPrime(_ x: Int) -> Bool {
                var i = 2
                while i * i <= x {
                    if x % i == 0 {
                        return false
                    }
                    i += 1
                }
                return true
            }
            for i in 2..<n {
                ans += isPrime(i) ? 1 : 0
            }
            return ans
        }
        
        // MARK: 最大公约数
        func gcd(_ a: Int, _ b: Int) -> Int {
            return b == 0 ? a : gcd(b, a % b)
        }
        
        // MARK: 最小公倍数
        // 最小公倍数为两数的乘积除以最大公倍数
        func lcm(_ a: Int, _ b: Int) -> Int {
            return a * b / gcd(a, b)
        }
        
//        // MARK: 使用位操作和减法求解最大公约数
//        // 编程之美：2.7
//        func gcd2(_ a: Int, _ b: Int) -> Int {
//            if a < b {
//                return gcd2(b, a)
//            }
//            if b == 0 {
//                return a
//            }
//            let isAEven = a % 2 == 0, isBEven = b % 2 == 0
//            if isAEven && isBEven {
//                return 2 * gcd2(a >> 1, b >> 1)
//            }
//            else if isAEven && !isBEven {
//                return gcd2(a >> 1, b)
//            }
//            else if !isAEven && isBEven {
//                return gcd2(a, b >> 1)
//            }
//            else {
//                return gcd2(a, a - b)
//            }
//        }
        
        // MARK: 进制转换
        // MARK: 7 进制
        // https://leetcode-cn.com/problems/base-7/description/
        func convertToBase7(_ num: Int) -> String {
            if num == 0 {
                return "0"
            }
            
            var sb = [Int]()
            let isNegative = num < 0
            
            var num = abs(num)
            while num > 0 {
                sb.append(num % 7)
                num /= 7
            }
            let retSign = isNegative ? "-" : ""
            let ret = sb.reversed().reduce(into: retSign ) { $0 += "\($1)" }
            return ret
        }
        
        // MARK: 16 进制
        // https://leetcode-cn.com/problems/convert-a-number-to-hexadecimal/description/
        func toHex(_ num: Int) -> String {
            if num == 0 {
                return "0"
            }
            let chars = "0123456789abcdef".map { Character(String($0)) }
            var sb = [Character]()
            let num = num
            for i in (0...7).reversed() {
                let val = (num >> (4 * i)) & 0xf
                // 只有非前导0的时候才继续添加
                if sb.count > 0 || val > 0 {
                    let digitChar = chars[val]
                    sb.append(digitChar)
                }
            }
            return String(sb)
        }
        
        // MARK: 26 进制
        // https://leetcode.cn/problems/excel-sheet-column-title/description/
        func convertToTitle(_ columnNumber: Int) -> String {
            let chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".map { Character(String($0)) }
            var str = [Character]()
            var columnNumber = columnNumber
            while columnNumber != 0 {
                columnNumber -= 1
                
                str.append(chars[columnNumber % 26])
                columnNumber /= 26
            }
            return String(str.reversed())
        }
        
        // MARK: 阶乘
        // MARK: 统计阶乘尾部有多少个 0
        // https://leetcode.cn/problems/factorial-trailing-zeroes/description/
        func trailingZeroes(_ n: Int) -> Int {
            return n == 0 ? 0 : n / 5 + trailingZeroes(n/5)
        }
        
        func trailingZeroes2(_ n: Int) -> Int {
            var n = n, count = 0
            while n > 0 {
                count += n / 5
                n /= 5
            }
            return count
        }
        
        
        // MARK: 字符串加法减法
        // MARK: 二进制加法
        // https://leetcode.cn/problems/add-binary/submissions/
        func addBinary(_ a: String, _ b: String) -> String {
            print(a, b)
            let aChars = Array(a),
                aCharsCnt = aChars.count,
                bChars = Array(b),
                bCharsCnt = bChars.count
            var str = [Character](),
                carry = 0,
                i = aCharsCnt - 1,
                j = bCharsCnt - 1
            while carry == 1 || i >= 0 || j >= 0 {
                if i >= 0 {
                    if aChars[i] == "1" {
                        carry += 1
                    }
                    i -= 1
                }
                
                if j >= 0 {
                    if bChars[j] == "1" {
                        carry += 1
                    }
                    j -= 1
                }
                // carry 只有 都为1的时候才为2，其余时候<2
                str.append(Character("\(carry % 2)"))
                // 除以2之后，本身就是一个进位符，要么是1，要么是0
                carry /= 2
            }
            return String(str.reversed())
        }
        
        // MARK: 字符串加法
        // https://leetcode.cn/problems/add-strings/description/
        func addStrings(_ num1: String, _ num2: String) -> String {
            let num1Ints = num1.map { Int(String($0))! },
                num1IntsCnt = num1Ints.count,
                num2Ints = num2.map { Int(String($0))! },
                num2IntsCnt = num2Ints.count
            
            var str = [Character](),
                carry = 0,
                i = num1IntsCnt - 1,
                j = num2IntsCnt - 1
            while carry == 1 || i >= 0 || j >= 0 {
                var x = 0
                if i >= 0 {
                    x = num1Ints[i]
                    i -= 1
                }
                
                var y = 0
                if j >= 0 {
                    y = num2Ints[j]
                    j -= 1
                }
                let value = x + y + carry
                // 加法个位数
                str.append(Character("\(value % 10)"))
                // 进位标识
                carry = value / 10
            }
            return String(str.reversed())
        }
        
        
        // MARK: 相遇问题
        // MARK: 改变数组元素使所有的数组元素都相等
        // https://leetcode.cn/problems/minimum-moves-to-equal-array-elements-ii/description/
        func minMoves2(_ nums: [Int]) -> Int {
            let nums = nums.sorted()
            var move = 0, l = 0, h = nums.count - 1
            while l < h {
                move += nums[h] - nums[l]
                h -= 1
                l += 1
            }
            return move
        }
        
        // MARK: 多数投票问题
        // MARK: 数组中出现次数多于 n / 2 的元素
        // https://leetcode.cn/problems/majority-element/description/
        func majorityElement(_ nums: [Int]) -> Int {
            // 使用 cnt 来统计一个元素出现的次数
            var cnt = 0, majority = nums[0]
            
            for num in nums {
                // 减到0的时候说明该换个数字了
                majority = cnt == 0 ? num : majority
                // 根据众数与当前遍历的数的关系，决定是次数加一还是减一
                cnt = (majority == num) ? cnt + 1 : cnt - 1
            }
            return majority
        }
        
        
        // MARK: 其他
        // MARK: 平方数
        // https://leetcode-cn.com/problems/valid-perfect-square/description/
        func isPerfectSquare(_ num: Int) -> Bool {
            var num = num, subNum = 1
            while num > 0 {
                num -= subNum
                subNum += 2
            }
            return num == 0
        }
        
        // MARK: 3 的 n 次方
        // https://leetcode-cn.com/problems/power-of-three/description/
        func isPowerOfThree(_ n: Int) -> Bool {
            // 判断是否是3的最大次方的数的约数。因为题目中给的是32位，所以最大为3的19次方 1162261467
            return n > 0 && (1162261467 % n == 0)
        }
        
        // 只要是3的倍数，就进行不断地整除，最后判断是否是1
        func isPowerOfThree2(_ n: Int) -> Bool {
            var n = n
            while n != 0 && n % 3 == 0 {
                n /= 3
            }
            return n == 1
        }
        
        // MARK: 乘积数组
        // https://leetcode-cn.com/problems/product-of-array-except-self/description/
        func productExceptSelf(_ nums: [Int]) -> [Int] {
            let n = nums.count
            if n < 2 {
                return nums
            }
            /*         右上角
             x 0 0 0 0 0 0 0
             0 x 0 0 0 0 0 0
             0 0 x 0 0 0 0 0
             0 0 0 x 0 0 0 0
             0 0 0 0 x 0 0 0
             0 0 0 0 0 x 0 0
             0 0 0 0 0 0 x 0
             0 0 0 0 0 0 0 x
             左下角
             */
            var products = [Int](repeating: 1, count: n)
            // 计算左下角的半个区域，所有下标范围为0到n-2,对应结果数组中的1到n-1
            // left 为左侧所有元素的乘积
            var left = 1
            // 因为要保证左侧至少有一个元素，所以这里从1开始
            for i in 1..<n {
                left *= nums[i-1]
                products[i] *= left
            }
            
            // 计算右上角的半个区域，倒序计算，所有下标范围为n-1到1，对应结果数组中的n-2到0
            // r为右侧所有元素的乘积
            var right = 1
            for i in (0..<(n-1)).reversed() {
                right *= nums[i+1]
                products[i] *= right
            }
            return products
        }
        
        // MARK: 找出数组中的乘积最大的三个数
        // https://leetcode.cn/problems/maximum-product-of-three-numbers/description/
        func maximumProduct(_ nums: [Int]) -> Int {
            // 只要求出数组中最大的三个数以及最小的两个数
            // 第一大，第二大，第三大，第一小，第二小
            var max1 = Int.min,
                max2 = Int.min,
                max3 = Int.min,
                min1 = Int.max,
                min2 = Int.max
            for num in nums {
                if num > max1 {
                    max3 = max2
                    max2 = max1
                    max1 = num
                }
                else if num > max2 {
                    max3 = max2
                    max2 = num
                }
                else if num > max3 {
                    max3 = num
                }
                
                if num < min1 {
                    min2 = min1
                    min1 = num
                }
                else if num < min2 {
                    min2 = num
                }
            }
            return max(min1 * min2 * max1, max1 * max2 * max3)
        }
        
        // 排序后，选择最大的三个数乘积以及两个最小的数与一个最大的数的乘积
        func maximumProduct2(_ nums: [Int]) -> Int {
            let n = nums.count
            if n >= 3 {
                let nums = nums.sorted()
                return max(nums[0] * nums[1] * nums[n-1],
                           nums[n-1] * nums[n-2] * nums[n-3])
            }
            else {
                return 0
            }
        }
    }
}
