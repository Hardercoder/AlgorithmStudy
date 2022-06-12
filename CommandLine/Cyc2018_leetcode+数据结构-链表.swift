//
//  Cyc2018_leetcode+x.swift
//  CommandLine
//
//  Created by unravel on 2022/4/14.
//

import Foundation
extension Cyc2018_leetcode {
    class DataStructure_LinkList {
        // MARK: 找出两个链表的交点，没有则返回nil
        // https://leetcode-cn.com/problems/intersection-of-two-linked-lists/description/
        func getIntersectionNode(_ headA: ListNode?,
                                 _ headB: ListNode?) -> ListNode? {
            var l1 = headA, l2 = headB
            // 这里使用地址比较
            while l1 !== l2 {
                l1 = l1 == nil ? headB : l1!.next
                l2 = l2 == nil ? headA : l2!.next
            }
            return l1
        }
        
        // MARK: 链表反转，使用递归和头插法
        // https://leetcode-cn.com/problems/reverse-linked-list/description/
        // 递归法
        func reverseList(_ head: ListNode?) -> ListNode? {
            if head == nil || head!.next == nil {
                return head
            }
            let next = head!.next
            
            let newHead = reverseList(next)
            
            next!.next = head
            head!.next = nil
            
            return newHead
        }
        
        // 头插法
        func reverseList2(_ head: ListNode?) -> ListNode? {
            let newHead = ListNode(-1)
            var node = head
            while node != nil {
                let next = node!.next
                
                node!.next = newHead.next
                newHead.next = node
                
                node = next
            }
            return newHead.next
        }
        
        // MARK:  归并两个有序的链表，使用递归和双指针
        // https://leetcode-cn.com/problems/merge-two-sorted-lists/description/
        // 递归法
        func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
            if l1 == nil { return l2 }
            if l2 == nil { return l1 }
            if l1!.val < l2!.val {
                l1!.next = mergeTwoLists(l1!.next, l2)
                return l1
            }
            else {
                l2!.next = mergeTwoLists(l1, l2!.next)
                return l2
            }
        }
        
        // 双指针法
        func mergeTwoLists2(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
            let newListNode:ListNode? = ListNode(-1)
            var curListNode = newListNode
            
            var curListNode1 = l1, curListNode2 = l2
            while curListNode1 !== nil &&
                    curListNode2 !== nil {
                if curListNode1!.val <= curListNode2!.val {
                    curListNode?.next = curListNode1
                    curListNode1 = curListNode1?.next
                }
                else {
                    curListNode?.next = curListNode2
                    curListNode2 = curListNode2?.next
                }
                curListNode = curListNode?.next
            }
            curListNode?.next = curListNode1 === nil ? curListNode2 : curListNode1
            return newListNode?.next
        }
        
        // MARK: 从有序链表中删除重复节点，使用递归和遍历
        // https://leetcode-cn.com/problems/remove-duplicates-from-sorted-list/description/
        func deleteDuplicates(_ head: ListNode?) -> ListNode? {
            if head === nil ||
                head!.next === nil {
                return head
            }
            head!.next = deleteDuplicates(head!.next)
            return head!.val == head!.next!.val ? head!.next : head
        }
        
        // 遍历删除法
        func deleteDuplicates2(_ head: ListNode?) -> ListNode? {
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
        
        // MARK: 删除链表的倒数第 n 个节点
        // 例：1->2->3->4->5，n = 2。返回1->2->3->5。
        // 注意：给定 n 的长度小于等于链表的长度。
        // https://leetcode-cn.com/problems/remove-nth-node-from-end-of-list/description/
        func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
            var fast = head, mutN = n
            while mutN > 0 && fast !== nil {
                fast = fast!.next
                mutN -= 1
            }
            
            if fast === nil {
                return head?.next
            }
            
            var slow = head
            while fast!.next !== nil {
                fast = fast!.next
                slow = slow!.next
            }
            slow!.next = slow!.next!.next
            return head
        }
        
        // MARK: 交换链表中的相邻结点
        // https://leetcode-cn.com/problems/swap-nodes-in-pairs/description/
        func swapPairs(_ head: ListNode?) -> ListNode? {
            if head === nil ||
                head?.next === nil {
                return head
            }
            // 哨兵节点
            let node:ListNode? = ListNode()
            node!.next = head
            var pre = node
            
            // 保证有两个相邻的节点
            while pre!.next !== nil &&
                    pre!.next!.next !== nil {
                // 下一个节点和下下个节点
                let l1 = pre!.next, l2 = pre!.next!.next
                let next = l2!.next
                // 交换
                l1!.next = next
                l2!.next = l1
                pre!.next = l2
                
                pre = l1
            }
            return node!.next
        }
        
        // MARK: 链表求和
        // https://leetcode-cn.com/problems/add-two-numbers-ii/description/
        func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
            // 根据链表构建栈结构
            func buildStack(_ l: ListNode?) -> Stack<Int> {
                var stack = Stack<Int>()
                var node = l
                while node !== nil {
                    stack.push(node!.val)
                    node = node!.next
                }
                return stack
            }
            
            // 链表形成的栈
            var l1Stack = buildStack(l1), l2Stack = buildStack(l2)
            
            var head = ListNode(-1), carry = 0
            // 进行不断的弹栈处理
            while !l1Stack.isEmpty ||
                    !l2Stack.isEmpty ||
                    carry != 0 {
                
                let x = l1Stack.isEmpty ? 0 : l1Stack.pop()!
                let y = l2Stack.isEmpty ? 0 : l2Stack.pop()!
                // 计算 某位加起来的和
                let sum = x + y + carry
                // 创建节点
                let node = ListNode(sum % 10)
                // 插入到前面
                node.next = head.next
                head.next = node
                // 保存是否需要借位
                carry = sum / 10
            }
            
