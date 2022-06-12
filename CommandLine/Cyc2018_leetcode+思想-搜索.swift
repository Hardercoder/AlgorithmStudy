//
//  Cyc2018_leetcode+x.swift
//  CommandLine
//
//  Created by unravel on 2022/4/14.
//

import Foundation
extension Cyc2018_leetcode {
    class Think_Search {
        // MARK: BFS 广度优先搜索，求最优解
        // MARK: 计算在网格中从原点到特定点的最短路径长度
        // https://leetcode-cn.com/problems/shortest-path-in-binary-matrix/
        // 0 表示可以经过某个位置，求解从左上角到右下角的最短路径长度。
        func shortestPathBinaryMatrix(_ grids: [[Int]]) -> Int {
            // 必要条件判断
            if grids.count == 0 ||
                grids[0].count == 0 {
                return -1
            }
            
            // 定义方向类型，水平和垂直
            typealias DirectionType = (h: Int, v: Int)
            // 定义网格中每个位置的类型
            typealias GridPositionType = (x: Int, y: Int)
            // 定义方向枚举
            enum Direction {
                // 右上
                static let rightTop: DirectionType = (h: 1, v: -1)
                // 右
                static let right: DirectionType = (h: 1, v: 0)
                // 右下
                static let rightDown: DirectionType = (h: 1, v: 1)
                // 上
                static let up: DirectionType = (h: 0, v: -1)
                // 下
                static let down: DirectionType = (h: 0, v: 1)
                // 左上
                static let leftTop: DirectionType = (h: -1, v: -1)
                // 左
                static let left: DirectionType = (h: -1, v: 0)
                // 左下
                static let leftDown: DirectionType = (h: -1, v: 1)
            }
            
            // 定义8个方向
            let directions = [
                Direction.rightTop,
                Direction.right,
                Direction.rightDown,
                Direction.up,
                Direction.down,
                Direction.leftTop,
                Direction.left,
                Direction.leftDown
            ]
            
            var mGrids = grids
            // 记录多少行列
            let m = mGrids.count, n = mGrids[0].count
            
            // FIFO 队列
            var queue = [GridPositionType]()
            // 左上角位置入队
            queue.append((x: 0, y: 0))
            // 计算路径长度
            var pathLength = 0
            
            while !queue.isEmpty {
                // 统计队列中节点数量
                var queueSize = queue.count
                // 将路径+1
                pathLength += 1
                
                while queueSize > 0 {
                    // 出队列，然后尝试走8个方向并标记
                    let cur = queue.removeFirst()
                    queueSize -= 1
                    
                    // 取出当前的x，y坐标 current row,current column
                    let cr = cur.x, cc = cur.y
                    // 当前位置是1，说明此路不通。
                    // 有两种情况
                    // 1. 原来grid中就是1
                    // 2. 我们已经走过，主动标记为1
                    if mGrids[cr][cc] == 1 {
                        continue
                    }
                    
                    // 这里不能挪到上面，因为还有可能出口不通
                    // 已经到达出口，直接返回路径长度
                    if cr == m - 1 && cc == n - 1 {
                        return pathLength
                    }
                    
                    // 标记已经走过，再探索此路时，不通
                    mGrids[cr][cc] = 1
                    
                    // 四仰八叉的走
                    for d in directions {
                        // 取出下一个要走的节点 next row, next column
                        let nr = cr + d.h, nc = cc + d.v
                        if nr < 0 ||
                            nr >= m ||
                            nc < 0 ||
                            nc >= n ||
                            mGrids[cr][cc] != 1 {
                            continue
                        }
                        queue.append((nr, nc))
                    }
                }
            }
            return -1
        }
        
        // MARK: 组成整数的最小平方数数量
        // https://leetcode-cn.com/problems/perfect-squares/description/
        func numSquares(_ n: Int) -> Int {
            /*
             生成小于n的平方数序列 1， 4， 9， 16， 25， 36
             */
            func generateSquares(_ n: Int) -> [Int] {
                var squares = [Int](), square = 1, diff = 3
                while square <= n {
                    squares.append(square)
                    square += diff
                    diff += 2
                }
                return squares
            }
            
            let squares = generateSquares(n)
            var queue = [Int]()
            queue.append(n)
            
            var marked = [Bool](repeating: false, count: n + 1)
            marked[n] = true
            
            var level = 0
            
            while !queue.isEmpty {
                var size = queue.count
                level += 1
                
                while size > 0 {
                    let cur = queue.removeFirst()
                    size -= 1
                    // 遍历完全平方数数组
                    for s in squares {
                        let next = cur - s
                        // 因为s是从1，4，9这么走的，所以一旦不合适就可以直接break掉for循环
                        if next < 0 {
                            break
                        }
                        
                        if next == 0 {
                            return level
                        }
                        
                        if marked[next] {
                            continue
                        }
                        
                        marked[next] = true
                        queue.append(next)
                    }
                }
            }
            return n
        }
        
