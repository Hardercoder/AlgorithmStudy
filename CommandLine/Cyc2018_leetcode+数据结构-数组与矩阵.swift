//
//  Cyc2018_leetcode+x.swift
//  CommandLine
//
//  Created by unravel on 2022/4/14.
//

import Foundation
extension Cyc2018_leetcode {
    class DataStructure_ArrayMatrics {
        // MARK: 把数组中的 0 移到末尾
        // https://leetcode-cn.com/problems/move-zeroes/description/
        func moveZeroes(_ nums: inout [Int]) {
            var ind = 0
            // 使用迭代器遍历数组，将非0的数据依次挪到前面
            for num in nums {
                if num != 0 {
                    nums[ind] = num
                    ind += 1
                }
            }
            // 将剩余的位数填充0
            while ind < nums.count {
                nums[ind] = 0
                ind += 1
            }
        }
        
        // MARK: 改变矩阵维度
        // https://leetcode-cn.com/problems/reshape-the-matrix/description/
        func matrixReshape(_ mat: [[Int]], _ r: Int, _ c: Int) -> [[Int]] {
            let m = mat.count, n = mat[0].count
            if m * n != r * c {
                return mat
            }
            
            var reshapedMat = [[Int]](repeating: [Int](repeating: 0, count: c),
                                      count: r)
            var index = 0
            for i in 0..<r {
                for j in 0..<c {
                    // 因为每一列有n个，需要 index / n 计算行， index % n 计算列
                    reshapedMat[i][j] = mat[index / n][index % n]
                    index += 1
                }
            }
            return reshapedMat
        }
        
        // MARK: 找出数组中最长的连续 1
        // https://leetcode-cn.com/problems/max-consecutive-ones/description/
        func findMaxConsecutiveOnes(_ nums: [Int]) -> Int {
            var maxCnt = 0, curCnt = 0
            for x in nums {
                curCnt = x == 1 ? curCnt + 1 : 0
                maxCnt = max(maxCnt, curCnt)
            }
            return maxCnt
        }
        
        // MARK: 有序矩阵查找
        // https://leetcode-cn.com/problems/search-a-2d-matrix-ii/description/
        func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
            if matrix.count == 0 ||
                matrix[0].count == 0 {
                return false
            }
            let m = matrix.count, n = matrix[0].count
            // 从右上角开始，往左都是减小，往下都是增大
            var row = 0, col = n - 1
            while row < m && col >= 0 {
                let value = matrix[row][col]
                if target == value {
                    return true
                }
                else if target < value {
                    col -= 1
                }
                else {
                    row += 1
                }
            }
            return false
        }
        
        // MARK: 有序矩阵的 Kth Element
        // https://leetcode-cn.com/problems/kth-smallest-element-in-a-sorted-matrix/description/
        // 二分查找法
        func kthSmallest(_ matrix: [[Int]], _ k: Int) -> Int {
            let m = matrix.count, n = matrix[0].count
            var lo = matrix[0][0], hi = matrix[m - 1][n - 1]
            
            while lo <= hi {
                let mid = lo + (hi - lo) / 2
                var cnt = 0
                for i in 0..<m {
                    for j in 0..<n {
                        if matrix[i][j] <= mid {
                            cnt += 1
                        }
                        else {
                            break
                        }
                    }
                }
                if cnt < k {
                    lo = mid + 1
                }
                else {
                    hi = mid - 1
                }
            }
            return lo
        }
        
        // 直接排序
        func kthSmallest2(_ matrix: [[Int]], _ k: Int) -> Int {
            let rows = matrix.count, columns = matrix[0].count
            var sorted = [Int](repeating: 0, count: rows * columns)
            var index = 0
            for row in matrix {
                for num in row {
                    sorted[index] = num
                    index += 1
                }
            }
            // 默认升序排序
            return sorted.sorted()[k - 1]
        }
        