            return head.next
        }
        
        // MARK: 判断一个链表是否是回文链表
        // https://leetcode-cn.com/problems/palindrome-linked-list/description/
        // 切成两半，把后半段反转，然后比较两半是否相等
        func isPalindrome(_ head: ListNode?) -> Bool {
            if head === nil ||
                head?.next === nil {
                return true
            }
            
            func cut(_ h1: ListNode?, _ cutNode: ListNode?) -> ListNode? {
                var cutH1 = h1, cutNode = cutH1
                while cutNode?.next !== cutNode {
                    cutNode = cutNode?.next
                }
                cutNode?.next = nil
                return cutH1
            }
            
            func reverse(_ h2: ListNode?) -> ListNode? {
                let newHead: ListNode = ListNode()
                var h2Node = h2
                while h2Node != nil {
                    let nextNode = h2Node!.next
                    h2Node!.next = newHead.next
                    newHead.next = h2Node
                    h2Node = nextNode
                }
                return newHead.next
            }
            
            func isEqual(_ l1: ListNode?, _ l2: ListNode?) -> Bool {
                var l1Node = l1, l2Node = l2
                while l1Node != nil && l2Node != nil {
                    if l1Node!.val != l2Node!.val {
                        return false
                    }
                    l1Node = l1Node!.next
                    l2Node = l2Node!.next
                }
                return true
            }
            
            var slow = head, fast = head!.next
            while fast !== nil && fast!.next !== nil {
                slow = slow!.next
                fast = fast!.next!.next
            }
            
            if fast !== nil {
                // 偶数节点，让 slow 指向下一个节点
                slow = slow?.next
            }
            
            let leftHalf = cut(head, slow)
            return isEqual(leftHalf, reverse(slow))
        }
        
        func isPalindrome2(_ head: ListNode?) -> Bool {
            if head === nil ||
                head?.next === nil {
                return true
            }
            var preHalfStack = Stack<Int>()
            
            var slow = head, fast = head!.next
            
            while fast !== nil && fast!.next !== nil {
                preHalfStack.push(slow!.val)
                
                slow = slow!.next
                fast = fast!.next!.next
            }
            
            if fast !== nil {
                // 偶数节点，让 slow 指向下一个节点
                preHalfStack.push(slow!.val)
            }
            slow = slow?.next
            
            while slow !== nil {
                let v = preHalfStack.pop()
                if v != nil && slow!.val != v! {
                    return false
                }
                slow = slow?.next
            }
            return true
        }
        
        // MARK: 分隔链表为k个小链表
        // https://leetcode-cn.com/problems/split-linked-list-in-parts/description/
        func splitListToParts(_ root: ListNode?, _ k: Int) -> [ListNode?] {
            // 获取节点的总数量
            var N = 0, cur = root
            while cur != nil {
                N += 1
                cur = cur!.next
            }
            
            var ret = [ListNode?](repeating: nil, count: k)
            // 分隔成k个小块，前面的mod个小块会比后面的小块多一个
            let size = N / k
            var mod = N % k
            // 重新遍历分块
            cur = root
            for i in 0..<k {
                if cur != nil {
                    // 指定单个小表的表头
                    ret[i] = cur
                    // 好吧，加法比三元运算符优先级高
                    let curSize = size + (mod > 0 ? 1 : 0)
                    mod -= 1
                    for _ in 0..<(curSize - 1) {
                        cur = cur!.next
                    }
                    // 记录下一块开始的指针，并将本次指针置为nil
                    let next = cur!.next
                    cur!.next = nil
                    cur = next
                }
                else {
                    break
                }
            }
            return ret
        }
        
        // MARK: 链表元素按奇偶聚集
        // https://leetcode-cn.com/problems/odd-even-linked-list/description/
        func oddEvenList(_ head: ListNode?) -> ListNode? {
            if head == nil {
                return head
            }
            // 有两个表头 head奇数表头，evenHead偶数表头
            // 两个节点两个节点的往下走
            var odd = head,
                even = head!.next,
                evenHead = even
            while even != nil &&
                    even!.next != nil {
                // 1,3,5
                odd!.next = odd!.next!.next
                odd = odd!.next
                // 2，4，6
                even!.next = even!.next!.next
                even = even!.next
            }
            // 将偶数表头，挂载到奇数表头之后
            odd!.next = evenHead
            return head
        }
        
        // MARK: K个一组反转链表
        // https://leetcode-cn.com/problems/reverse-nodes-in-k-group/
        func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
            // 头插法反转链表
            func reverse(_ hd: ListNode?) -> ListNode? {
                var pre: ListNode? = nil, curr = hd
                while curr != nil {
                    let next = curr!.next
                    
                    curr!.next = pre
                    pre = curr
                    
                    curr = next
                }
                return pre
            }
            
            // 哨兵节点
            let dummy: ListNode? = ListNode(0)
            dummy!.next = head
            var pre = dummy, end = pre
            
            while end!.next != nil {
                // 获取一个k分组
                for _ in 0..<k {
                    end = end?.next
                }
                // 不足k就可以返回结果了
                if end == nil {
                    return dummy!.next
                }
                // start和end之间是需要反转的子链表
                // pre是start的上一个阶段，next是end的下一个阶段，主要用于衔接被翻转的子链表
                // next指向下一个要反转的子链表的头，把指针保存下来
                let start = pre!.next, next = end!.next
                // 将start到end切断成一个单独的子链表
                end!.next = nil
                // 对 start到end的子链表进行翻转，并挂载到pre!.next
                pre!.next = reverse(start)
                // 经过reverse方法，此时start指针已经指向子链表尾部
                start?.next = next
                pre = start
                end = pre
            }
            return dummy!.next
        }
    }
}