        // 数学方法，一个数至多能被4个平方数累加
        func numSquares2(_ n: Int) -> Int {
            // 是否为完全平方数
            func isPerfectSquare(_ x: Int) -> Bool {
                let y = Int(sqrt(Double(x)))
                return y * y == x
            }
            
            // 是否能标示位4^k*(8m+7)
            func checkAnswer4(_ x: Int) -> Bool {
                var x = x
                while x % 4 == 0 {
                    x /= 4
                }
                return x % 8 == 7
            }
            
            if isPerfectSquare(n) {
                return 1
            }
            
            if checkAnswer4(n) {
                return 4
            }
            
            var i = 1
            while i * i <= n {
                // 计算剩下的数
                let j = n - i * i
                // 如果剩下的数是一个完全平方数，则总共有两个完全平方数i和sqrt(j)
                if isPerfectSquare(j) {
                    return 2
                }
                i += 1
            }
            return 3
        }
        
        func numSquares3(_ n: Int) -> Int {
            var f = [Int](repeating: 0, count: n + 1)
            for i in 1...n {
                var minn = Int.max
                var j = 1
                while j * j <= i {
                    minn = min(minn, f[i - j * j])
                    j += 1
                }
                f[i] = minn + 1
            }
            return f[n]
        }
        
        // MARK: 最短单词路径
        // https://leetcode-cn.com/problems/word-ladder/solution/
        // 找出一条从 beginWord 到 endWord 的最短路径，每次移动规定为改变一个字符，并且改变之后的字符串必须在 wordList 中
        func ladderLength(_ beginWord: String,
                          _ endWord: String,
                          _ wordList: [String]) -> Int {
            // 如果相同，就不需要路径
            if beginWord == endWord {
                return 0
            }
            // 如果endword不存在与wordList中，无路径，返回0
            guard let endInd = wordList.firstIndex(of: endWord) else {
                return 0
            }
            
            // 将startWord拼接到wordList尾部,标记起始下标为count-1
            let wordList = (wordList + [beginWord]).map{ Array($0) }
            let N = wordList.count, startInd = N - 1
            
            // 判断s1和s2之间是否只差一个字符,s1和s2是否能够连接成一条边
            func canConnect(_ s1: [Character],
                            _ s2: [Character]) -> Bool {
                guard s1.count == s2.count else {
                    return false
                }
                
                var diffCnt = 0
                for (ind, ch) in s1.enumerated() {
                    // 如果对应下标所在的字符不同，就+1
                    if ch != s2[ind] {
                        diffCnt += 1
                    }
                }
                return diffCnt == 1
            }
            
            // 构建word1到word2的图
            var graphic = [[Int]](repeating: [Int](), count: N)
            func buildGraphic() {
                for i in 0..<N {
                    for j in 0..<N {
                        // 记录节点i可以转化到节点j的有向图
                        if canConnect(wordList[i], wordList[j]) {
                            graphic[i].append(j)
                        }
                    }
                }
            }
            
            func getShortestPath(_ start: Int,
                                 _ end:Int) -> Int {
                var queue = [Int]()
                queue.append(start)
                
                // 标记有哪些节点已经访问过了
                var marked = [Bool](repeating: false, count: graphic.count)
                marked[start] = true
                
                var path = 1
                
                while !queue.isEmpty {
                    var size = queue.count
                    path += 1
                    
                    while size > 0 {
                        let cur = queue.removeFirst()
                        size -= 1
                        // 遍历当前节点所连的边的对应那头的节点
                        for next in graphic[cur] {
                            // 如果找到了end下标，说明找到了答案
                            if next == end {
                                return path
                            }
                            // 已经走过的直接跳过
                            if marked[next] {
                                continue
                            }
                            
                            marked[next] = true
                            queue.append(next)
                        }
                    }
                }
                return 0
            }
            buildGraphic()
            return getShortestPath(startInd, endInd)
        }
        
        // MARK: DFS 深度优先搜索，求可达性问题
        // MARK: 查找最大的连通面积
        // https://leetcode-cn.com/problems/max-area-of-island/description/
        func maxAreaOfIsland(_ grid: [[Int]]) -> Int {
            if grid.count == 0 || grid[0].count == 0 {
                return 0
            }
            let m = grid.count, n = grid[0].count
            // 定义探索的四个方向
            let directions = [(h: 0, v: 1), (h: 0, v: -1), (h: 1, v: 0), (h: -1, v: 0)]
            // 创建一个新的grid
            var grid = grid
            // 深度优先探索
            func dfs(_ r: Int, _ c: Int) -> Int {
                // 如果水平或者垂直超出边界或者不是陆地（值为1），面积返回0
                if r < 0 ||
                    r >= m ||
                    c < 0 ||
                    c >= n ||
                    grid[r][c] == 0 {
                    return 0
                }
                // 标记为水，防止重复计算
                grid[r][c] = 0
                // 面积从本身1开始累加
                var area = 1
                // 遍历每个方向进行探索叠加
                for d in directions {
                    area += dfs(r + d.h, c + d.v)
                }
                return area
            }
            
            var maxArea = 0
            // 遍历每一个位置，处理他周围的连通面积
            for i in 0..<m {
                for j in 0..<n {
                    let area = dfs(i, j)
                    maxArea = max(maxArea, area)
                }
            }
            return maxArea
        }
        