        // 二分查找，拆分方法
        /*
         每次对于「猜测」的答案 mid，计算矩阵中有多少数不大于 mid
         
         如果数量不少于 k，那么说明最终答案 x 不大于 mid；
         如果数量少于 k，那么说明最终答案 x 大于 mid。
         */
        func kthSmallest3(_ matrix: [[Int]], _ k: Int) -> Int {
            // 获取矩阵的行列
            let m = matrix.count, n = matrix[0].count
            // 最小值在左上角，最大值在右下角
            var lo = matrix[0][0], hi = matrix[m - 1][n - 1]
            // 检查是否应该在左半边区域查找
            func check(_ mid: Int) -> Bool {
                // 从左下角判断，用num记录小于mid的数的数量
                // 其实这里可以使用上面矩阵中查找target的方法，从右上角开始，那样就需要判断行而不是列了
                var x = 0, y = n - 1, num = 0
                while x < m && y >= 0 {
                    // 如果小于mid，说明y所在的这一列都是小于mid的
                    // 此时需要将y+1添加进去，并且往右移一列
                    if matrix[x][y] <= mid {
                        num += y + 1
                        // 如果已经确定，就立马中断返回
                        if num >= k {
                            return true
                        }
                        x += 1
                    }
                    else {
                        // 如果大于mid，说明应该往上挪一行
                        y -= 1
                    }
                }
                return false
            }
            
            // 二分查找 小于等于mid
            while lo < hi {
                let mid = lo + (hi - lo) / 2
                // 被mid分割成小于等于mid的左半区域和大于mid的右半区域
                if check(mid) {
                    hi = mid
                }
                else {
                    lo = mid + 1
                }
            }
            return lo
        }
        
        // MARK: 一个数组元素在 [1, n] 之间，其中一个数被替换为另一个数，找出重复的数和丢失的数
        // https://leetcode-cn.com/problems/set-mismatch/description/
        func findErrorNums(_ nums: [Int]) -> [Int] {
            // 23354
            // 一个是局部变量，一个是实参
            var nums = nums
            for i in 0..<nums.count {
                while nums[i] != i + 1 && nums[nums[i] - 1] != nums[i] {
                    // 这一次判断，至少会将一个值放到正确的位置上，幸运的话两个都回归正确位置
                    /*
                     [2, 3, 3, 5, 4]
                     
                     [2, 3, 3, 5, 4] 0 1 位置交换
                     [3, 2, 3, 5, 4]
                     
                     [3, 2, 3, 5, 4] 3 4 位置交换
                     [3, 2, 3, 4, 5]
                     */
                    let swapInd1 = i, swapInd2 = nums[i] - 1
                    (nums[swapInd1], nums[swapInd2]) = (nums[swapInd2], nums[swapInd1])
                }
            }
            
            for i in 0..<nums.count {
                if nums[i] != i + 1 {
                    return [nums[i], i + 1]
                }
            }
            return []
        }
        
        // MARK: 找出数组中重复的数，数组值在 [1, n] 之间
        // https://leetcode-cn.com/problems/find-the-duplicate-number/description/
        // cnt[i] 表示 nums 数组中小于等于 i 的数有多少个
        // 知道 cnt[] 数组随数字 i 逐渐增大具有单调性（即 target 前 cnt[i] ≤ i, target 后 cnt[i]>i）
        // 二分查找法
        func findDuplicate(_ nums: [Int]) -> Int {
            // n + 1 长度的数组里，存放的数字都位于1到n，所以 count - 1 就是他的最大的值n
            var l = 1, h = nums.count - 1
            while l <= h {
                // 取中间值mid，然后统计cnt[mid]的数量，也即是下面的cnt
                let mid = l + (h - l) / 2
                var cnt = 0
                for i in 0..<nums.count {
                    if nums[i] <= mid {
                        cnt += 1
                    }
                }
                // 如果cnt > mid说明target是在左边区域
                // 为什么这么判断？因为如果mid左边如果无重复数字，cnt必然应该小于等于mid
                if cnt > mid {
                    h = mid - 1
                }
                else {
                    // 否则，在右边区域
                    l = mid + 1
                }
            }
            return l
        }
        
        // 双指针解法，类似于有环链表中找出环的入口
        func findDuplicate2(_ nums: [Int]) -> Int {
            var slow = nums[0], fast = nums[nums[0]]
            // 寻找环的入口
            while slow != fast {
                slow = nums[slow]
                fast = nums[nums[fast]]
            }
            // 将快指针重置，一步一步走，当快慢指针相遇时，就是入口所在的点，也就是重复的数值
            fast = 0
            while slow != fast {
                slow = nums[slow]
                fast = nums[fast]
            }
            return slow
        }
        
        // MARK: 数组相邻差值的个数
        // https://leetcode-cn.com/problems/beautiful-arrangement-ii/description/
        // 让前 k+1 个元素构建出 k 个不相同的差值，序列为：1 k+1 2 k 3 k-1 ... k/2 k/2+1.
        func constructArray(_ n: Int, _ k: Int) -> [Int] {
            var ret = [Int](repeating: 0, count: n)
            ret[0] = 1;
            var interval = k
            for i in 1...k {
                if i % 2 == 1 {
                    ret[i] = ret[i - 1] + interval
                }
                else {
                    ret[i] = ret[i - 1] - interval
                }
                interval -= 1
            }
            
            for i in (k+1)..<n {
                ret[i] = i + 1
            }
            return ret
        }
        
