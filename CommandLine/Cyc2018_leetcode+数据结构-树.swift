//
//  Cyc2018_leetcode+x.swift
//  CommandLine
//
//  Created by unravel on 2022/4/14.
//

import Foundation
extension Cyc2018_leetcode {
    class DataStructure_Tree {
        // MARK: 树的高度
        // https://leetcode-cn.com/problems/maximum-depth-of-binary-tree/description/
        func maxDepth(_ root: TreeNode?) -> Int {
            if root == nil {
                return 0
            }
            // 本层 加 左右子层的最大深度
            return 1 + max(maxDepth(root!.left),
                           maxDepth(root!.right))
        }
        
        // MARK: 判断一棵树是否是平衡树
        // https://leetcode-cn.com/problems/balanced-binary-tree/description/
        func isBalanced(_ root: TreeNode?) -> Bool {
            var balanced = true
            
            // 在计算深度的过程中，设置是否平衡的标识
            @discardableResult
            func maxDepth(_ rt: TreeNode?) -> Int {
                if rt == nil || !balanced {
                    return 0
                }
                let l = maxDepth(rt!.left)
                let r = maxDepth(rt!.right)
                // 子树高度差大于1，则不是平衡二叉树
                if abs(l - r) > 1 {
                    balanced = false
                }
                return max(l, r) + 1
            }
            
            maxDepth(root)
            return balanced
        }
        
        // MARK: 树中两节点之间的最长路径
        // https://leetcode-cn.com/problems/diameter-of-binary-tree/description/
        func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
            var maxDepth = 0
            // 在计算深度的过程中，计算左右子树高度和的最大值
            @discardableResult
            func depth(_ rt: TreeNode?) -> Int {
                if rt == nil {
                    return 0
                }
                let leftDepth = depth(rt!.left)
                let rightDepth = depth(rt!.right)
                // 保存最深层数
                maxDepth = max(maxDepth, leftDepth + rightDepth)
                return max(leftDepth, rightDepth) + 1
            }
            depth(root)
            return maxDepth
        }
        
        // MARK: 翻转二叉树
        // https://leetcode-cn.com/problems/invert-binary-tree/description/
        func invertTree(_ root: TreeNode?) -> TreeNode? {
            if root == nil {
                return root
            }
            // 后面的操作会改变 left的指针，所以先保存下来
            let left = root!.left
            root!.left = invertTree(root!.right)
            root!.right = invertTree(left)
            return root
        }
        
        // MARK: 归并两棵树
        // https://leetcode-cn.com/problems/merge-two-binary-trees/description/
        func mergeTrees(_ root1: TreeNode?,
                        _ root2: TreeNode?) -> TreeNode? {
            guard let t1 = root1, let t2 = root2 else {
                // 如果root1和root2，其中有一颗为空，则返回不为空的那棵树
                return root1 != nil ? root1 : root2
            }
            // 两颗都不为空，则构建 节点和左右子树
            let root = TreeNode(t1.val + t2.val)
            root.left = mergeTrees(t1.left, t2.left)
            root.right = mergeTrees(t1.right, t2.right)
            return root
        }
        
        // MARK: 判断根节点到叶子节点的路径和是否等于一个数
        // https://leetcode-cn.com/problems/path-sum/description/
        func hasPathSum(_ root: TreeNode?,
                        _ targetSum: Int) -> Bool {
            if root == nil {
                return false
            }
            // 判断是否是叶子节点，并且和判断的值相等
            if root!.left == nil &&
                root!.right == nil &&
                root!.val == targetSum {
                return true
            }
            // 判断余下的值是否有相等的节点
            let remind = targetSum - root!.val
            // 判断左右子树
            return hasPathSum(root!.left, remind) ||
            hasPathSum(root!.right, remind)
        }
        
