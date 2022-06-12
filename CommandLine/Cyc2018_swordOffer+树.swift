//
//  Cyc2018_swordOffer+Tree.swift
//  CommandLine
//
//  Created by unravel on 2022/2/28.
//

import Foundation
extension Cyc2018_swordOffer {
    class Cyc2018_swordOffer_Tree {
        // MARK: 重建二叉树
        // https://leetcode.cn/problems/zhong-jian-er-cha-shu-lcof/
        // 前序遍历的第一个值为根节点的值，使用这个值将中序遍历结果分成两部分
        // 左部分为树的左子树中序遍历结果，右部分为树的右子树中序遍历的结果。
        public func reConstructBinaryTree(_ preVisit: [Int],
                                          _ inVisit: [Int]) -> TreeNode? {
            var indexForInOrders = [Int: Int]()
            for (ind, val) in inVisit.enumerated() {
                indexForInOrders[val] = ind
            }
            
            func reConstructBinaryTree(_ preL: Int,
                                       _ preR: Int,
                                       _ inL: Int) -> TreeNode? {
                if preL > preR {
                    return nil
                }
                // 根节点的值
                let rootNodeVal = preVisit[preL]
                // 使用各节点的值，构建根树
                let root = TreeNode(rootNodeVal)
                // 中序遍历的下标，也可以代表左右子树的分隔点
                let inIndex = indexForInOrders[rootNodeVal]!
                // 左子树中的节点在数组中的长度
                let leftTreeSize = inIndex - inL
                root.left = reConstructBinaryTree(preL + 1,
                                                  preL + leftTreeSize,
                                                  inL)
                root.right = reConstructBinaryTree(preL + leftTreeSize + 1,
                                                   preR,
                                                   inIndex + 1)
                return root
            }
            return reConstructBinaryTree(0,
                                         preVisit.count - 1,
                                         0)
        }
        
        // MARK: 中序遍历下，二叉树的下一个结点
        // https://www.nowcoder.com/practice/9023a0c988684a53960365b889ceaf5e?tpId=13&tqId=11210&tPage=1&rp=1&ru=/ta/coding-interviews&qru=/ta/coding-interviews/question-ranking&from=cyc_github
        // 一个节点的右子树不为空时，它的下一个节点为 右子树的最左子节点；
        // 右子树为空的情况下，它的下一个节点是 父节点的左子节点为它自身的节点
        func nextTree(_ pNode: TreeNode?) -> TreeNode? {
            var curNode = pNode
            if curNode?.right != nil {
                var node = curNode!.right
                while node?.left != nil {
                    node = node?.left
                }
                return node
            }
            else {
                while curNode?.parent != nil {
                    let parent = curNode?.parent
                    if parent?.left === curNode {
                        return parent
                    }
                    curNode = curNode?.parent
                }
            }
            return nil
        }
        
        // MARK: 树的子结构
        // 思想:  递归方法。单子是一个只有两个节点的2层树是否相等
        // https://leetcode.cn/problems/shu-de-zi-jie-gou-lcof/
        func isSubStructure(_ root1: TreeNode?, _ root2: TreeNode?) -> Bool {
            return Cyc2018_leetcode.DataStructure_Tree().isSubtree(root1, root2)
        }
        
        // MARK: 二叉树的镜像
        // 思想:  采用递归翻转二叉树。单子是一个二层数的翻转
        func mirror(_ root: TreeNode?) {
            _ = Cyc2018_leetcode.DataStructure_Tree().invertTree(root)
        }
        
        // MARK: 对称的二叉树
        func isSymmetrical(_ pRoot: TreeNode?) -> Bool {
            return Cyc2018_leetcode.DataStructure_Tree().isSymmetric(pRoot)
        }
        
        // MARK: 从上往下打印二叉树
        // 不需要使用两个队列分别存储当前层的节点和下一层的节点，因为在开始遍历一层的节点时，当前队列中的节点数就是当前层的节点数，
        // 只要控制遍历这么多节点数，就能保证这次遍历的都是当前层的节点
        func printFromTopToBottom(_ root: TreeNode?) -> [Int] {
            var queue = Array<TreeNode>()
            var ret = [Int]()
            if root == nil {
                return ret
            }
            queue.append(root!)
            
            while !queue.isEmpty {
                let tNode = queue.removeFirst()
                ret.append(tNode.val)
                if tNode.left != nil {
                    queue.append(tNode.left!)
                }
                if tNode.right != nil {
                    queue.append(tNode.right!)
                }
            }
            return ret
        }
        
        // MARK: 把二叉树打印成多行
        func printFromTopToBottomPerLine(_ root: TreeNode?) -> [[Int]] {
            var queue = Queue<TreeNode>()
            var ret = [[Int]]()
            if root == nil {
                return ret
            }
            queue.enqueue(root!)
            
            while !queue.isEmpty {
                let cnt = queue.count
                var list = [Int](repeating: 0, count: cnt)
                var ind = 0
                while ind < cnt {
                    let tNode = queue.dequeue()!
                    list[ind] = tNode.val
                    ind += 1
                    if tNode.left != nil {
                        queue.enqueue(tNode.left!)
                    }
                    if tNode.right != nil {
                        queue.enqueue(tNode.right!)
                    }
                }
                
                if list.count > 0 {
                    ret.append(list)
                }
            }
            return ret
        }
        
