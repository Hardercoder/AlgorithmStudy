//
//  Cyc2018_swordOffer+Search.swift
//  CommandLine
//
//  Created by unravel on 2022/2/28.
//

import Foundation
extension Cyc2018_swordOffer {
    class Cyc2018_swordOffer_Search {
        // MARK: 矩阵中的路径
        // 思想:  构造一个矩阵后，把矩阵所有的位置先标记为未走过。然后从起点开始，按照定义的方向往各个地方行走，如果后包含了我们定义的路径就返回
        private let nextDirection = [(0, -1), (0, 1), (-1, 0), (1, 0)]
        func hasPath(_ val:String,
                     rows: Int,
                     cols: Int,
                     path: String) -> Bool {
            if rows == 0 || cols == 0 {
                return false
            }
            let valChars = Array(val), valCharsCnt = valChars.count
            
            var matrix = [[Character]](repeating: [Character](repeating: Character(""), count: cols), count: rows)
            // 构建矩阵
            func buildMatrix() {
                for r in 0..<rows {
                    for c in 0..<cols {
                        let idx = r * cols + c
                        if idx < valCharsCnt {
                            matrix[r][c] = valChars[idx]
                        }
                    }
                }
            }
            buildMatrix()
            return Cyc2018_leetcode.Think_Search().exist(matrix, path)
        }
        
        // MARK: 机器人的运动范围
        // 思想:  和上面的思想一样，只是内部路径不可走的判断条件不一样
        func movingCount(_ threshold: Int, _ rows: Int, _ cols: Int) -> Int {
            var cnt = 0
            // 标记对应的格子是否走过
            var marked = [[Bool]](repeating: [Bool](repeating: false, count: cols), count: rows)
            // 矩阵
            var digitSum = [[Int]](repeating: [Int](repeating: 0, count: cols), count: rows)
            // 初始化坐标系 和 标记位
            func initDigitSum() {
                // 存储对应数字 各个位上的和 18, digitSumOne[18] = 9
                var digitSumOne = Array(repeating: 0, count: max(rows, cols))
                for i in 0..<digitSumOne.count {
                    var n = i
                    while n > 0 {
                        digitSumOne[i] += n % 10
                        n /= 10
                    }
                }
                
                for r in 0..<rows {
                    for c in 0..<cols {
                        digitSum[r][c] = digitSumOne[r] + digitSumOne[c]
                    }
                }
            }
            // 深度优先搜索
            func dfs(_ r: Int,
                     _ c: Int) {
                if r < 0 ||
                    r >= rows ||
                    c < 0 ||
                    c >= cols ||
                    marked[r][c] {
                    return
                }
                marked[r][c] = true
                
                if (digitSum[r][c] > threshold) {
                    return
                }
                cnt += 1
                for n in self.nextDirection  {
                    dfs(r + n.0,
                        c + n.1)
                }
            }
            
            // 初始化数据
            initDigitSum()
            dfs(0,
                0)
            return cnt
        }
        
        // MARK: 字符串的排列
        // 思想:  回溯法
        func permutation(_ str: String) -> [String] {
            var ret = [String]()
            let chars = Array(str),
                sortedChars = chars.sorted(),
                sortedCharsCnt = sortedChars.count
            if sortedCharsCnt == 0 {
                return ret
            }
            
            var hasUsed = Array(repeating: false, count: sortedCharsCnt)
            var sChars = [Character]()
            
            func backtracking() {
                if sChars.count == sortedCharsCnt {
                    ret.append(String(sChars))
                    return
                }
                for i in 0..<sortedCharsCnt {
                    if hasUsed[i] {
                        continue
                    }
                    
                    if i != 0 &&
                        sortedChars[i] == sortedChars[i - 1] &&
                        !hasUsed[i - 1] {
                        /* 保证不重复 */
                        continue
                    }
                    
                    hasUsed[i] = true
                    sChars.append(sortedChars[i])
                    backtracking()
                    _ = sChars.removeLast()
                    hasUsed[i] = false
                }
            }
            
            backtracking()
            return ret
        }
    }
}
