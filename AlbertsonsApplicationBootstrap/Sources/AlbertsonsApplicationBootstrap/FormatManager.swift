//
//  FormatManager.swift
//  
//
//  Created by Durgesh Lal on 1/25/23.
//

import AlbertsonsApis

public struct FormatManager: FormatManaging {
    public init() {  }
    
    public func roundToNearestHalf<T: CustomStringConvertible>(_ value: T) -> String {
        let n = 1 / 0.5
        guard let value = Double(value.description) else { return "" }
        let numberToRound = value * n
        return "\(numberToRound.rounded() / n)"
    }
}


