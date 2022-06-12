//
//  Cyc2018_leetcode+x.swift
//  CommandLine
//
//  Created by unravel on 2022/4/14.
//

import Foundation
extension Cyc2018_leetcode {
    // 思想之排序
    class Think_Sort {
        // MARK: 找到倒数第 k 个的元素
        // 排序 ：时间复杂度 O(NlogN)，空间复杂度 O(1)。不清楚Swift中sort的排序算法是哪个，所以不好定性这里的说法
        // https://leetcode-cn.com/problems/kth-largest-element-in-an-array/description/
        func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
            return nums.sorted()[nums.count-k]
        }
        
        // 快速选择 ：时间复杂度 O(N)，空间复杂度 O(1)
        func findKthLargestQuickSort(_ nums: [Int], _ k: Int) -> Int {
            if k > nums.count || k <= 0 {
                return -1
            }
            
            let kk = nums.count - k
            // 因为会进行排序，就用mNums接收
            var mNums = nums
            
            func swap(_ i: Int , _ j: Int) {
                (mNums[i], mNums[j]) = (mNums[j], mNums[i])
            }
            
            /* 切分元素 */
            func partition(_ l: Int , _ h: Int) -> Int {
                var i = l, j = h + 1
                // 二路排序算法
                while true {
                    i += 1
                    // nums[l] 作为比较的基准点
                    // 找到小于nums[l]的值所在的最大下标
                    while mNums[i] < mNums[l] && i < h {
                        i += 1
                    }
                    j -= 1
                    // 找到大于nums[l]的值所在的最小下标
                    while mNums[j] > mNums[l] && j > l {
                        j -= 1
                    }
                    if i >= j {
                        break
                    }
                    swap(i, j)
                }
                
                swap(l, j)
                return j
            }
            
            func findKthSmallest(_ k: Int) {
                var l = 0, h = mNums.count - 1
                while l < h {
                    // 查找切分点
                    let j = partition(l, h)
                    if j == k {
                        break
                    }
                    else if j > k {
                        h = j - 1
                    }
                    else {
                        l = j + 1
                    }
                }
            }
            
            findKthSmallest(kk)
            return mNums[kk]
        }
        
        // 桶排序
        // MARK: 出现频率最多的 k 个元素
        // https://leetcode-cn.com/problems/top-k-frequent-elements/description/
        func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
            // 存储值和频率的对应表
            var frequencyForNum = Dictionary<Int, Int>.init(minimumCapacity: nums.count)
            var maxFrequency = 0
            for num in nums {
                frequencyForNum[num, default: 0] += 1
                maxFrequency = max(maxFrequency, frequencyForNum[num]!)
            }
            
            //设置若干个桶，每个桶存储出现频率相同的数。桶的下标表示数出现的频率，即第 i 个桶中存储的数出现的频率为 i
            // 下标代表频率，值代表原值
            var buckets = Array<[Int]>(repeating: [Int](),
                                       count: maxFrequency + 1)
            for (value, frequency) in frequencyForNum {
                buckets[frequency].append(value)
            }
            
            // 把数都放到桶之后，从后向前遍历桶，最先得到的 k 个数就是出现频率最多的的 k 个数
            var topK = Array<Int>()
            for bucket in buckets.reversed() {
                if topK.count >= k {
                    break
                }
                if bucket.isEmpty {
                    continue
                }
                let remindCount = k - topK.count
                if bucket.count <= remindCount {
                    topK.append(contentsOf: bucket)
                }
                else {
                    topK.append(contentsOf: bucket[0..<remindCount])
                }
            }
            return topK
        }
        
        // MARK: 按照字符出现次数对字符串排序
        // https://leetcode-cn.com/problems/sort-characters-by-frequency/description/
        func frequencySort(_ s: String) -> String {
            let sChars = Array(s)
            var frequencyForNum = Dictionary<Character, Int>.init(minimumCapacity: sChars.count)
            // 存储每个字符出现的频率
            for c in sChars {
                frequencyForNum[c, default: 0] += 1
            }
            // 翻转，第i个位置，存储出现i次的数据的数组
            var buckets = Array<[Character]>(repeating: [], count: sChars.count + 1)
            for (value, frequency) in frequencyForNum {
                buckets[frequency].append(value)
            }
            
            var frequencyStr = Array<Character>()
            for i in stride(from: buckets.count - 1, through: 0, by: -1) {
                let bucket = buckets[i]
                if bucket.isEmpty {
                    continue
                }
                for ch in bucket {
                    for _ in 0..<i {
                        frequencyStr.append(ch)
                    }
                }
            }
            return String(frequencyStr)
        }
        
        // MARK: 荷兰国旗问题
        // https://leetcode-cn.com/problems/sort-colors/description/
        // 在三向切分快速排序中，每次切分都将数组分成三个区间：小于切分元素、等于切分元素、大于切分元素，
        // 而该算法是将数组分成三个区间：等于红色、等于白色、等于蓝色
        func sortColors(_ nums: inout [Int]) {
            func swap(_ i: Int , _ j: Int) {
                (nums[i], nums[j]) = (nums[j], nums[i])
            }
            
            var zero = -1, one = 0, two = nums.count
            while (one < two) {
                if nums[one] == 0 {
                    zero += 1
                    swap(zero, one)
                    one += 1
                }
                else if nums[one] == 2 {
                    two -= 1
                    swap(two, one)
                }
                else {
                    one += 1
                }
            }
        }
    }
}
