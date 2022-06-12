//
//  main.swift
//  CommandLine
//
//  Created by unravel on 2021/5/12.
//

import Foundation
func testCyc2018Leetcode() {
    // MARK: 双指针
    //    let doublePointer = Cyc2018_leetcode.Think_DoublePointer()
    //    print(doublePointer.twoSum([2, 7, 11, 15], 9))
    //    print(doublePointer.judgeSquareSum(5))
    //    print(doublePointer.reverseVowels("leetcode"))
    //    print(doublePointer.validPalindrome("abca"))
    //    var arr1 = [1, 2, 3]
    //    doublePointer.merge(&arr1, [2, 5, 6])
    //    print(arr1)
    //    let list = ListNode(1, ListNode(2, ListNode(3, ListNode(4,nil))))
    
    //    let secondNode = ListNode(2)
    //    let lastNode = ListNode(5,nil)
    //    let remain = ListNode(3, ListNode(4, lastNode))
    //    secondNode.next = remain
    //    lastNode.next = secondNode
    //    let list = ListNode(1, secondNode)
    //    print(list)
    //    print(doublePointer.hasCycle(list))
    
    //    let s = "abpcplea", d = ["ale", "monkey", "apca", "apep"]
    //    print(doublePointer.findLongestWord(s,d))
    
    // MARK: 排序
    //    let sort = Cyc2018_leetcode.Think_Sort()
    //    let a = [3, 2, 1, 5, 6, 4], k = 2
    //    print(sort.findKthLargest(a, k))
    //    print(sort.findKthLargestQuickSort(a, k))
    
    //    let a = [1, 1, 1, 2, 2, 3], k = 2
    //    print(sort.topKFrequent(a, k))
    
    //    print(sort.frequencySort("tree"))
    //    print(sort.sortColors([2, 0, 2, 1, 1, 0]))
    // MARK: 贪心
    //    let greed = Cyc2018_leetcode.Think_Greed()
    //    print(greed.findContentChildren([1, 3], [1, 2, 4]))
    //    print(greed.eraseOverlapIntervals([(1, 2), (2, 3)]))
    //    print(greed.findMinArrowShots([(10, 16), (2, 8), (1, 6), (7, 12)]))
    //    print(greed.reconstructQueue([(7, 0), (4, 4), (7, 1), (5, 0), (6, 1), (5, 2)]))
    //    print(greed.maxProfit([7,1,5,3,6,4]))
    //    print(greed.maxProfit2([7,1,5,3,6,4]))
    //    print(greed.canPlaceFlowers([1, 0, 0, 0, 1], 1))
    //    print(greed.isSubsequence("abc", "ahbgdc"))
    //    print(greed.checkPossibility([4, 2, 3]))
    //    print(greed.maxSubArray([-2, 1, -3, 4, -1, 2, -5, 4]))
    //    print(greed.maxSubArray([4, -1, 2 ,1]))
    //    print(greed.partitionLabels("ababcbacadefegdehijhklij"))
    // MARK: 二分查找
    //    let binarySearch = Cyc2018_leetcode.Think_BinarySearch()
    //    let nums = [1, 2, 3, 4, 5], key = 3
    //    print(binarySearch.binarySearch(nums, key))
    //    print(binarySearch.mySqrt(8))
    //    print(binarySearch.nextGreatestLetter(["c", "f", "j"], "d"))
    //    print(binarySearch.singleNonDuplicate([1, 1, 2, 3, 3, 4, 4, 8, 8]))
    //    print(binarySearch.firstBadVersion(25))
    //    print(binarySearch.findMin([3, 4, 5, 1, 2]))
    //    print(binarySearch.searchRange([5, 7, 7, 8, 8, 10], 8))
    // MARK: 分治
    //    let conquer = Cyc2018_leetcode.Think_DivideAndConquer()
    //    print(conquer.diffWaysToCompute("2*3-4*5")) // 2-1-1
    //    let binary = conquer.generateTrees(3)
    //    print(binary)
    // MARK: 搜索
    //    let search = Cyc2018_leetcode.Think_Search()
    //    let grids = [[1, 1, 0, 1],
    //                 [1, 0, 1, 0],
    //                 [1, 1, 1, 1],
    //                 [1, 0, 1, 1]]
    //    let grids = [
    //        [0, 1],
    //        [1, 0]
    //    ]
    //    print(search.shortestPathBinaryMatrix(grids))
    //    print(search.numSquares(13))
    // MARK: 链表
    //    let s = Cyc2018_leetcode.DataStructure_LinkList()
    //    let l1 = ListNode(0, ListNode(1, ListNode(2, ListNode(2, ListNode(1, ListNode(0, nil))))))
    //    print(s.isPalindrome(l1))
    
    //    let s1 = ListNode(1, ListNode(2, ListNode(3, ListNode(4, ListNode(5, ListNode(6, ListNode(7, ListNode(8, ListNode(9, ListNode(10))))))))))
    //    print(s.splitListToParts(s1, 3))
    
    //    let l1 = ListNode(1, ListNode(2, ListNode(3, ListNode(4, ListNode(5)))))
    //    print(s.reverseKGroup(l1, 2) ?? "")
    
    //    let algorithm = Cyc2018_leetcode.DataStructure_String()
    //    algorithm.isAnagram("anagram", "nagaram")
    //    print(algorithm.cycInclude("AABCD", "CDAA"))
    //    print(algorithm.cycleMove("abcd123", 3))
    //    print(algorithm.revertWords("I am a student"))
    //    print(algorithm.isIsomorphic("foo", "bar"))
    
    //    let algorithm = Cyc2018_leetcode.DataStructure_ArrayMatrics()
    //    print(algorithm.matrixReshape([[1,2],[3,4]], 1, 4))
    //    algorithm.kthSmallest3([[1,5,9],[10,11,13],[12,13,15]], 8)
    //    algorithm.findErrorNums([2, 3, 3, 5, 4])
    //    print(algorithm.constructArray(5,2))
    
//    let algorithm = Cyc2018_leetcode.Think_Search()
    //    let a = algorithm.ladderLength("hit",
    //                                   "cog",
    //                                   ["hot","dot","dog","lot","log","cog"])
    //    print(algorithm.findCircleNum([[1,1,0],
    //                                   [1,1,0],
    //                                   [0,0,1]]))
    //    algorithm.letterCombinations("239")
//    print(algorithm.restoreIpAddresses2("25525511135"))
//    print(algorithm.combinationSum3(3, 7))
//    var sudo = [["5","3",".",".","7",".",".",".","."],["6",".",".","1","9","5",".",".","."],[".","9","8",".",".",".",".","6","."],["8",".",".",".","6",".",".",".","3"],["4",".",".","8",".","3",".",".","1"],["7",".",".",".","2",".",".",".","6"],[".","6",".",".",".",".","2","8","."],[".",".",".","4","1","9",".",".","5"],[".",".",".",".","8",".",".","7","9"]]
//        .map {
//        rowStr in
//        rowStr.map { Character($0)
//        }
//    }
    
//    algorithm.solveSudoku2(&sudo)
//    print("===", sudo)
//    print(algorithm.solveNQueens(4))
    
//    let algorithm = Cyc2018_leetcode.Think_DynamicPlan()
//    print(algorithm.integerBreak(1))
//    algorithm.longestCommonSubsequence("abcde", "ace")
//    algorithm.canPartition([1,2,5])
//    print(algorithm.canPartition([1, 5, 11, 5]))
//    print(algorithm.findTargetSumWays([100], -200))
//    print(algorithm.findMaxForm(["10","0001","111001","1","0"],
//                          5,
//                          3))
//    algorithm.coinChange([2], 1)
//    algorithm.combinationSum4([10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200,210,220,230,240,250,260,270,280,290,300,310,320,330,340,350,360,370,380,390,400,410,420,430,440,450,460,470,480,490,500,510,520,530,540,550,560,570,580,590,600,610,620,630,640,650,660,670,680,690,700,710,720,730,740,750,760,770,780,790,800,810,820,830,840,850,860,870,880,890,900,910,920,930,940,950,960,970,980,990,111],
//                              999)
//    print(algorithm.minSteps(8))
//    algorithm.maxProfit4_1(0, [1, 3])
    
    
    
    let algorithm = Cyc2018_leetcode.Think_Math()
//    print(algorithm.productExceptSelf([1,2, 3, 4]))
//    print(algorithm.toHex(-1))
//    algorithm.addBinary("1010", "1011")
    print(algorithm.toHex(26))
}

