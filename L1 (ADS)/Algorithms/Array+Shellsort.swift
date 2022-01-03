//
//  Array+Shellsort.swift
//  L1 (ADS)
//
//  Created by Yuriy Nefedov on 28.09.2021.
//

import Foundation

extension Array where Element: Comparable {
    mutating func shellSort() -> Int {
        
        var comparisons = 0
        
        let length = count
        var h = 1
        
        while h < length / 3 {
            h = 3 * h + 1
        }
        
        while h >= 1 {
            for i in h..<length {
                for j in stride(from: i, to: h - 1, by: -h) {
                    comparisons += 1
                    if self[j] < self[j - h] {
                        swapAt(j, j - h)
                    } else {
                        break
                    }
                }
            }
            h /= 3
        }
        return comparisons
    }
}