        // MARK: 矩阵中的连通分量数目
        // https://leetcode-cn.com/problems/number-of-islands/description/
        func numIslands(_ grid: [[Character]]) -> Int {
            if grid.count == 0 || grid[0].count == 0 {
                return 0
            }
            let m = grid.count, n = grid[0].count
            // 定义探索的四个方向
            let directions = [(h: 0, v: 1), (h: 0, v: -1), (h: 1, v: 0), (h: -1, v: 0)]
            var grid = grid
            // 深度优先探索
            func dfs(_ r: Int, _ c: Int) {
                // 如果水平或者垂直超出边界或者不是陆地（值为1）直接返回
                if r < 0 ||
                    r >= m ||
                    c < 0 ||
                    c >= n ||
                    grid[r][c] == "0" {
                    return
                }
                // 找到一块岛屿，就把岛屿周围的陆地变为水，防止重复计算。岛屿和岛屿周围的陆地算作一块岛屿
                grid[r][c] = "0"
                // 遍历每个方向，将相连的陆地变为水
                for d in directions {
                    dfs(r + d.h, c + d.v)
                }
            }
            
            var islandsNum = 0
            // 遍历每一个位置，判断它是否是一个连通分量
            for i in 0..<m {
                for j in 0..<n {
                    // 如果是陆地，将相连的陆地变成水
                    if grid[i][j] != "0" {
                        dfs(i, j)
                        islandsNum += 1
                    }
                }
            }
            return islandsNum
        }
        
        // MARK: 好友关系的连通分量数目
        // https://leetcode-cn.com/problems/friend-circles/description/
        // 好友关系可以看成是一个无向图，是一个方形矩阵
        func findCircleNum(_ isConnected: [[Int]]) -> Int {
            // 如果是一个空矩阵，或者不是一个方形矩阵，就返回0
            if isConnected.count == 0 ||
                isConnected[0].count != isConnected.count {
                return 0
            }
            
            let n = isConnected.count
            var hasVisited = [Bool](repeating: false, count: n)
            // 深度优先探索
            func dfs(_ i: Int) {
                // 标记节点已经访问过
                hasVisited[i] = true
                // 遍历该同学和每一个同学的关系节点进行处理
                for k in 0..<n {
                    // i和k是好朋友，但是i标记了，k没有标记，那么将k也标记
                    if isConnected[i][k] == 1 && !hasVisited[k] {
                        dfs(k)
                    }
                }
            }
            
            var circleNum = 0
            // 遍历每一个同学进行处理
            for i in 0..<n {
                if !hasVisited[i] {
                    dfs(i)
                    circleNum += 1
                }
            }
            return circleNum
        }
        
        // MARK: 填充封闭区域
        // https://leetcode-cn.com/problems/surrounded-regions/description/
        // 先填充最外侧，剩下的就是里侧
        func solve(_ board: inout [[Character]]) {
            // 必要条件判断
            if board.count == 0 || board[0].count == 0 {
                return
            }
            let m = board.count, n = board[0].count
            // 定义探索的四个方向
            let directions = [(h: 0, v: 1), (h: 0, v: -1), (h: 1, v: 0), (h: -1, v: 0)]
            // 深度优先探索，处理边上的r，c
            func dfs(_ r: Int, _ c: Int) {
                // 如果水平或者垂直超出边界或者不是O,直接返回不处理
                if r < 0 ||
                    r >= m ||
                    c < 0 ||
                    c >= n ||
                    board[r][c] != "O" {
                    return
                }
                // 标记为T，代表和边界上的O直接或间接相连
                board[r][c] = "T"
                // 遍历每个方向，修改标记位
                for d in directions {
                    dfs(r + d.h, c + d.v)
                }
            }
            
            // 处理左右两条垂直边
            for i in 0..<m {
                // 左边
                dfs(i, 0)
                // 右边
                dfs(i, n - 1)
            }
            // 处理上下两条水平边
            for i in 0..<n {
                // 上边
                dfs(0, i)
                // 下边
                dfs(m - 1, i)
            }
            // 遍历矩阵进行处理
            for i in 0..<m {
                for j in 0..<n {
                    // 如果是T，说明跟边界上的O直接或间接相连，修改为O，保证不被修改
                    if board[i][j] == "T" {
                        board[i][j] = "O"
                    }
                    // 其余的O，处理成X
                    else if board[i][j] == "O" {
                        board[i][j] = "X"
                    }
                }
            }
        }
        
        // MARK: 能到达的太平洋和大西洋的区域
        // https://leetcode-cn.com/problems/pacific-atlantic-water-flow/description/
        func pacificAtlantic(_ heights: [[Int]]) -> [[Int]] {
            // 必要条件判断
            var ret = [[Int]]()
            if heights.count == 0 || heights[0].count == 0 {
                return ret
            }
            let m = heights.count, n = heights[0].count
            // 定义探索的四个方向
            let directions = [(h: 0, v: 1), (h: 0, v: -1), (h: 1, v: 0), (h: -1, v: 0)]
            let matrix = heights
            // 能到达太平洋的点
            var canReachP = [[Bool]](repeating: [Bool](repeating: false, count: n), count: m)
            // 能到达大西洋的点
            var canReachA = [[Bool]](repeating: [Bool](repeating: false, count: n), count: m)
            
            // 深度优先探索，处理边上的r，c
            func dfs(_ r: Int,
                     _ c: Int,
                     _ canReach: inout [[Bool]]) {
                if canReach[r][c] {
                    return
                }
                // 因为是从外到内，所以可以直接置为true
                canReach[r][c] = true
                
                // 遍历每个方向，修改标记位
                for d in directions {
                    let nextR = r + d.h, nextC = c + d.v
                    // 如果水平或者垂直超出边界或者不是O,直接返回不处理
                    if nextR < 0 ||
                        nextR >= m ||
                        nextC < 0 ||
                        nextC >= n ||
                        // 反向推，如果rc比nextR，nextC还要大，说明流不过来
                        matrix[r][c] > matrix[nextR][nextC] {
                        continue
                    }
                    dfs(nextR, nextC, &canReach)
                }
            }
            
            // 处理左右两条垂直边
            // 左边能否流入太平洋，右边能否流入大西洋
            for i in 0..<m {
                // 左边
                dfs(i, 0, &canReachP)
                // 右边
                dfs(i, n - 1, &canReachA)
            }
            // 处理上下两条水平边
            // 上边能否流入太平洋，下边能否流入大西洋
            for i in 0..<n {
                // 上边
                dfs(0, i, &canReachP)
                // 下边
                dfs(m - 1, i, &canReachA)
            }
            // 遍历矩阵进行处理
            for i in 0..<m {
                for j in 0..<n {
                    // 即能流入太平洋，也能流入大西洋
                    if canReachP[i][j] && canReachA[i][j] {
                        ret.append([i, j])
                    }
                }
            }
            return ret
        }
        
