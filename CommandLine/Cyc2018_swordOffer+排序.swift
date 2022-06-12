//
//  Cyc2018_swordOffer+Sort.swift
//  CommandLine
//
//  Created by unravel on 2022/2/28.
//

extension Cyc2018_swordOffer {
    class Cyc2018_swordOffer_Sort {
        // MARK: 调整数组顺序使奇数位于偶数前面(保证奇偶的相对位置不变)
        // 思想:  先算出有多少奇数，然后顺序遍历，按照奇偶的index存储另一个数组中
        func reOrderArray(_ nums:inout [Int]) {
            // 判断是否是偶数
            func isEven(_ x: Int) -> Bool {
                return x % 2 == 0
            }
            
            // 奇数的数量
            let oddCnt = nums.filter { !isEven($0) }.count;
            
            // 创建原始数组
            let orgNums = nums
            
            var i = 0, j = oddCnt
            for num in orgNums {
                if isEven(num) {
                    // 偶数
                    nums[j] = num
                    j += 1
                }
                else {
                    // 奇数
                    nums[i] = num
                    i += 1
                }
            }
        }
        
        // 冒泡 思想
        // 思想:  若相邻两个数，一个是奇数，一个是偶数，就把偶数往后冒泡
        func reOrderArray1(_ nums:inout [Int]) {
            // 判断是否是偶数
            func isEven(_ x: Int) -> Bool {
                return x % 2 == 0
            }
            
            // 从右往左，保证调换的偶数相对位置不变
            for i in (0..<nums.count).reversed() {
                for j in 0..<i {
                    // 左边是偶数，右边是奇数的话，需要调换位置
                    if isEven(nums[j]) && !isEven(nums[j + 1]) {
                        (nums[j], nums[j + 1]) = (nums[j + 1], nums[j])
                    }
                }
            }
        }
        
        // MARK: 把数组排成最小的数
        // 思想:  可以看成是一个排序问题，在比较两个字符串 S1 和 S2 的大小时，应该比较的是 S1+S2 和 S2+S1 的大小
        // 如果 S1+S2 < S2+S1，那么应该把 S1 排在前面，否则应该把 S2 排在前面
        func printMinNumber(_ numbers: [Int]) -> String {
            if numbers.count == 0 {
                return ""
            }
            
            var nums = numbers.map{ "\($0)" }
            nums.sort { (s1, s2) -> Bool in
                (s1 + s2) < (s2 + s1)
            }
            
            return nums.joined()
        }
        
        // MARK:  数组中的逆序对
        // 思想:  归并排序过程中统计次数
        func inversePairs(_ nums: [Int]) -> Int {
            var tmp = Array<Int>(repeating: 0, count: nums.count)
            var mNums = nums
            var cnt = 0
            
            func merge(_ l: Int,
                       _ m: Int,
                       _ h: Int) {
                var i = l, j = m + 1, k = l
                while i <= m || j <= h {
                    if i > m {
                        tmp[k] = mNums[j]
                        j += 1
                    }
                    else if j > h {
                        tmp[k] = mNums[i]
                        i += 1
                    }
                    else if mNums[i] <= mNums[j] {
                        tmp[k] = mNums[i]
                        i += 1
                    }
                    else {
                        tmp[k] = mNums[j]
                        j += 1
                        cnt += m - i + 1  // nums[i] > nums[j]，说明 nums[i...mid] 都大于 nums[j]
                    }
                    k += 1
                }
                for k in l...h {
                    mNums[k] = tmp[k]
                }
            }
            
            func mergeSort(_ l: Int,
                           _ h: Int) {
                if h - l < 1 {
                    return
                }
                let m = l + (h - l) / 2
                mergeSort(l, m)
                mergeSort(m + 1, h)
                merge(l, m, h)
            }
            
            mergeSort(0,
                      nums.count - 1)
            return (cnt % 1000000007)
        }
    }
}
