//
//  DateManager.swift
//  
//
//  Created by Durgesh Lal on 1/25/23.
//

import Foundation
import AlbertsonsApis

class DateManager: DateManaging {
    
    lazy var formatter: DateFormatter = {
        let format = DateFormatter()
        format.dateStyle = .short
        return format
    }()
    
    func formatDate(_ date: String?, format from: DateFormatter.Style, format to: DateFormatter.Style) -> String {
        guard let date = date else { return "" }
        formatter.dateStyle = from
        guard let input = formatter.date(from: date) else { return "" }
        formatter.dateStyle = to
        return formatter.string(from: input)
    }
}