        // MARK: Backtracking（回溯）属于 DFS
        // MARK: 数字键盘组合
        // https://leetcode-cn.com/problems/letter-combinations-of-a-phone-number/description/
        func letterCombinations(_ digits: String) -> [String] {
            var combinations = [String]()
            if digits.count == 0 {
                return combinations
            }
            // 数字对应的字符[[],[],["a","b","c"]]
            let Keys = [
                "",     // 0
                "",     // 1
                "abc",  // 2
                "def",  // 3
                "ghi",  // 4
                "jkl",  // 5
                "mno",  // 6
                "pqrs", // 7
                "tuv",  // 8
                "wxyz"  // 9
            ].map { Array($0) }
            // 将数字转换成整数数组 "239" => [2, 3, 9]
            let digits = digits.map { Int(String($0))! }
            
            // 已经处理的字符
            var combination = [Character]()
            func doCombination() {
                // 和原来的字符长度相同时就是我们需要的结果
                if combination.count == digits.count {
                    // 将结果添加到combinations中
                    combinations.append(String(combination))
                    return
                }
                // 取当前应该处理的数字，可能是2，3或9
                let curDigits = digits[combination.count]
                // 遍历数字对应的字符数组
                for c in Keys[curDigits] {
                    // 添加
                    combination.append(c)
                    doCombination()
                    // 移除
                    combination.removeLast()
                }
            }
            doCombination()
            return combinations
        }
        
        // MARK: IP 地址划分
        // https://leetcode-cn.com/problems/restore-ip-addresses/description/
        func restoreIpAddresses(_ s: String) -> [String] {
            // 将字符串转换为字符数组
            let sChars = Array(s)
            // 最终结果数组
            var addresses = [String]()
            // 拼接IP地址的临时变量
            var tempAddress = ""
            func doRestore(_ k: Int, _ chars: [Character]) {
                // 如果已经是第四轮处理或者字符数组已经是0，就代表递归到头了，需要return
                if k == 4 || chars.count == 0 {
                    // 如果是第四轮并且字符数组是0，说明是被正确的分割了，往结果数组中添加结果
                    if k == 4 && chars.count == 0 {
                        addresses.append(tempAddress)
                    }
                    return
                }
                
                var i = 0
                // 因为IP中每一位最大是255，所以i的值最大从0增长到2就可以了
                while i < chars.count && i <= 2 {
                    // 如果非首位并且字符数组第一个不是0，处理下一位
                    if i != 0 && chars.first == "0" {
                        i += 1
                        break
                    }
                    // 本次截取的字符串
                    var part = chars[...i]
                    // 如果字符串的值是一个合理的值才进行处理
                    if Int(String(part))! <= 255 {
                        // 如果tempAddress不是首位，需要给part前面插入一个.
                        if tempAddress.count > 0 {
                            part.insert(".", at: 0)
                        }
                        // 添加
                        tempAddress += String(part)
                        doRestore(k + 1, Array(chars[(i+1)...]))
                        // 移除
                        tempAddress.removeLast(part.count)
                    }
                    
                    i += 1
                }
            }
            doRestore(0, sChars)
            return addresses
        }
        
        func restoreIpAddresses2(_ s: String) -> [String] {
            // 将字符串转换为整数数组
            let sChars = s.map { Int(String($0))! }, sCharsCount = sChars.count
            // 答案数组
            var ans = [String]()
            // IP 分段
            let SEG_COUNT = 4
            // 存储IP的每一段数字
            var segments = [Int](repeating: 0, count: SEG_COUNT)
            func dfs(_ segId: Int, _ segStart: Int) {
                // 如果找到了4段IP地址，并且遍历完了字符串，那么就是一种答案
                if segId == SEG_COUNT {
                    if segStart == sCharsCount {
                        // 构建IP地址字符串
                        let ipaddress = segments.map{ String($0) }.joined(separator: ".")
                        ans.append(ipaddress)
                    }
                    return
                }
                
                // 如果还没找到4段IP地址就已经遍历完了字符串，那么提前回溯
                if segStart == sCharsCount {
                    return
                }
                
                // 由于不能有前导零，如果当前数字是0，那么这段IP地址只能为0
                if sChars[segStart] == 0 {
                    segments[segId] = 0
                    dfs(segId + 1, segStart + 1)
                    return
                }
                
                // 一般情况，枚举每一种可能性并递归
                var addr = 0
                for segEnd in segStart..<sCharsCount {
                    addr = addr * 10 + sChars[segEnd]
                    if addr > 0 && addr <= 255 {
                        segments[segId] = addr
                        dfs(segId + 1, segEnd + 1)
                    }
                    else {
                        break
                    }
                }
            }
            dfs(0, 0)
            return ans
        }
        
