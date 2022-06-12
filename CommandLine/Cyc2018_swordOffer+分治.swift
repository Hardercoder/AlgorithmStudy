//
//  Cyc2018_swordOffer+DivideAndConquer.swift
//  CommandLine
//
//  Created by unravel on 2022/2/28.
//

import Foundation
/// 分治
extension Cyc2018_swordOffer {
    class Cyc2018_swordOffser_Divid {
        // MARK: 数值的整数次方
        // 思想:
        // exponent 为奇数时 base^exponent = (base * base)^(exponent/2) * base
        // exponent 为偶数时 base^expoent = (base * base)^(exponent/2)
        // 当exponent 为负数时，最终的结果为正数时的倒数
        func cusPower(base:Double, exponent: Int) -> Double {
            var isNegative = false
            var mExponent = exponent
            
            if mExponent < 0 {
                mExponent = -mExponent
                isNegative = true
            }
            
            // 计算幂数
            func pow(x: Double, n: Int) -> Double {
                // 任何数的0次幂都是1
                if n == 0 {
                    return 1
                }
                // 任何数的1次幂是其本身
                if n == 1 {
                    return x
                }
                // 折半计算
                var res = pow(x: x, n: n / 2)
                res = res * res
                if n % 2 != 0 {
                    res *= x
                }
                return res
            }
            
            let res = pow(x: base, n: mExponent)
            return isNegative ? 1 / res : res
        }
    }
}
