//
//  Array+MergeSort.swift
//  L1 (ADS)
//
//  Created by Yuriy Nefedov on 28.09.2021.
//

import Foundation

fileprivate var comparisons = 0

extension Array where Element: Comparable {
    mutating func mergeSort(resetComparisons: Bool = true) -> Int {
        guard count > 1 else { return 1 }
        
        if resetComparisons {
            comparisons = 0
        }

        let middleIndex = count / 2

        var leftArray = Array(self[0..<middleIndex])
        leftArray.mergeSort(resetComparisons: false)
        var rightArray = Array(self[middleIndex..<self.count])
        rightArray.mergeSort(resetComparisons: false)

        self = merge(leftArray, rightArray)
        
        return comparisons
    }

    func merge<T: Comparable>(_ left: [T], _ right: [T]) -> [T] {
      var leftIndex = 0
      var rightIndex = 0

      var orderedArray: [T] = []
      
      while leftIndex < left.count && rightIndex < right.count {
        let leftElement = left[leftIndex]
        let rightElement = right[rightIndex]

        if leftElement < rightElement {
          orderedArray.append(leftElement)
          leftIndex += 1
          comparisons += 1
        } else if leftElement > rightElement {
          orderedArray.append(rightElement)
          rightIndex += 1
          comparisons += 2
        } else {
          orderedArray.append(leftElement)
          leftIndex += 1
          orderedArray.append(rightElement)
          rightIndex += 1
          comparisons += 2
        }
      }

      while leftIndex < left.count {
        orderedArray.append(left[leftIndex])
        leftIndex += 1
        comparisons += 1
      }

      while rightIndex < right.count {
        orderedArray.append(right[rightIndex])
        rightIndex += 1
        comparisons += 1
      }
      
      return orderedArray
    }
}