        // MARK: 在矩阵中寻找字符串
        // https://leetcode-cn.com/problems/word-search/description/
        func exist(_ board: [[Character]], _ word: String) -> Bool {
            let wordChars = Array(word), wordCharsCount = wordChars.count
            // 如果要查找的word不存在，那么就返回true
            if wordCharsCount == 0 {
                return true
            }
            
            // 必要条件判断，矩阵行列不为空
            if board.count == 0 || board[0].count == 0 {
                return false
            }
            // 获取行列
            let m = board.count, n = board[0].count
            // 定义探索的四个方向
            let directions = [(h: 0, v: 1), (h: 0, v: -1), (h: 1, v: 0), (h: -1, v: 0)]
            // 标记对应位置是否已经访问
            var hasVisited = [[Bool]](repeating: [Bool](repeating: false, count: n), count: m)
            // 深度优先探索，处理r,c上的字符是否和word curLen上的字符相同
            func backtracing(_ curLen: Int,
                             _ r: Int,
                             _ c: Int) -> Bool {
                // 得到结果返回true
                if curLen == wordCharsCount {
                    return true
                }
                // 超出边界或者对应位置的字符和word中的字符不等或者已经访问过，return false
                if r < 0 ||
                    r >= m ||
                    c < 0 ||
                    c >= n ||
                    board[r][c] != wordChars[curLen] ||
                    hasVisited[r][c] {
                    return false
                }
                // 置为true，表明已经访问过
                hasVisited[r][c] = true
                
                // 遍历每个方向，修改标记位
                for d in directions {
                    if backtracing(curLen + 1,
                                   r + d.h,
                                   c + d.v) {
                        return true
                    }
                }
                // 单次递归之后置为false，表明其他的递归还是可以访问的
                hasVisited[r][c] = false
                return false
            }
            
            // 遍历矩阵进行处理
            for r in 0..<m {
                for c in 0..<n {
                    if backtracing(0,
                                   r,
                                   c) {
                        return true
                    }
                }
            }
            return false
        }
        
        // MARK: 输出二叉树中所有从根到叶子的路径
        // https://leetcode-cn.com/problems/binary-tree-paths/description/
        func binaryTreePaths(_ root: TreeNode?) -> [String] {
            var paths = [String]()
            // 如果节点是空
            if root == nil {
                return paths
            }
            var values = [Int]()
            // 判断是否是叶子节点
            func isLeaf(_ node: TreeNode) -> Bool {
                return node.left == nil && node.right == nil
            }
            // 构建路径
            func buildPath() -> String {
                return values.map { String($0) }.joined(separator: "->")
            }
            // 回溯
            func backtracing(_ node: TreeNode?) {
                guard let node = node else {
                    return
                }
                // 添加
                values.append(node.val)
                if isLeaf(node) {
                    paths.append(buildPath())
                }
                else {
                    backtracing(node.left)
                    backtracing(node.right)
                }
                // 移除
                values.removeLast()
            }
            backtracing(root)
            return paths
        }
        
        // MARK: 排列
        // https://leetcode-cn.com/problems/permutations/description/
        func permute(_ nums: [Int]) -> [[Int]] {
            let numsCount = nums.count
            // 排列组合的二维数组，单个排列的一维数组
            var permutes = [[Int]](), permuteList = [Int]()
            // 标识某个位置是否已经被访问
            var hasVisited = [Bool](repeating: false, count: numsCount)
            func backtracking() {
                // 如果一维数组的长度和数字长度相同，说明一个排列组合已经生成
                if permuteList.count == numsCount {
                    permutes.append(permuteList)
                    return
                }
                for i in 0..<numsCount {
                    if hasVisited[i] {
                        continue
                    }
                    // 标记已经访问过
                    hasVisited[i] = true
                    // 添加值
                    permuteList.append(nums[i])
                    backtracking()
                    // 移除值
                    permuteList.removeLast()
                    // 将本次递归置为false
                    hasVisited[i] = false
                }
            }
            backtracking()
            return permutes
        }
        
        // MARK: 含有相同元素求排列
        // https://leetcode-cn.com/problems/permutations-ii/description/
        func permuteUnique(_ nums: [Int]) -> [[Int]] {
            // 进行排序
            let nums = nums.sorted(), numsCount = nums.count
            var permutes = [[Int]](), permuteList = [Int]()
            var hasVisited = [Bool](repeating: false, count: numsCount)
            func backtracking() {
                if permuteList.count == numsCount {
                    permutes.append(permuteList)
                    return
                }
                for i in 0..<numsCount {
                    // 在添加一个元素时，判断这个元素是否等于前一个元素
                    // 如果等于，并且前一个元素还未访问，那么就跳过这个元素
                    if i > 0 && nums[i] == nums[i - 1] && !hasVisited[i - 1] {
                        // 防止重复
                        continue
                    }
                    
                    if hasVisited[i] {
                        continue
                    }
                    
                    hasVisited[i] = true
                    permuteList.append(nums[i])
                    backtracking()
                    permuteList.removeLast()
                    hasVisited[i] = false
                }
            }
            backtracking()
            return permutes
        }
        
