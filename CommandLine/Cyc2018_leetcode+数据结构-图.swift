//
//  Cyc2018_leetcode+x.swift
//  CommandLine
//
//  Created by unravel on 2022/4/14.
//

import Foundation
extension Cyc2018_leetcode {
    class DataStructure_Map {
        // MARK: 判断是否为二分图
        // https://leetcode-cn.com/problems/is-graph-bipartite/description/
        func isBipartite(_ graph: [[Int]]) -> Bool {
            // 存储每个节点着色的数组
            var colors = [Int](repeating: -1, count: graph.count)
            // 深度优先搜索
            func isBipartite(_ curNode: Int,
                             _ curColor: Int) -> Bool {
                if colors[curNode] != -1 {
                    // 如果已经染色，返回它 已经染得颜色 和 应该染得颜色 是否相同
                    return colors[curNode] == curColor
                }
                else {
                    // 染色，颜色只有0和1
                    colors[curNode] = curColor
                    // 对当前节点连接的边的另一个节点进行反向着色
                    for nextNode in graph[curNode] {
                        if !isBipartite(nextNode, 1 - curColor) {
                            return false
                        }
                    }
                }
                return true
            }
            
            for i in 0..<graph.count {
                // 处理不是连通的情况
                if colors[i] == -1 && !isBipartite(i, 0) {
                    return false
                }
            }
            return true
        }
        
        // 深度优先搜索
        func isBipartiteDFS(_ graph: [[Int]]) -> Bool {
            let UNCOLORED = 0, RED = 1, GREEN = 2
            let n = graph.count
            // 填充默认颜色
            var color = [Int](repeating: UNCOLORED, count: n), valid = true
            // 对相应节点进行着色
            func dfs(_ node: Int,
                     _ c: Int) {
                // 进行着色
                color[node] = c
                // 下一个节点应该着的颜色
                let cNei = c == RED ? GREEN : RED
                // 遍历该节点所连接边的另一个节点
                for neighbor in graph[node] {
                    if color[neighbor] == UNCOLORED {
                        dfs(neighbor, cNei)
                        if !valid {
                            return
                        }
                    }
                    else if color[neighbor] != cNei {
                        valid = false
                        return
                    }
                }
            }
            
            // 遍历每个节点，处理他们的着色
            for i in 0..<n {
                if valid && color[i] == UNCOLORED {
                    dfs(i, RED)
                }
            }
            return valid
        }
        
        // 广度优先遍历
        func isBipartiteBFS(_ graph: [[Int]]) -> Bool {
            let UNCOLORED = 0, RED = 1, GREEN = 2
            let n = graph.count
            // 填充默认颜色
            var color = [Int](repeating: UNCOLORED, count: n)
            // 遍历每个节点
            for i in 0..<n {
                if color[i] == UNCOLORED {
                    var queue = [Int]()
                    // 将本节点入队
                    queue.append(i)
                    color[i] = RED
                    // 循环处理它的每条边上的节点
                    while !queue.isEmpty {
                        let node = queue.removeFirst()
                        let cNei = color[node] == RED ? GREEN : RED
                        for neighbor in graph[node] {
                            if color[neighbor] == UNCOLORED {
                                queue.append(neighbor)
                                color[neighbor] = cNei
                            }
                            else if color[neighbor] != cNei {
                                return false
                            }
                        }
                    }
                }
            }
            return true
        }
        
        // MARK: 课程安排的合法性
        // https://leetcode-cn.com/problems/course-schedule/description/
        // 本题不需要使用拓扑排序，只需要检测有向图是否存在环即可
        func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
            var graphic = [[Int]](repeating: [Int](), count: numCourses)
            // 根据依赖，构建有向图
            for pre in prerequisites {
                graphic[pre[0]].append(pre[1])
            }
            
