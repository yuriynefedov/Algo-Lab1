//
//  Observer.swift
//  L1 (ADS)
//
//  Created by Yuriy Nefedov on 28.09.2021.
//

import Foundation

struct Observer {
    public func conductExperiment(usingArray array: Array<Int>) -> [SortingAlgorithm: [Any]] {
        let testedAlgorithms: [SortingAlgorithm] = [.insertionSort, .mergeSort, .shellSort]
        var results: [SortingAlgorithm: [Any]] = [:]
        
        for algorithm in testedAlgorithms {
            let result = conductExperiment(usingArray: array, usingAlgorithm: algorithm)
//            let timeResult = result[0] as! Double
//            let comparisons = result[1] as! Int
            results[algorithm] = result
        }
        print(results)
        return results
    }
    
    public func conductExperiment(usingArray array: Array<Int>, usingAlgorithm algorithm: SortingAlgorithm) -> [Any] {
        
        var copiedArray = array
        
//        print("Initial array (\(algorithm)): \(copiedArray.dropFirst(10))")
        
        let start = ProcessInfo().systemUptime
        var comparisons: Int?
        
        switch algorithm {
        case .selectionSort:
            comparisons = copiedArray.selectionSort()
        case .insertionSort:
            comparisons = copiedArray.insertionSort()
        case .mergeSort:
            comparisons = copiedArray.mergeSort()
        case .shellSort:
            comparisons = copiedArray.shellSort()
        }
        
//        print("Final array (\(algorithm)): \(copiedArray.dropFirst(10))")

        let end = ProcessInfo().systemUptime
        
        return [Double(end - start), comparisons!]
    }
}