        // MARK: 组合
        // https://leetcode-cn.com/problems/combinations/description/
        func combine(_ n: Int, _ k: Int) -> [[Int]] {
            var combinations = [[Int]](), combineList = [Int]()
            if n < k {
                return combinations
            }
            func backtracking(_ start: Int, _ kk: Int) {
                // 递归终止条件是：不需要选择数了
                if kk == 0 {
                    combinations.append(combineList)
                    return
                }
                // 遍历可能的搜索起点，注意：这里进行了剪支
                for i in start...(n - kk + 1) {
                    // 向组合中添加一个数
                    combineList.append(i)
                    // 下一轮搜索，设置的起点数要加1，要选择的数要减1，因为组合数里无重复数字
                    backtracking(i + 1, kk - 1)
                    // 重点理解这里：深度优先遍历有回头的过程，因此递归之前做了什么，递归之后需要做相同操作的逆向操作
                    combineList.removeLast()
                }
            }
            
            backtracking(1, k)
            return combinations
        }
        
        // MARK: 组合求和
        // https://leetcode-cn.com/problems/combination-sum/description/
        func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
            let candidatesCount = candidates.count
            var combinations = [[Int]](), combineList = [Int]()
            func backtracking(_ start: Int, _ tar: Int) {
                // 如果值正好是tar，则代表一个结果
                if tar == 0 {
                    combinations.append(combineList)
                    return
                }
                
                if start >= candidatesCount ||
                    tar < 0 {
                    return
                }
                
                for i in start..<candidatesCount {
                    let val = candidates[i]
                    if val <= tar {
                        // 向组合中添加一个数
                        combineList.append(val)
                        // 下一轮搜索，设置的起点数要加1，要选择的数要减1，因为组合数里无重复数字
                        backtracking(i, tar - val)
                        // 重点理解这里：深度优先遍历有回头的过程，因此递归之前做了什么，递归之后需要做相同操作的逆向操作
                        combineList.removeLast()
                    }
                }
            }
            backtracking(0, target)
            return combinations
        }
        
        // MARK: 含有相同元素的组合求和
        // https://leetcode-cn.com/problems/combination-sum-ii/description/
        func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
            let candidates = candidates.sorted()
            let candidatesCount = candidates.count
            
            var hasVisited = [Bool](repeating: false, count: candidatesCount)
            var combinations = [[Int]](), combineList = [Int]()
            