            var globalMarked = [Bool](repeating: false, count: numCourses)
            var localMarked = [Bool](repeating: false, count: numCourses)
            // 判断从这个节点出去的路径是否有环
            func hasCycle(_ curNode: Int) -> Bool {
                if localMarked[curNode] {
                    return true
                }
                if globalMarked[curNode] {
                    return false
                }
                globalMarked[curNode] = true
                localMarked[curNode] = true
                for nextNode in graphic[curNode] {
                    if hasCycle(nextNode) {
                        return true
                    }
                }
                localMarked[curNode] = false
                return false
            }
            
            // 判断每一个节点是否有环
            for i in 0..<numCourses {
                if hasCycle(i) {
                    return false
                }
            }
            return true
        }
        
        // 深度优先搜索
        func canFinishDFS(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
            var visited = [Int](repeating: 0, count: numCourses)
            var edges = [[Int]](repeating: [Int](), count: numCourses)
            var valid = true
            // 根据依赖，构建有向图
            for pre in prerequisites {
                edges[pre[0]].append(pre[1])
            }
            
            func dfs(_ u: Int) {
                visited[u] = 1
                for v in edges[u] {
                    if visited[v] == 0 {
                        dfs(v)
                        if !valid {
                            return
                        }
                    }
                    else if (visited[v] == 1) {
                        valid = false
                        return
                    }
                }
                visited[u] = 2
            }
            
            for i in 0..<numCourses {
                if valid && visited[i] == 0 {
                    dfs(i)
                }
            }
            return valid
        }
        
        // 广度优先搜索
        func canFinishBFS(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
            var indeg = [Int](repeating: 0, count: numCourses)
            var edges = [[Int]](repeating: [Int](), count: numCourses)
            // 根据依赖，构建有向图
            for pre in prerequisites {
                edges[pre[0]].append(pre[1])
                indeg[pre[1]] += 1
            }
            
            var queue = [Int]()
            for i in 0..<numCourses {
                if indeg[i] == 0 {
                    queue.append(i)
                }
            }
            var visited = 0
            while !queue.isEmpty {
                visited += 1
                let u = queue.removeFirst()
                for v in edges[u] {
                    indeg[v] -= 1
                    if indeg[v] == 0 {
                        queue.append(v)
                    }
                }
            }
            return visited == numCourses
        }
        
        // MARK: 课程安排的顺序
        // https://leetcode-cn.com/problems/course-schedule-ii/description/
        func findOrder(_ numCourses: Int, _ prerequisites: [[Int]]) -> [Int] {
            var graphic = [[Int]](repeating: [Int](), count: numCourses)
            // 根据依赖，构建有向图
            for pre in prerequisites {
                graphic[pre[0]].append(pre[1])
            }
            
            var postOrder = [Int]()
            // 代表节点是否访问过 无环
            var globalMarked = [Bool](repeating: false, count: numCourses)
            // 代表节点访问过 有环
            var localMarked = [Bool](repeating: false, count: numCourses)
            // 判断从这个节点出去的路径是否有环
            func hasCycle(_ curNode: Int) -> Bool {
                if localMarked[curNode] {
                    return true
                }
                if globalMarked[curNode] {
                    return false
                }
                globalMarked[curNode] = true
                localMarked[curNode] = true
                for nextNode in graphic[curNode] {
                    if hasCycle(nextNode) {
                        return true
                    }
                }
                localMarked[curNode] = false
                postOrder.append(curNode)
                return false
            }
            
            for i in 0..<numCourses {
                if hasCycle(i) {
                    return []
                }
            }
            return postOrder
        }
        
        // MARK: 冗余连接
        // https://leetcode-cn.com/problems/redundant-connection/description/
        func findRedundantConnection(_ edges: [[Int]]) -> [Int] {
            let n = edges.count
            var parent = Array(0...n)
            func union(_ index1: Int, _ index2: Int) {
                parent[find(index1)] = find(index2)
            }
            
            func find(_ index: Int) -> Int {
                if parent[index] != index {
                    parent[index] = find(parent[index])
                }
                return parent[index]
            }
            
            for i in 0..<n {
                let edge = edges[i]
                let node1 = edge[0], node2 = edge[1]
                if find(node1) != find(node2) {
                    union(node1,node2)
                }
                else {
                    return edge
                }
            }
            return []
        }
    }
}
