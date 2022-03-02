//
//  Date+Extansions.swift
//  iOSDollarCalcilator
//
//  Created by Владимир on 02.03.2022.
//

import Foundation

extension Date {
    
    var MMYYFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: self)
    }
}