        // MARK: 统计路径和等于一个数的路径 有多少个
        // https://leetcode-cn.com/problems/path-sum-iii/description/
        func pathSum(_ root: TreeNode?, _ targetSum: Int) -> Int {
            if root == nil {
                return 0
            }
            // 判断一个节点，以及它所挂载的子树是否为和
            func pathSumStartWithRoot(_ rt: TreeNode?,
                                      _ sum: Int) -> Int {
                if rt == nil {
                    return 0
                }
                var ret = 0
                // 节点自身和值相等记1
                if rt!.val == sum {
                    ret += 1
                }
                // 剩余值
                let remind = sum - rt!.val
                // 统计这个节点下的左右子树
                ret += pathSumStartWithRoot(rt!.left, remind) + pathSumStartWithRoot(rt!.right, remind)
                return ret
            }
            // 统计根节点和左右子树
            return pathSumStartWithRoot(root, targetSum) +
            pathSum(root!.left, targetSum) +
            pathSum(root!.right, targetSum)
        }
        
        // MARK: 判断一棵树是否是另一棵树的子树
        // https://leetcode-cn.com/problems/subtree-of-another-tree/description/
        func isSubtree(_ root: TreeNode?,
                       _ subRoot: TreeNode?) -> Bool {
            if root == nil {
                return false
            }
            // 判断是不是某个节点的子树
            func isSubtreeWithRoot(_ s: TreeNode?, _ t: TreeNode?) -> Bool {
                // 都为空
                if t == nil && s == nil { return true }
                // 其中一个为空
                if t == nil || s == nil { return false }
                // 都不为空
                if t!.val != s!.val { return false }
                // 递归判断左右子树
                return isSubtreeWithRoot(s!.left, t!.left) && isSubtreeWithRoot(s!.right, t!.right)
            }
            // 判断是否是本树或者左右子树的子树
            return isSubtreeWithRoot(root, subRoot) ||
            isSubtree(root!.left, subRoot) ||
            isSubtree(root!.right, subRoot)
        }
        
        // MARK: 判断一棵树是否对称
        // https://leetcode-cn.com/problems/symmetric-tree/description/
        func isSymmetric(_ root: TreeNode?) -> Bool {
            if root == nil {
                return true
            }
            // 判断两棵树是否互为镜像树
            func isSymmetric(_ t1: TreeNode?, _ t2: TreeNode?) -> Bool {
                // 都 为空
                if t1 == nil && t2 == nil { return true }
                // 有一个 为空
                if t1 == nil || t2 == nil { return false }
                // 都 不为空
                if t1!.val != t2!.val { return false }
                // 判断对应的子树是否是镜像树
                return isSymmetric(t1!.left, t2!.right) && isSymmetric(t1!.right, t2!.left)
            }
            // 判断根节点的左右子树是互为镜像树
            return isSymmetric(root!.left, root!.right)
        }
        
        // MARK: 一棵树的最小深度
        // https://leetcode-cn.com/problems/minimum-depth-of-binary-tree/description/
        func minDepth(_ root: TreeNode?) -> Int {
            if root == nil { return 0 }
            // 计算左右子树的深度
            let left = minDepth(root!.left)
            let right = minDepth(root!.right)
            // 判断左右子树是否已经是
            if left == 0 || right == 0 {
                // 说明已经到了最靠上的一个叶子节点
                return left + right + 1
            }
            return min(left, right) + 1
        }
        
        // MARK: 统计左叶子节点的和
        // https://leetcode-cn.com/problems/sum-of-left-leaves/description/
        func sumOfLeftLeaves(_ root: TreeNode?) -> Int {
            if root == nil { return 0 }
            // 判断左节点是否为叶子节点
            let left = root!.left
            if left != nil && left!.left == nil && left!.right == nil {
                return left!.val + sumOfLeftLeaves(root!.right)
            }
            // 计算左右子树中左叶子节点
            return sumOfLeftLeaves(left) + sumOfLeftLeaves(root!.right)
        }
        