func testCyc2018Swordoffer() {
//    let algorithm = Cyc2018_swordOffer.Cyc2018_swordOffer_ArrayMatrix()
//    algorithm.firstUniqChar("")
//    let algorithm = Cyc2018_swordOffer.Cyc2018_swordOffer_Tree()
//    algorithm.reConstructBinaryTree([3,9,20,15,7],
//                                    [9,3,15,20,7])
    
    
    let algorithm = Cyc2018_swordOffer.Cyc2018_swordOffer_Others()
//    algorithm.print1ToMaxOfNDigits(2)
//    print(algorithm.match(str: "aasdfasdfasdfasdfas", pattern: "aasdf.*asdf.*asdf.*asdf.*s"))
//    print(algorithm.isNumeric2(str: "-123"))
    print(algorithm.getDigitAtIndex(11))
}

func testLeedcode() {
//    let algorithm = Leetcode()
//    algorithm.trap([0,1,0,2,1,0,1,3,2,1,2,1])
//    algorithm.lc_8()
}

func testReviewAlgorithm() {
    //    let algorithm = Algorithm4Review()
}

// Swift 社区收集的算法
func testSwiftCommunityAlgorithm() {
    //    let algorithm = SwiftCommunityLeetcode()
    //    algorithm.uniquePaths(m: 3, 7)
    //    algorithm.minDistance("horse", "ros")
    
    // 验证 == 和 === 区别
    //    let a: ListNode? = nil, b: ListNode? = nil
    //    print(a == b, a === b)
}

//testCyc2018Leetcode()
//testCyc2018Swordoffer()
//testLeedcode()
//testReviewAlgorithm()
//testSwiftCommunityAlgorithm()

//practiceForIn()
//practiceDifference()
//practicePublished()
//practiceMultiParam()