            func backtracking(_ start: Int, _ tar: Int) {
                // 如果值正好是tar，则代表一个结果
                if tar == 0 {
                    combinations.append(combineList)
                    return
                }
                
                for i in start..<candidatesCount {
                    // 在添加一个元素时，判断这个元素是否等于前一个元素
                    // 如果等于，并且前一个元素还未访问，那么就跳过这个元素
                    if i > 0 && candidates[i] == candidates[i - 1] && !hasVisited[i - 1] {
                        continue
                    }
                    let val = candidates[i]
                    if val <= tar {
                        // 向组合中添加一个数
                        combineList.append(val)
                        hasVisited[i] = true
                        // 下一轮搜索，设置的起点数要加1，要选择的数要减1，因为组合数里无重复数字
                        backtracking(i + 1, tar - val)
                        hasVisited[i] = false
                        // 重点理解这里：深度优先遍历有回头的过程，因此递归之前做了什么，递归之后需要做相同操作的逆向操作
                        combineList.removeLast()
                    }
                }
            }
            backtracking(0, target)
            return combinations
        }
        
        // MARK: 1-9 数字的组合求和
        // https://leetcode-cn.com/problems/combination-sum-iii/description/
        // 从 1-9 数字中选出 k 个数不重复的数，使得它们的和为 n
        func combinationSum3(_ k: Int, _ tar: Int) -> [[Int]] {
            var combinations = [[Int]](), combineList = [Int]()
            func backtracking(_ target: Int, _ kk: Int, _ start: Int) {
                // 递归终止条件是：不需要选择数，或者已经找到答案
                if kk == 0 && target == 0 {
                    combinations.append(combineList)
                    return
                }
                
                if kk == 0 ||
                    target <= 0 ||
                    start > 9 {
                    return
                }
                
                // 遍历可能的搜索起点，注意：这里进行了剪支
                for i in start...9 {
                    // 向组合中添加一个数
                    combineList.append(i)
                    // 下一轮搜索，设置的起点数要加1，要选择的数要减1，因为组合数里无重复数字
                    backtracking(target - i, kk - 1, i + 1)
                    // 重点理解这里：深度优先遍历有回头的过程，因此递归之前做了什么，递归之后需要做相同操作的逆向操作
                    combineList.removeLast()
                }
            }
            
            backtracking(tar, k, 1)
            return combinations
        }
        
        // MARK: 子集
        // https://leetcode-cn.com/problems/subsets/description/
        func subsets(_ nums: [Int]) -> [[Int]] {
            let numsCount = nums.count
            var subsets = [[Int]](), tempSubset = [Int]()
            // 计算单个子集的大小
            func backtracking(_ start: Int, _ size: Int) {
                // 达到子集长度，就产生一个结果
                if tempSubset.count == size {
                    subsets.append(tempSubset)
                    return
                }
                // 遍历数组，进行子集的计算
                for i in start..<numsCount {
                    tempSubset.append(nums[i])
                    backtracking(i + 1, size)
                    tempSubset.removeLast()
                }
            }
            
            // 不同子集的大小，从0到数组长度
            for size in 0...numsCount {
                backtracking(0, size)
            }
            return subsets
        }
        
        // MARK: 含有相同元素求子集
        // https://leetcode-cn.com/problems/subsets-ii/description/
        func subsetsWithDup(_ nums: [Int]) -> [[Int]] {
            let nums = nums.sorted()
            let numsCount = nums.count
            var subsets = [[Int]](), tempSubset = [Int]()
            var hasVisited = [Bool](repeating: false, count: numsCount)
            // 计算单个子集的大小
            func backtracking(_ start: Int, _ size: Int) {
                // 达到子集长度，就产生一个结果
                if tempSubset.count == size {
                    subsets.append(tempSubset)
                    return
                }
                // 遍历数组，进行子集的计算
                for i in start..<numsCount {
                    if i > 0 && nums[i] == nums[i - 1] && !hasVisited[i - 1] {
                        continue
                    }
                    hasVisited[i] = true
                    tempSubset.append(nums[i])
                    backtracking(i + 1, size)
                    tempSubset.removeLast()
                    hasVisited[i] = false
                }
            }
            
            // 不同子集的大小，从0到数组长度
            for size in 0...numsCount {
                backtracking(0, size)
            }
            return subsets
        }
        
        // MARK: 分割字符串使得每个部分都是回文数
        // https://leetcode-cn.com/problems/palindrome-partitioning/description/
        func partition(_ s: String) -> [[String]] {
            var partitions = [[String]](), tempPartition = [String]()
            let sChars = Array(s), sCharsCount = sChars.count
            
            // 预处理
            // 状态：dp[i][j] 表示 s[i][j] 是否是回文
            var dp = [[Bool]](repeating: [Bool](repeating: false, count: sCharsCount), count: sCharsCount)
            // 状态转移方程：在 s[i] == s[j] 的时候，dp[i][j] 参考 dp[i + 1][j - 1]
            for r in 0..<sCharsCount {
                // 注意：left <= right 取等号表示 1 个字符的时候也需要判断
                for l in 0...r {
                    if (sChars[l] == sChars[r] && (r - l <= 2 || dp[l + 1][r - 1])) {
                        dp[l][r] = true
                    }
                }
            }
            
            func doPartition(_ startInd: Int) {
                if startInd == sCharsCount {
                    partitions.append(tempPartition)
                    return
                }
                for i in startInd..<sCharsCount {
                    if dp[startInd][i] {
                        tempPartition.append(String(sChars[startInd...i]))
                        doPartition(i + 1)
                        tempPartition.removeLast()
                    }
                }
            }
            doPartition(0)
            return partitions
        }
        
        // MARK: 数独
        // https://leetcode-cn.com/problems/sudoku-solver/description/
        // 结果是对的，但是超出了时长限制