        // MARK: 相同节点值的最大路径长度
        // https://leetcode-cn.com/problems/longest-univalue-path/
        func longestUnivaluePath(_ root: TreeNode?) -> Int {
            var path = 0
            // 递归判断一棵树中 相邻的节点且值相同的 数量
            @discardableResult
            func dfs(_ rt: TreeNode?) -> Int {
                if rt == nil { return 0 }
                let left = dfs(rt!.left)
                let right = dfs(rt!.right)
                // 本节点和左节点相同
                let leftPath = (rt!.left != nil && rt!.left!.val == rt!.val) ? left + 1 : 0
                // 本节点和右节点相同
                let rightPath = (rt!.right != nil && rt!.right!.val == rt!.val) ? right + 1 : 0
                path = max(path, leftPath + rightPath)
                return max(leftPath, rightPath)
            }
            dfs(root)
            return path
        }
        
        // MARK: 间隔遍历
        // https://leetcode-cn.com/problems/house-robber-iii/description/
        func rob(_ root: TreeNode?) -> Int {
            var cache = [TreeNode:Int]()
            func robIn(_ rt: TreeNode?) -> Int {
                if rt == nil { return 0 }
                if cache.keys.contains(rt!) {
                    return cache[rt!]!
                }
                var val1 = rt!.val
                if rt!.left != nil {
                    val1 += robIn(rt!.left!.left) + robIn(rt!.left!.right)
                }
                
                if rt!.right != nil {
                    val1 += robIn(rt!.right!.left) + robIn(rt!.right!.right)
                }
                let val2 = robIn(rt!.left) + robIn(rt!.right)
                let ret = max(val1, val2)
                cache[rt!] = ret
                return ret
            }
            return robIn(root)
        }
        
        func rob2(_ root: TreeNode?) -> Int {
            /*
             每个节点可选择偷或者不偷两种状态，根据题目意思，相连节点不能一起偷
             
             当前节点选择偷时，那么两个孩子节点就不能选择偷了
             当前节点选择不偷时，两个孩子节点只需要拿最多的钱出来就行(两个孩子节点偷不偷没关系)
             
             我们使用一个大小为 2 的数组来表示 int[] res = new int[2] 0 代表不偷，1 代表偷
             任何一个节点能偷到的最大钱的状态可以定义为
             
             当前节点选择不偷：当前节点能偷到的最大钱数 = 左孩子能偷到的钱 + 右孩子能偷到的钱
             当前节点选择偷：当前节点能偷到的最大钱数 = 左孩子选择自己不偷时能得到的钱 + 右孩子选择不偷时能得到的钱 + 当前节点的钱数
             */
            func robInternal(_ rt: TreeNode?) -> (Int, Int) {
                if rt == nil { return (0, 0) }
                
                let left = robInternal(rt!.left)
                let right = robInternal(rt!.right)
                
                var ret = (0, 0)
                // 当前节点选择不偷：当前节点能偷到的最大钱数 = 两个孩子节点只需要拿最多的钱出来就行(两个孩子节点偷不偷没关系)
                ret.0 = max(left.0, left.1) + max(right.0, right.1)
                // 当前节点选择偷：当前节点能偷到的最大钱数 = 左孩子选择自己不偷时能得到的钱 + 右孩子选择不偷时能得到的钱 + 当前节点的钱数
                ret.1 = left.0 + right.0 + rt!.val
                
                return ret
            }
            
            let result = robInternal(root);
            return max(result.0, result.1)
        }
        
