//
//  Cyc2018_leetcode+LinkList.swift
//  CommandLine
//
//  Created by unravel on 2022/2/28.
//

import Foundation
extension Cyc2018_swordOffer {
    class Cyc2018_swordOffer_LinkList {
        // MARK: 从尾到头打印链表
        // https://leetcode.cn/problems/cong-wei-dao-tou-da-yin-lian-biao-lcof/submissions/
        // 思想:  递归法
        func printListFromTailToHead1(_ listNode:ListNode?) -> [Int] {
            var ret = [Int]()
            if listNode != nil {
                ret.append(contentsOf: printListFromTailToHead1(listNode!.next))
                ret.append(listNode!.val)
            }
            return ret
        }
        
        // 思想: 先翻转链表，然后遍历链表输出
        func printListFromTailToHead2(_ listNode:ListNode?) -> [Int] {
            var mListNode = listNode
            var head:ListNode? = ListNode(-1)
            while mListNode != nil {
                let memo = mListNode!.next
                mListNode?.next = head!.next
                head!.next = mListNode
                mListNode = memo
            }
            
            var ret = [Int]()
            head = head!.next
            while head != nil {
                ret.append(head!.val)
                head = head!.next
            }
            return ret
        }
        
        func reversePrint(_ head: ListNode?) -> [Int] {
            var stack = [Int](), node = head
            while node != nil {
                stack.append(node!.val)
                node = node!.next
            }
            return stack.reversed()
        }
        
        // MARK: 在 O(1) 时间内删除链表节点
        // 思想:
        // 1. 若这个节点有后序节点，就伪装成它的下一个节点，并把它下一个节点删除；
        // 2. 若它是最后的节点，就需要遍历链表，找到它的上一个节点，然后把它删除
        func deleteNode(_ head:ListNode?,
                        tobeDelete: ListNode?) -> ListNode? {
            if head == nil || tobeDelete == nil {
                return head
            }
            var nHead = head
            if tobeDelete!.next != nil {
                // 要删除的节点不是尾节点
                let next = tobeDelete!.next
                tobeDelete!.val = next!.val
                tobeDelete!.next = next!.next
            }
            else {
                if nHead === tobeDelete {
                    nHead = nil
                }
                else {
                    var cur = nHead
                    while !(cur?.next === tobeDelete) {
                        cur = cur?.next
                    }
                    cur?.next = nil
                }
            }
            
            return nHead
        }
        
        // MARK: 删除链表中重复的结点
        // https://leetcode.cn/problems/remove-duplicates-from-sorted-list/
        // 思想:  递归法
        func deleteDuplication(_ pHead: ListNode?) -> ListNode? {
            if pHead == nil || pHead!.next == nil {
                return pHead
            }
            var next = pHead!.next
            if pHead!.val == next!.val {
                // 处理重复多个值连续相同的情况
                while next != nil && pHead!.val == next!.val {
                    next = next!.next
                }
                return deleteDuplication(next)
            }
            else {
                pHead!.next = deleteDuplication(pHead!.next)
                return pHead
            }
        }
        
        // 一次遍历
        func deleteDuplicates(_ head: ListNode?) -> ListNode? {
            var cur = head
            while cur !== nil && cur!.next !== nil {
                if cur!.val == cur!.next!.val {
                    cur!.next = cur!.next!.next
                }
                else {
                    cur = cur!.next
                }
            }
            return head
        }
        
        // MARK: 链表中倒数第K个结点
        // https://leetcode.cn/problems/lian-biao-zhong-dao-shu-di-kge-jie-dian-lcof/
        // 思想:  使用两个指针，一个从第K个位置，一个从头，当第K个位置的指针到到链表末尾时，第二个指针到达倒数第k个位置
        func findKthToTail(_ head: ListNode?, _ k: Int) -> ListNode? {
            if head == nil {
                return nil
            }
            var numK = k
            // 往后数k个，若最后k>0，证明链表元素数量小于k
            var p1 = head
            while p1 != nil && numK > 0 {
                numK -= 1
                p1 = p1?.next
            }
            if numK > 0 {
                return nil
            }
            
            var p2 = head
            while p1 != nil {
                p1 = p1?.next
                p2 = p2?.next
            }
            return p2
        }
        
        func getKthFromEnd(_ head: ListNode?, _ k: Int) -> ListNode? {
            var faster = head, slower = head
            for _ in 0..<k {
                faster = faster?.next
            }
            
            while faster != nil {
                faster = faster!.next
                slower = slower!.next
            }
            return slower
        }
        
        // MARK: 链表中环的入口结点
        // https://leetcode.cn/problems/c32eOV/
        func entryNodeOfLoop(_ pHead: ListNode?) -> ListNode? {
            if pHead == nil || pHead?.next == nil {
                return nil
            }
            // 寻找相遇点
            var slow = pHead, fast = pHead
            repeat {
                fast = fast?.next?.next
                slow = slow?.next
            } while slow !== fast
            
            // 分别从相遇点和起点同步走，最后会在入口点相遇
            fast = pHead
            while !(slow === fast) {
                slow = slow?.next
                fast = fast?.next
            }
            return slow
        }
        
