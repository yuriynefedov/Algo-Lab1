//
//  Array+randomizingFillers.swift
//  L1 (ADS)
//
//  Created by Yuriy Nefedov on 28.09.2021.
//

import Foundation

extension Array {
    
    static func randomizedIntArray(ofSize size: Int, fillingFromRange range: ClosedRange<Int>) -> [Int] {
        var arr: [Int] = []
        for _ in 0..<size {
            arr.append(Int.random(in: range))
        }
        return arr
    }
    
    static func randomizedIntArray(ofSize size: Int) -> [Int] {
        let arr = randomizedIntArray(ofSize: size, fillingFromRange: K.rangeToFillArraysFrom)
        return arr
    }
    
    static func randomizedAscendingIntArray(ofSize size: Int) -> [Int] {
        let arr = randomizedIntArray(ofSize: size)
        return arr.sorted()
    }
    
    static func randomizedDescendingIntArray(ofSize size: Int) -> [Int] {
        let arr = randomizedIntArray(ofSize: size)
        return arr.sorted().reversed()
    }
    
    static func randomized123Array(ofSize size: Int) -> [Int] {
        var arr: [Int] = []
        for _ in 0..<size {
            arr.append(Int.random(in: 1...3))
        }
        return arr
    }
}