        // MARK: 找出二叉树中第二小的节点
        // 二叉树根节点的值即为所有节点中的最小值，对于二叉树中的任意节点 xx，xx 的值不大于以 xx 为根的子树中所有节点的值
        // https://leetcode-cn.com/problems/second-minimum-node-in-a-binary-tree/description/
        func findSecondMinimumValue(_ root: TreeNode?) -> Int {
            // 节点自身为空
            if root == nil { return -1 }
            // 节点左右孩子为空，即该节点为叶子节点
            if root!.left == nil && root!.right == nil { return -1 }
            let rootVal = root!.val
            var leftVal = root!.left!.val, rightVal = root!.right!.val
            if leftVal == rootVal {
                // 如果左子节点的值和根节点相同，说明第二小的在左子树
                leftVal = findSecondMinimumValue(root!.left)
            }
            if rightVal == rootVal {
                // 如果右子节点的值和根节点相同，说明第二小的在右子树
                rightVal = findSecondMinimumValue(root!.right)
            }
            // 如果不都为-1，说明找到了第二小的值
            if leftVal != -1 && rightVal != -1 {
                return min(leftVal, rightVal)
            }
            if leftVal != -1 {
                return leftVal
            }
            return rightVal
        }
        
        // MARK:  一棵树每层节点的平均数
        // https://leetcode-cn.com/problems/average-of-levels-in-binary-tree/submissions/
        func averageOfLevels(_ root: TreeNode?) -> [Double] {
            var ret = [Double]()
            if root == nil { return ret }
            var queue = Array<TreeNode>()
            queue.append(root!)
            while !queue.isEmpty {
                let cnt = queue.count
                var sum = 0
                for _ in 0..<cnt {
                    let node = queue.removeFirst()
                    sum += node.val
                    if node.left != nil {
                        queue.append(node.left!)
                    }
                    if node.right != nil {
                        queue.append(node.right!)
                    }
                }
                ret.append(Double(sum)/Double(cnt))
            }
            return ret
        }
        
        // MARK: 得到左下角的节点
        // https://leetcode-cn.com/problems/find-bottom-left-tree-value/description/
        func findBottomLeftValue(_ root: TreeNode?) -> Int {
            var queue = Array<TreeNode>()
            var node: TreeNode = root!
            queue.append(node)
            // 先右后左，保证node最后能指向最后一个左节点
            while !queue.isEmpty {
                node = queue.removeFirst()
                if node.right != nil {
                    queue.append(node.right!)
                }
                if node.left != nil {
                    queue.append(node.left!)
                }
            }
            return node.val
        }
        
        // MARK: dfs深度优选搜索，二叉树的前中后序遍历
        func dfs(_ root: TreeNode?) {
            // 前序遍历
            var ret = [Int]()
            func preorder(_ rt: TreeNode?) {
                if rt == nil { return }
                ret.append(rt!.val)
                preorder(rt!.left)
                preorder(rt!.right)
            }
            // 中序遍历
            func inorder(_ rt: TreeNode?) {
                if rt == nil { return }
                preorder(rt!.left)
                ret.append(rt!.val)
                preorder(rt!.right)
            }
            // 后序遍历
            func postorder(_ rt: TreeNode?) {
                if rt == nil { return }
                preorder(rt!.left)
                preorder(rt!.right)
                ret.append(rt!.val)
            }
        }
        
        // MARK: 非递归实现二叉树的前序遍历
        // https://leetcode-cn.com/problems/binary-tree-preorder-traversal/description/
        func preorderTraversal(_ root: TreeNode?) -> [Int] {
            var ret = [Int]()
            
            var stack = Array<TreeNode?>()
            stack.append(root)
            // 开始蹦迪
            while !stack.isEmpty {
                // 取栈顶节点
                let node = stack.removeLast()
                if node == nil { continue }
                
                ret.append(node!.val)
                stack.append(node!.right)
                stack.append(node!.left)
            }
            return ret
        }
        
        // MARK: 非递归实现二叉树的后序遍历
        // 和前序遍历入栈的顺序相反即可
        // https://leetcode-cn.com/problems/binary-tree-postorder-traversal/description/
        func postorderTraversal(_ root: TreeNode?) -> [Int] {
            var ret = [Int]()
            
            var stack = Array<TreeNode?>()
            stack.append(root)
            // 开始蹦迪，最后反转ret
            while !stack.isEmpty {
                let node = stack.removeLast()
                if node == nil { continue }
                
                ret.append(node!.val)
                stack.append(node!.left)
                stack.append(node!.right)
            }
            // 取值要反过来
            return ret.reversed()
        }
        
