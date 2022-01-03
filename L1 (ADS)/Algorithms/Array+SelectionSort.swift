//
//  Array+SelectionSort.swift
//  L1 (ADS)
//
//  Created by Yuriy Nefedov on 28.09.2021.
//

import Foundation

extension Array where Element: Comparable {
    mutating func selectionSort() -> Int {
        
        var comparisons = 0
        
        for iterationIndex in 0 ..< self.count {
            var minIndex = iterationIndex
            for compareIndex in iterationIndex + 1 ..< self.count {
                if self[compareIndex] < self[minIndex] {
                    minIndex = compareIndex
                }
                comparisons += 1
            }
            swapAt(iterationIndex, minIndex)
        }
        return comparisons
    }
}
