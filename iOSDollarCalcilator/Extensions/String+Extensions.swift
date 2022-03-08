//
//  String+Extensions.swift
//  iOSDollarCalcilator
//
//  Created by Владимир on 01.03.2022.
//

import Foundation

extension String {
    
    func addBrackets() -> String {
        return "(\(self))"
    }
    
    func prefix(withText text: String) -> String {
        return text + self
    }
    
    func toDouble() -> Double? {
        return Double(self)
    }
    
}