        // MARK: 按之字形顺序打印二叉树
        func printFromTopToBottomZhi(_ root: TreeNode?) -> [[Int]] {
            var queue = Array<TreeNode>()
            var ret = [[Int]]()
            if root == nil {
                return ret
            }
            queue.append(root!)
            
            var reverse = false
            while !queue.isEmpty {
                var list = [Int]()
                var cnt = queue.count
                while cnt > 0 {
                    cnt -= 1
                    let tNode = queue.removeFirst()
                    list.append(tNode.val)
                    if tNode.left != nil {
                        queue.append(tNode.left!)
                    }
                    if tNode.right != nil {
                        queue.append(tNode.right!)
                    }
                }
                if reverse {
                    // 翻转
                    list.reverse()
                }
                
                reverse.toggle()
                if list.count > 0 {
                    ret.append(list)
                }
            }
            return ret
        }
        
        // MARK: 二叉搜索树的后序遍历序列
        // 思想:  后序遍历序列中最后一个元素为根元素，左子树的所有元素比它小，右子树的所有元素比它大。利用这一规律进行递归操作
        func verifySquenceOfBST(_ sequence: [Int]) -> Bool {
            if sequence.count == 0 {
                return false
            }
            
            // 后序遍历数组中最后一个元素为根，其中左子树元素都小于根，右子树元素都大于根
            func verifySequence(_ first: Int,
                                _ last: Int) -> Bool {
                if last < first {
                    return true
                }
                let rootVal = sequence[last]
                var cutIndex = first
                // 获取该序列中左子树对应的index
                while cutIndex < last && sequence[cutIndex] <= rootVal {
                    cutIndex += 1
                }
                
                for i in cutIndex..<last {
                    if sequence[i] < rootVal {
                        return false
                    }
                }
                
                return verifySequence(first,
                                      cutIndex - 1) &&
                verifySequence(cutIndex,
                               last - 1)
            }
            return verifySequence(0, sequence.count - 1)
        }
        
        // MARK: 二叉树中和为某一值的路径
        // 思想:  深度优先搜索算法
        func findPath(_ root: TreeNode?, _ target: Int) -> [[Int]] {
//            return Cyc2018_leetcode.DataStructure_Tree().pathSum(root, target)
            var ret = [[Int]]()
            var path = [Int]()
            func backtracking(_ node: TreeNode?, _ t: Int) {
                if node == nil {
                    return
                }
                path.append(node!.val)
                let t1 = t - node!.val
                if t1 == 0 && node!.left == nil && node!.right == nil {
                    ret.append(path)
                }
                else {
                    backtracking(node!.left, t1)
                    backtracking(node!.right, t1)
                }
                path.removeLast()
            }
            backtracking(root, target)
            return ret
        }
        
        // MARK: 二叉搜索树与双向链表
        // 思想:  中序遍历算法，重点在于处理节点的时候
        func convert(_ root: TreeNode?) -> TreeNode? {
            var pre: TreeNode? = nil, head: TreeNode? = nil
            // 中序遍历算法
            func inOrder(_ node: TreeNode?) {
                if node == nil {
                    return
                }
                // 处理左子树
                inOrder(node!.left)
                // 处理节点
                node!.left = pre
                if pre != nil {
                    pre?.right = node
                }
                pre = node
                // 保证head只有一次赋值
                if head == nil {
                    head = node
                }
                // 处理右子树
                inOrder(node?.right)
            }
            
            inOrder(root)
            return head
        }
        
        // MARK: 序列化二叉树
        // 思想:  前序遍历
        func serializeTree(_ root: TreeNode?) -> String {
            if root == nil {
                return "#"
            }
            // 空节点使用#，节点之间使用" "分割
            return "\(root!.val) \(serializeTree(root!.left)) \(serializeTree(root!.right))"
        }
        
        func deserializeTree(fromstr str: String) -> TreeNode? {
            // 先重建根节点，如果是NULL节点，返回。如果是数字节点，递归重建左子树。之后，再重建右子树
            var start = -1
            let strArr:[Substring] = str.split(separator: " ")
            
            func deserialize(_ strArr:[Substring]) -> TreeNode? {
                start += 1
                if start < strArr.count && strArr[start] != "#" {
                    let node = String(strArr[start])
                    let val = Int(node) ?? 0
                    let t = TreeNode(val)
                    t.left = deserialize(strArr)
                    t.right = deserialize(strArr)
                    return t
                }
                return nil
            }
            
            return deserialize(strArr)
        }
        
        // MARK:  二叉搜索树的第K个结点的值
        // 思想：  利用二叉查找树中序遍历有序的特点
        func kthNode(_ pRoot: TreeNode? , _ k: Int) -> Int {
            return Cyc2018_leetcode.DataStructure_Tree().kthSmallest(pRoot, k)
        }
        
        // MARK:  二叉树的深度
        // 思想：  最长的路径
        func treeDepth(_ root: TreeNode?) -> Int {
            return Cyc2018_leetcode.DataStructure_Tree().maxDepth(root)
        }
        
        // MARK: 平衡二叉树
        // 输入一棵二叉树，判断该二叉树是否是平衡二叉树
        // 思想：  平衡二叉树左右子树高度差不超过 1
        func issBalanced_Solution(_ root: TreeNode?) -> Bool {
            return Cyc2018_leetcode.DataStructure_Tree().isBalanced(root)
        }
        
        // MARK: 二叉查找树中两个节点的最低公共祖先
        func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
            return Cyc2018_leetcode.DataStructure_Tree().lowestCommonAncestor(root, p, q)
        }
        
        // MARK: 二叉树中两个节点的最低公共祖先
        func lowestCommonAncestor1(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
            return Cyc2018_leetcode.DataStructure_Tree().lowestCommonAncestor1(root, p, q)
        }
    }
}
