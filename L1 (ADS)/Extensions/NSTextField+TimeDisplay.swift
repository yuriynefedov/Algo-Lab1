//
//  NSTextField+TimeDisplay.swift
//  L1 (ADS)
//
//  Created by Yuriy Nefedov on 28.09.2021.
//

import Cocoa

extension NSTextField {
    func displayTime(valueInSeconds value: Double) {
        stringValue = "\(value.rounded(toPlaces: 5))s"
    }
}