        func constructArray2(_ n: Int, _ k: Int) -> [Int] {
            var ret = [Int](repeating: 0, count: n)
            var lo = 1, hi = n
            // 首尾交替取k个数
            for i in 0..<k {
                if i % 2 == 0 {
                    ret[i] = lo
                    lo += 1
                }
                else {
                    ret[i] = hi
                    hi -= 1
                }
            }
            // 处理剩余的数(如果k是偶数，剩余的数要从hi开始递减，否则从lo开始递增)
            let evenK = k % 2 == 0
            for i in k..<n {
                if evenK {
                    ret[i] = hi
                    hi -= 1
                }
                else {
                    ret[i] = lo
                    lo += 1
                }
            }
            return ret
        }
        
        func constructArray3(_ n: Int, _ k: Int) -> [Int] {
            var res = [Int](repeating: n, count: 0)
            // 第 1 步：构造等差数列，把 1 到 n - k - 1 赋值结果数组的前面
            for i in 0..<(n - k - 1) {
                res[i] = i + 1
            }
            // 第 2 步：构造交错数列，下标从 n - k - 1 开始，数值从 n - k 开始
            // 控制交错的变量
            var j = 0
            var left = n - k, right = n
            for i in (n - k - 1)..<n {
                if j % 2 == 0 {
                    res[i] = left
                    left += 1
                }
                else {
                    res[i] = right
                    right -= 1
                }
                j += 1
            }
            return res
        }
        
        // MARK: 数组的度
        // https://leetcode-cn.com/problems/degree-of-an-array/description/
        func findShortestSubArray(_ nums: [Int]) -> Int {
            typealias CntFirstLast = (cnt: Int, firstInd: Int, lastInd: Int)
            var map = [Int:CntFirstLast]()
            // 统计数组中每个数字出现的频率 以及 这个数字首次和尾次出现的下标
            for (ind, num) in nums.enumerated() {
                if map[num] != nil {
                    map[num]!.cnt += 1
                    map[num]!.lastInd = ind
                }
                else {
                    map[num] = (1, ind, ind)
                }
            }
            // 遍历集合，寻找最长长度和相关下标，以便计算最短的下标区间
            var maxCnt = 0, minLen = 0
            for (_, m) in map {
                if maxCnt < m.cnt {
                    maxCnt = m.cnt
                    minLen = m.lastInd - m.firstInd + 1
                }
                else if maxCnt == m.cnt {
                    minLen = min(minLen, m.lastInd - m.firstInd + 1)
                }
            }
            return minLen
        }
        
        // MARK: 对角元素相等的矩阵
        // https://leetcode-cn.com/problems/toeplitz-matrix/description/
        func isToeplitzMatrix(_ matrix: [[Int]]) -> Bool {
            let rowCnt = matrix.count, colCnt = matrix[0].count
            // 斜向下检查
            func check(_ expectValue: Int, _ row: Int, _ col: Int) -> Bool {
                if row >= rowCnt || col >= colCnt {
                    return true
                }
                if matrix[row][col] != expectValue {
                    return false
                }
                return check(expectValue, row + 1, col + 1)
            }
            // 检查右上边区域
            for i in 0..<colCnt {
                if !check(matrix[0][i], 0, i) {
                    return false
                }
            }
            // 检查左下边区域
            for i in 0..<rowCnt {
                if !check(matrix[i][0], i, 0) {
                    return false
                }
            }
            return true
        }
        
        func isToeplitzMatrix2(_ matrix: [[Int]]) -> Bool {
            let rowCnt = matrix.count, colCnt = matrix[0].count
            for i in 1..<rowCnt {
                for j in 1..<colCnt {
                    if matrix[i][j] != matrix[i - 1][j - 1] {
                        return false
                    }
                }
            }
            return true
        }
        
        // MARK: 嵌套数组
        // https://leetcode-cn.com/problems/array-nesting/description/
        func arrayNesting(_ nums: [Int]) -> Int {
            var nums = nums
            var max = 0
            for i in 0..<nums.count {
                var cnt = 0
                var j = i
                while nums[j] != -1 {
                    cnt += 1
                    let t = nums[j]
                    nums[j] = -1
                    j = t
                }
                max = Swift.max(max, cnt)
            }
            return max
        }
        
        // MARK: 分隔数组
        // https://leetcode-cn.com/problems/max-chunks-to-make-sorted/description/
        func maxChunksToSorted(_ arr: [Int]) -> Int {
            var ret = 0
            var right = Int.min
            for i in 0..<arr.count {
                // 存储截止到目前为止的最大值
                right = max(right, arr[i])
                // 如果最大值是i，说明至少可以以i为界线，划分一个chunk
                if right == i {
                    ret += 1
                }
            }
            return ret
        }
        
    }
}
