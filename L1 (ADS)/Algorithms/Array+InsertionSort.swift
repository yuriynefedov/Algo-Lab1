//
//  Array+InsertionSort.swift
//  L1 (ADS)
//
//  Created by Yuriy Nefedov on 28.09.2021.
//

import Foundation

extension Array where Element: Comparable {

    mutating func insertionSort() -> Int {
        
        var comparisons: Int = 0
        
        for index in 1..<count {
            let value = self[index]
            var position = index

            while position > 0 && self[position - 1] > value {
                self[position] = self[position - 1]
                position -= 1
                comparisons += 2
            }
            self[position] = value
            comparisons += 1
        }
        return comparisons
    }
}