        // MARK: 非递归实现二叉树的中序遍历
        // https://leetcode-cn.com/problems/binary-tree-inorder-traversal/description/
        func inorderTraversal(_ root: TreeNode?) -> [Int] {
            var ret = [Int]()
            if root == nil { return ret }
            
            var stack = Array<TreeNode?>()
            var cur = root
            
            while cur != nil || !stack.isEmpty {
                // 左子树的左节点不断的进栈
                while cur != nil {
                    stack.append(cur!)
                    cur = cur!.left
                }
                
                let node = stack.removeLast()
                ret.append(node!.val)
                cur = node!.right
            }
            return ret
        }
        
        // MARK: 非递归实现二叉树的前中后序遍历
        func visibTreeByColor(_ root: TreeNode?) -> [Int] {
            // 颜色标记法
            /*
             其核心方法如下：
             标记节点的状态，已访问的节点标记为 1，未访问的节点标记为 0
             遇到未访问的节点，将节点标记为 0，然后根据三序排序的要求，按照特定的顺序入栈
             
             // 前序 中→左→右 按照 右→左→中
             // 中序 左→中→右 按照 右→中→左
             // 后序 左→右→中 按照 中→右→左
             
             结果数组中加入标记为 1 的节点的值
             */
            
            var traversals = [Int]()
            var statck = [(0, root)]
            
            while !statck.isEmpty {
                let (isVisted, node) = statck.removeLast()
                if node == nil {
                    continue
                }
                if isVisted == 0 {
                    //                ///前序遍历
                    //                statck.append((0, node?.right))
                    //                statck.append((0, node?.left))
                    //                statck.append((1, node))
                    //                ///中序遍历
                    //                statck.append((0, node?.right))
                    //                statck.append((1, node))
                    //                statck.append((0, node?.left))
                    ///后序遍历
                    statck.append((1, node))
                    statck.append((0, node?.right))
                    statck.append((0, node?.left))
                }
                else {
                    traversals.append(node!.val)
                }
            }
            return traversals
        }
        
        // MARK: BST  二叉搜索（查找）树
        // MARK: 修剪二叉查找树
        // https://leetcode-cn.com/problems/trim-a-binary-search-tree/description/
        func trimBST(_ root: TreeNode?, _ low: Int, _ high: Int) -> TreeNode? {
            // 通过闭包捕获外面的low和hight
            func trimBSTInner(_ rt: TreeNode?) -> TreeNode? {
                if rt == nil { return rt }
                // 利用搜索树的特点，中间节点大于所有左子树节点，小于所有右子树节点
                // 如果根节点大于hight，说明符合条件的在左子树
                if rt!.val > high {
                    return trimBSTInner(rt!.left)
                }
                // 如果根节点小于low，说明符合条件的在右子树
                if rt!.val < low {
                    return trimBSTInner(rt!.right)
                }
                // 否则剪切左右子树
                rt!.left = trimBSTInner(rt!.left)
                rt!.right = trimBSTInner(rt!.right)
                return rt
            }
            return trimBSTInner(root)
        }
        
        // MARK: 寻找二叉查找树的第 k 个元素
        // https://leetcode-cn.com/problems/kth-smallest-element-in-a-bst/description/
        // 中序遍历解法
        func kthSmallest(_ root: TreeNode?, _ k: Int) -> Int {
            var cnt = 0, val = 0
            // 根据搜索树的特点，利用中序遍历，遍历到第k个点就是需要的值
            func inOrder(_ rt: TreeNode?) {
                if rt == nil { return }
                inOrder(rt!.left)
                cnt += 1
                if cnt == k {
                    val = rt!.val
                    // 退出内层函数
                    return
                }
                inOrder(rt!.right)
            }
            inOrder(root)
            return val
        }
        