        func detectCycle(_ head: ListNode?) -> ListNode? {
            var fast = head, slow = head
            
            // fast比slow多跑N圈之后，在环入口点相遇
            repeat {
                fast = fast?.next?.next
                slow = slow?.next
            } while fast !== slow
            
            // 如果跑到最后依然没有相遇，说明没有环
            if fast == nil {
                return nil
            }
            
            // fast重置，大家再一步一步的走，在环入口点相遇
            fast = head
            while fast !== slow {
                fast = fast?.next
                slow = slow?.next
            }
            return slow
        }
        
        // MARK: 反转链表
        // https://leetcode.cn/problems/fan-zhuan-lian-biao-lcof/
        // 思想:  递归
        func reverseList(_ head: ListNode?) -> ListNode? {
            if head == nil || head?.next == nil {
                return head
            }
            let next = head?.next
            head?.next = nil
            let newHead = reverseList(next)
            next?.next = head
            return newHead
        }
        
        // 思想:  头插法
        func reverseList2(_ head: ListNode?) -> ListNode? {
            var nHead: ListNode? = nil
            var curNode = head
            while curNode != nil {
                // 存储下一个节点
                let next = curNode?.next
                // 将当前节点的next，之前构建的头节点
                curNode?.next = nHead
                // 构建的头节点指向当前节点
                nHead = curNode
                // 当前节点往下走
                curNode = next
            }
            return nHead
        }
        
        // MARK: 反转链表 II
        // https://leetcode.cn/problems/reverse-linked-list-ii/
        func reverseBetween(_ head: ListNode?,
                            _ left: Int,
                            _ right: Int) -> ListNode? {
            let dummyNode = ListNode()
            dummyNode.next = head
            var pre: ListNode? = dummyNode
            for _ in 0..<(left-1) {
                pre = pre?.next
            }
            
            var cur = pre?.next, next: ListNode? = nil
            for _ in left..<right {
                next = cur?.next
                cur?.next = next?.next
                next?.next = pre?.next
                pre?.next = next
            }
            return dummyNode.next
        }
        
        // MARK: 合并两个排序的链表
        // https://leetcode.cn/problems/he-bing-liang-ge-pai-xu-de-lian-biao-lcof/
        // 思想:  双指针同时遍历两个链表，其中一个遍历完成时，直接挂载另一个即可
        func merge(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
            let nHead: ListNode? = ListNode(1)
            var cur = nHead
            // 链表1和2的当前遍历的节点
            var curList1Node = list1
            var curList2Node = list2
            while curList1Node != nil &&
                    curList2Node != nil {
                if curList1Node!.val <= curList2Node!.val {
                    cur!.next = curList1Node
                    curList1Node = curList1Node!.next
                }
                else {
                    cur!.next = curList2Node
                    curList2Node = curList2Node!.next
                }
                cur = cur!.next
            }
            if curList1Node != nil {
                cur!.next = curList1Node
            }
            
            if curList2Node != nil {
                cur!.next = curList2Node
            }
            return nHead!.next
        }
        
        //  MARK: 合并两个有序数组
        // 核心思想：双指针
        func mergeTwoArray(array1: [Int], array2: [Int]) -> [Int] {
            let array1Count = array1.count, array2Count = array2.count
            var i = 0, j = 0
            
            var retArray = Array(repeating: 0, count: array1Count + array2Count)
            while i < array1Count && j < array2Count {
                
                if array1[i] < array2[j] {
                    retArray[i + j] = array1[i]
                    i += 1
                }
                else {
                    retArray[i + j] = array1[j]
                    j += 1
                }
            }
            
            // 下面这两个条件其实是互斥的
            if i < array1Count {
                retArray += array1[i...]
            }
            
            if j < array2Count {
                retArray += array1[j...]
            }
            
            return retArray
        }
        
        // MARK: 复杂链表的复制
        // https://leetcode.cn/problems/fu-za-lian-biao-de-fu-zhi-lcof/
        func cloneComplexList(_ pHead: RandomListNode?) -> RandomListNode? {
            if pHead == nil {
                return nil
            }
            
            // 插入新节点 在每个节点的后面插入复制的节点
            var cur = pHead
            while cur != nil {
                let clone = RandomListNode(cur!.label)
                clone.next = cur!.next
                cur!.next = clone
                cur = clone.next
            }
            
            // 建立 random 链接 对复制节点的 random 链接进行赋值
            cur = pHead
            while cur != nil {
                let clone = cur!.next
                if cur!.random != nil {
                    // 取指向的random clone
                    clone?.random = cur!.random?.next
                }
                cur = clone?.next
            }
            
            // 拆分
            cur = pHead
            let pCloneHead = pHead?.next
            while cur?.next != nil {
                let next = cur?.next
                cur?.next = next?.next
                cur = next
            }
            
            return pCloneHead
        }
        
        // MARK:  两个链表的第一个公共结点
        // https://leetcode.cn/problems/liang-ge-lian-biao-de-di-yi-ge-gong-gong-jie-dian-lcof/
        // 思想：  使用两个指针分别跑两个链表，跑完一个之后切过去跑另一个，这样他们就会在交点相遇a + c + b = b + c + a
        func findFirstCommonNode(_ pHead1: ListNode?, _ pHead2: ListNode?) -> ListNode? {
            var l1 = pHead1, l2 = pHead2
            while l1 !== l2 {
                l1 = (l1 == nil) ? pHead2 : l1?.next
                l2 = (l2 == nil) ? pHead1 : l2?.next
            }
            return l1
        }
    }
}
