//
//  Cyc2018_swordOffer+ArrayMetrics.swift
//  CommandLine
//
//  Created by unravel on 2022/2/28.
//

import Combine

extension Cyc2018_swordOffer {
    class Cyc2018_swordOffer_ArrayMatrix {
        // MARK: 数组中重复的数字
        // https://leetcode.cn/problems/shu-zu-zhong-zhong-fu-de-shu-zi-lcof/submissions/
        // 思想:  将每个数字放到它对应的位置上，比如nums[i] 放到 i的位置上，如果有两个放到了一个地方，就可以校验出来
        // 另外一个通用的思想，把遍历过的数字放到集合里，若集合里包含此数据，说明有重复的
        func findRepeatNumber(_ nums: [Int]) -> Int {
            // 赋值新数组，因为内部会进行交换
            var compareNums = nums
            
            for i in 0..<compareNums.count {
                while compareNums[i] != i {
                    // 得出它该放的位置
                    let j = compareNums[i]
                    // 如果它本来的位置上已经有数据，就重复了
                    if j == compareNums[j] {
                        return j
                    }
                    // 交换i 和  nums[i] 位置处的数字
                    (compareNums[i], compareNums[j]) = (compareNums[j], compareNums[i])
                }
            }
            return -1
        }
        
        // MARK: 二维数组中的查找
        // https://leetcode.cn/problems/er-wei-shu-zu-zhong-de-cha-zhao-lcof/
        // 思想:  找规律，从左下角或右上角入手
        func findNumberIn2DArray(_ matrix: [[Int]], _ target: Int) -> Bool {
            if matrix.count == 0 || matrix[0].count == 0 {
                return false
            }
            let rows = matrix.count, cols = matrix[0].count
            // 从右上角开始
            var row = 0
            var col = cols - 1
            while row < rows && col >= 0 {
                // 获取row行col列的数据
                let valueAtRowCol = matrix[row][col]
                if target == valueAtRowCol {
                    return true
                }
                else if (target > valueAtRowCol) {
                    row += 1
                }
                else {
                    col -= 1
                }
            }
            return false
        }
        
        // MARK: 替换空格
        // https://leetcode.cn/problems/ti-huan-kong-ge-lcof/
        // 思想:  给str扩容，之后双指针分别从最后往前移动。这样可以防止插入%20造成的内存移动操作
        // 当然这里我们没有写，因为swift中字符串使用的是String.Index，操作比较繁琐。也可以写，只是嫌麻烦
        func replaceSpace(_ s: String) -> String {
            return s.replacingOccurrences(of: " ", with: "%20")
        }
        
        // MARK: 顺时针打印矩阵
        // https://leetcode.cn/problems/shun-shi-zhen-da-yin-ju-zhen-lcof/
        // 思想:  采用四个边界法，左右->上下->右左->下上 如此循环，期间修改边界
        func spiralOrder(_ matrix: [[Int]]) -> [Int] {
            var ret = [Int]()
            if matrix.count == 0 || matrix[0].count == 0 {
                return ret
            }
            
            // 左边界， 右边界，上边界，下边界
            var left = 0,
                right = matrix[0].count - 1,
                up = 0,
                down = matrix.count - 1
            // 这里使用while true会让逻辑理解起来更简单
            while true {
                // 最上面一行
                for col in left...right {
                    ret.append(matrix[up][col])
                }
                // 向下逼近
                up += 1
                // 判断是否越界
                if up > down {
                    break
                }
                
                // 最右边一行
                for row in up...down {
                    ret.append(matrix[row][right])
                }
                // 向左逼近
                right -= 1
                // 判断是否越界
                if left > right {
                    break
                }
                
                // 最下面一行
                for col in (left...right).reversed() {
                    ret.append(matrix[down][col])
                }
                // 向上逼近
                down -= 1
                // 判断是否越界
                if up > down {
                    break
                }
                
                // 最左边一行
                for row in (up...down).reversed() {
                    ret.append(matrix[row][left])
                }
                // 向右逼近
                left += 1
                // 判断是否越界
                if left > right {
                    break
                }
            }
            return ret
        }
        
        // MARK: 第一个只出现一次的字符位置
        // https://leetcode.cn/problems/di-yi-ge-zhi-chu-xian-yi-ci-de-zi-fu-lcof/submissions/
        func firstUniqChar(_ s: String) -> Character {
            let sChars = Array(s)
            // 总共26个字母，数组26个长度就可以
            var cntArray = [Int](repeating: 0, count: 26)
            // 下标计算的基准
            let aAsciiValue = Character("a").asciiValue!
            // 第一遍统计次数
            for ch in sChars {
                let ind = Int(ch.asciiValue! - aAsciiValue)
                cntArray[ind] += 1
            }
            
            // 第二遍判断第一个次数为1的ch
            for ch in sChars {
                let ind = Int(ch.asciiValue! - aAsciiValue)
                if cntArray[ind] == 1 {
                    return ch
                }
            }
            
            return Character(" ")
        }
    }
}