        // 递归解法
        func kthSmallest2(_ root: TreeNode?, _ k: Int) -> Int {
            // 计算一颗数的所有节点数量
            func count(_ node: TreeNode?) -> Int {
                if node == nil { return 0 }
                return 1 + count(node!.left) + count(node!.right)
            }
            // 计算左子树的数量
            let leftCnt = count(root?.left)
            // 如果左子树数量和k相等，说明就是root这个值
            if leftCnt == k - 1 {
                return root!.val
            }
            else if leftCnt > k - 1 {
                // 如果左子树的节点数量大于k，说明在左子树中，递归处理左子树
                return kthSmallest(root?.left, k)
            }
            else {
                // 否则，处理剩余的k - leftCnt - 1 个节点
                return kthSmallest(root?.right, k - leftCnt - 1)
            }
        }
        
        // MARK: 把二叉查找树每个节点的值都加上比它大的节点的值
        // https://leetcode-cn.com/problems/convert-bst-to-greater-tree/description/
        func convertBST(_ root: TreeNode?) -> TreeNode? {
            var sum = 0
            // 利用搜索树的特点，进行后续遍历，sum代表后续遍历的所有节点的和
            func traver(_ rt: TreeNode?) {
                if rt == nil { return }
                traver(rt!.right)
                sum += rt!.val
                rt!.val = sum
                traver(rt!.left)
            }
            traver(root)
            return root
        }
        
        // MARK: 二叉查找树的最近公共祖先
        // https://leetcode-cn.com/problems/lowest-common-ancestor-of-a-binary-search-tree/description/
        func lowestCommonAncestor(_ root: TreeNode?,
                                  _ p: TreeNode?,
                                  _ q: TreeNode?) -> TreeNode? {
            if root == nil { return root }
            let rootVal = root!.val
            if rootVal > p!.val &&
                rootVal > q!.val {
                return lowestCommonAncestor(root!.left,
                                            p,
                                            q)
            }
            if rootVal < p!.val &&
                rootVal < q!.val {
                return lowestCommonAncestor(root!.right,
                                            p,
                                            q)
            }
            return root
        }
        
        // MARK:  二叉树的最近公共祖先
        // https://leetcode-cn.com/problems/lowest-common-ancestor-of-a-binary-tree/description/
        func lowestCommonAncestor1(_ root: TreeNode?,
                                   _ p: TreeNode?,
                                   _ q: TreeNode?) -> TreeNode? {
            /*
             终止条件：
             当越过叶节点，则直接返回 null；
             当 root 等于 p, q ，则直接返回 root ；
             */
            if root == nil ||
                root! === p ||
                root! === q { return root }
            let left = lowestCommonAncestor(root!.left,
                                            p,
                                            q)
            let right = lowestCommonAncestor(root!.right,
                                             p,
                                             q)
            if left == nil {
                return right
            }
            if right == nil {
                return left
            }
            return root
        }
        
