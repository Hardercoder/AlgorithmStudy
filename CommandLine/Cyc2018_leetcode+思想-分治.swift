//
//  Cyc2018_leetcode+x.swift
//  CommandLine
//
//  Created by unravel on 2022/4/14.
//

import Foundation
extension Cyc2018_leetcode {
    class Think_DivideAndConquer {
        // MARK: 给表达式加括号
        // https://leetcode-cn.com/problems/different-ways-to-add-parentheses/description/
        func diffWaysToCompute(_ expression: String) -> [Int] {
            func diffWaysToComputeInner(_ chs: [Character]) -> [Int] {
                var ways = [Int]()
                for i in 0..<chs.count {
                    let c = chs[i]
                    if c == "+" ||
                        c == "-" ||
                        c == "*" {
                        // 计算左边运算式
                        let left = diffWaysToComputeInner(Array(chs[..<i]))
                        // 计算右边运算式
                        let right = diffWaysToComputeInner(Array(chs[(i+1)...]))
                        for l in left {
                            for r in right {
                                // 将左右运算式的结果进行遍历，添加到父运算式中
                                switch c {
                                case "+": ways.append(l + r)
                                case "-": ways.append(l - r)
                                case "*": ways.append(l * r)
                                default: break
                                }
                            }
                        }
                    }
                }
                // 如果本次不包含任何运算，将值本身添加到结果数组中返回
                if ways.count == 0 {
                    ways.append(Int(String(chs))!)
                }
                return ways
            }
            return diffWaysToComputeInner(Array(expression))
        }
        
        // MARK: 不同的二叉搜索树
        // https://leetcode-cn.com/problems/unique-binary-search-trees-ii/description/
        // 给定一个数字 n，要求生成所有值为 1...n 的二叉搜索树
        func generateTrees(_ n: Int) -> [TreeNode?] {
            func generateSubTrees(_ s: Int,
                                  _ e: Int) -> [TreeNode?] {
                if s > e {
                    // 返回nil这一步是必须的，代表着叶子节点的下一个几点
                    return [nil]
                }
                var res = [TreeNode?]()
                // 枚举可行根节点
                for i in s...e {
                    // 获得所有可行的左子树集合
                    let leftSubTrees = generateSubTrees(s, i - 1)
                    // 获得所有可行的右子树集合
                    let rightSubTrees = generateSubTrees(i + 1, e)
                    // 从左子树集合中选出一棵左子树，从右子树集合中选出一棵右子树，拼接到根节点上
                    for l in leftSubTrees {
                        for r in rightSubTrees {
                            // 构建节点
                            let root = TreeNode(i)
                            root.left = l
                            root.right = r
                            res.append(root)
                        }
                    }
                }
                return res
            }
            
            return generateSubTrees(1, n)
        }
    }
}