//        func solveSudoku(_ board: inout [[Character]]) {
//            var rowsUsed = [[Bool]](repeating: [Bool](repeating: false, count: 10),
//                                    count: 9)
//            var colsUsed = [[Bool]](repeating: [Bool](repeating: false, count: 10),
//                                    count: 9)
//            var cubesUsed = [[Bool]](repeating: [Bool](repeating: false, count: 10),
//                                     count: 9)
//            
//            func cubeNum(_ i: Int, _ j: Int) -> Int {
//                let r = i / 3
//                let c = j / 3
//                return r * 3 + c
//            }
//            
//            func backtracking(_ row: Int, _ col: Int) -> Bool {
//                var row = row, col = col
//                while row < 9 && board[row][col] != "." {
//                    row = col == 8 ? row + 1 : row
//                    col = col == 8 ? 0 : col + 1
//                }
//                if row == 9 {
//                    return true
//                }
//                for num in 1...9 {
//                    if rowsUsed[row][num] ||
//                        colsUsed[col][num] ||
//                        cubesUsed[cubeNum(row, col)][num] {
//                        continue
//                    }
//                    rowsUsed[row][num] = true
//                    colsUsed[col][num] = true
//                    cubesUsed[cubeNum(row, col)][num] = true
//                    
//                    board[row][col] = Character("\(num)")
//                    
//                    if backtracking(row, col) {
//                        return true
//                    }
//                    
//                    board[row][col] = "."
//                    rowsUsed[row][num] = false
//                    colsUsed[col][num] = false
//                    cubesUsed[cubeNum(row, col)][num] = false
//                }
//                return false
//            }
//            
//            for i in 0..<9 {
//                for j in 0..<9 {
//                    if board[i][j] == "." {
//                        continue
//                    }
//                    let num = Int(String(board[i][j]))!
//                    rowsUsed[i][num] = true
//                    colsUsed[j][num] = true
//                    cubesUsed[cubeNum(i, j)][num] = true
//                }
//            }
//            _ = backtracking(0, 0)
//        }
        
        func solveSudoku2(_ board: inout [[Character]]) {
            // 第一个index代表哪一行，第二个index代表这一行上的数字
            var line = [[Bool]](repeating: [Bool](repeating: false,
                                                  count: 9),
                                count: 9)
            // 在一列上面是否使用数字
            var column = [[Bool]](repeating: [Bool](repeating: false,
                                                    count: 9),
                                  count: 9)
            // 在9个3*3的小方格上面是否使用数字
            var block = [[[Bool]]](repeating: [[Bool]](repeating: [Bool](repeating: false,
                                                                         count: 9),
                                                       count: 3),
                                   count: 3)
            var finished = false
            // 存储空格位置
            typealias BlankPos = (x: Int, y: Int)
            var spaces = [BlankPos]()
            
            func setFlag(_ i: Int, _ j: Int, _ digit: Int, _ b: Bool) {
                line[i][digit] = b
                column[j][digit] = b
                block[i / 3][j / 3][digit] = b
            }
            
            func getOrFlags(_ i: Int, _ j: Int, _ digit: Int) -> Bool {
                return (line[i][digit] ||
                        column[j][digit] ||
                        block[i / 3][j / 3][digit])
            }
            
            func dfs(_ pos: Int) {
                if pos == spaces.count {
                    finished = true
                    return
                }
                // 获取空格位置
                let space = spaces[pos]
                // 获取空格横纵坐标
                let i = space.x, j = space.y
                // 从数字0开始试图填充
                var digit = 0
                while !finished && digit < 9 {
                    // 横、纵、小方格，都未使用的话，尝试填入
                    if !getOrFlags(i, j, digit) {
                        // 设置标识
                        setFlag(i, j, digit, true)
                        // 填入数字
                        board[i][j] = Character("\(digit + 1)")
                        // 处理下一个方格
                        dfs(pos + 1)
                        // 恢复标识
                        setFlag(i, j, digit, false)
                    }
                    digit += 1
                }
            }
            
            // 先把空格的整理处理出来，同时把已经使用的数字标记为true
            for i in 0..<9 {
                for j in 0..<9 {
                    if board[i][j] == "." {
                        // 将空格放入数组中
                        spaces.append((x: i, y: j))
                    }
                    else {
                        // 将目前数独中有数字的位置置为已使用
                        let digit = Int(String(board[i][j]))! - 1
                        setFlag(i, j, digit, true)
                    }
                }
            }
            // 递归处理空格
            dfs(0)
        }
        
        // MARK: N 皇后
        // https://leetcode-cn.com/problems/n-queens/description/
        func solveNQueens(_ n: Int) -> [[String]] {
            // 解决方案
            var solutions = [[String]]()
            // 存放每一种方案，皇后棋盘
            var nQueue = [[Character]](repeating: [Character](repeating: ".", count: n),
                                       count: n)
            // 3 个标记位，标记对应的列，45度斜线，135度斜线是否包含皇后
            var colUsed = [Bool](repeating: false, count: n)
            var diagonals45Used = [Bool](repeating: false, count: 2 * n - 1)
            var diagonals135Used = [Bool](repeating: false, count: 2 * n - 1)
            
            func backtracking(_ row: Int) {
                if row == n {
                    solutions.append(nQueue.map { String($0) })
                    return
                }
                // 处理每一类是否满足条件
                for col in 0..<n {
                    // 45度斜线数组的下标
                    let diagonal45Idx = row + col
                    // 135度斜线数组的下标
                    let diagonal135Idx = n - 1 - (row - col)
                    
                    if colUsed[col] ||
                        diagonals45Used[diagonal45Idx] ||
                        diagonals135Used[diagonal135Idx] {
                        continue
                    }
                    nQueue[row][col] = "Q"
                    colUsed[col] = true
                    diagonals45Used[diagonal45Idx] = true
                    diagonals135Used[diagonal135Idx] = true
                    
                    backtracking(row + 1)
                    
                    colUsed[col] = false
                    diagonals45Used[diagonal45Idx] = false
                    diagonals135Used[diagonal135Idx] = false
                    nQueue[row][col] = "."
                }
            }
            // 递归处理每一行
            backtracking(0)
            return solutions
        }
        //
        //        func solveNQueens2(_ n: Int) -> [[String]] {
        //            var solutions = [[String]]()
        //            var queues = [Int](repeating: -1, count: n)
        //            var columns = Set<Int>(), diagonals1 = Set<Int>(), diagonals2 = Set<Int>()
        //
        //            func generateBoard(_ n: Int) -> [String] {
        //                var board = [String]()
        //                for i in 0..<n {
        //                    var row = [Character](repeating: ".", count: n)
        //                    row[queues[i]] = "Q"
        //                    board.append(String(row))
        //                }
        //                return board
        //            }
        //
        //            func backtrack(_ row: Int) {
        //                if row == n {
        //                    solutions.append(generateBoard(n))
        //                }
        //                else {
        //                    for i in 0..<n {
        //                        if columns.contains(i) {
        //                            continue
        //                        }
        //                        let diagonal1 = row - i
        //                        if diagonals1.contains(diagonal1) {
        //                            continue
        //                        }
        //                        let diagonal2 = row + i
        //                        if diagonals2.contains(diagonal2) {
        //                            continue
        //                        }
        //                        queues[row] = i
        //                        columns.insert(i)
        //                        diagonals1.insert(diagonal1)
        //                        diagonals2.insert(diagonal2)
        //                        backtrack(row + 1)
        //                        queues[row] = -1
        //                        columns.remove(i)
        //                        diagonals1.remove(diagonal1)
        //                        diagonals2.remove(diagonal2)
        //                    }
        //                }
        //            }
        //
        //            backtrack(0)
        //            return solutions
        //        }
    }
}