        // MARK: 从有序数组中构造二叉查找树
        // https://leetcode-cn.com/problems/convert-sorted-array-to-binary-search-tree/description/
        func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
            func toBST(_ sIdx: Int, _ eIdx: Int) -> TreeNode? {
                if sIdx > eIdx { return nil }
                let mIdx = sIdx + (eIdx - sIdx) / 2
                let root = TreeNode(nums[mIdx])
                root.left = toBST(sIdx, mIdx - 1)
                root.right = toBST(mIdx + 1, eIdx)
                return root
            }
            return toBST(0, nums.count - 1)
        }
        
        // MARK: 根据有序链表构造平衡的二叉查找树
        // https://leetcode-cn.com/problems/convert-sorted-list-to-binary-search-tree/description/
        func sortedListToBST(_ head: ListNode?) -> TreeNode? {
            if head == nil { return nil }
            if head!.next == nil { return TreeNode(head!.val) }
            
            // 取链表的中点
            var slow = head!, fast = head!.next
            var preMid = slow
            while fast != nil && fast?.next != nil {
                preMid = slow
                slow = slow.next!
                fast = fast!.next!.next
            }
            
            let mid = preMid.next!
            preMid.next = nil
            
            let t = TreeNode(mid.val)
            t.left = sortedListToBST(head)
            t.right = sortedListToBST(mid.next)
            return t
        }
        
        func sortedListToBST2(_ head: ListNode?) -> TreeNode? {
            var nums = [Int](), node = head
            // 将链表转成有序数组nums
            while node != nil {
                nums.append(node!.val)
                node = node!.next
            }
            
            func toBST(_ sIdx: Int, _ eIdx: Int) -> TreeNode? {
                if sIdx > eIdx { return nil }
                let mIdx = sIdx + (eIdx - sIdx) / 2
                let root = TreeNode(nums[mIdx])
                root.left = toBST(sIdx, mIdx - 1)
                root.right = toBST(mIdx + 1, eIdx)
                return root
            }
            
            return toBST(0, nums.count - 1)
        }
        
        // MARK: 在二叉查找树中寻找两个节点，使它们的和为一个给定值
        // https://leetcode-cn.com/problems/two-sum-iv-input-is-a-bst/description/
        func findTarget(_ root: TreeNode?, _ k: Int) -> Bool {
            var nums = [Int]()
            // 将树转成有序数组nums
            func inOrder(_ rt: TreeNode?) {
                if rt == nil { return }
                inOrder(rt!.left)
                nums.append(rt!.val)
                inOrder(rt!.right)
            }
            inOrder(root)
            
            var i = 0, j = nums.count - 1
            while i < j {
                let sum = nums[i] + nums[j]
                if sum == k {
                    return true
                }
                else if sum < k {
                    i += 1
                }
                else {
                    j -= 1
                }
            }
            return false
        }
        
        // MARK: 在二叉查找树中查找两个节点之差的最小绝对值
        // https://leetcode-cn.com/problems/minimum-absolute-difference-in-bst/description/
        func getMinimumDifference(_ root: TreeNode?) -> Int {
            var minDiff = Int.max, preNode: TreeNode? = nil
            func inOrder(_ rt: TreeNode?) {
                if rt == nil { return }
                inOrder(rt!.left)
                if preNode != nil {
                    // 中节点肯定比前一个节点大
                    minDiff = min(minDiff, rt!.val - preNode!.val)
                }
                preNode = rt!
                inOrder(rt!.right)
            }
            inOrder(root)
            return minDiff
        }
        
        // MARK: 寻找二叉查找树中出现次数最多的值
        // https://leetcode-cn.com/problems/find-mode-in-binary-search-tree/description/
        func findMode(_ root: TreeNode?) -> [Int] {
            var maxCntNums = [Int](), preNode: TreeNode? = nil, curCnt = 1, maxCnt = 1
            func inOrder(_ rt: TreeNode?) {
                if rt == nil { return }
                inOrder(rt!.left)
                if preNode != nil {
                    if preNode!.val == rt!.val {
                        curCnt += 1
                    }
                    else {
                        curCnt = 1
                    }
                }
                // 如果最大次数有变动，需要将保留的数组清空，并添加最新节点
                if curCnt > maxCnt {
                    maxCnt = curCnt
                    maxCntNums.removeAll()
                    maxCntNums.append(rt!.val)
                }
                else if curCnt == maxCnt {
                    // 添加同样是最大次数的节点
                    maxCntNums.append(rt!.val)
                }
                
                preNode = rt!
                inOrder(rt!.right)
            }
            inOrder(root)
            
            return maxCntNums
        }
        
        // MARK: Trie，又称前缀树或字典树
        // MARK: 实现一个 Trie
        // https://leetcode-cn.com/problems/implement-trie-prefix-tree/description/
        class Trie {
            
            //            init() {
            //
            //            }
            //
            //            func insert(_ word: String) {
            //
            //            }
            //
            //            func search(_ word: String) -> Bool {
            //
            //            }
            //
            //            func startsWith(_ prefix: String) -> Bool {
            //
            //            }
        }
    }
}
