//
//  Double+Extensions.swift
//  iOSDollarCalcilator
//
//  Created by Владимир on 06.03.2022.
//

import Foundation

extension Double {
    
    var stringValue: String {
        return String(describing: self)
    }
    
    var twoDecimalPlaceString: String {
        return String(format: "%.2f", self)
    }
}
