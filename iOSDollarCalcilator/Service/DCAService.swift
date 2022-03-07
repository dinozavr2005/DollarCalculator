//
//  DCAService.swift
//  iOSDollarCalcilator
//
//  Created by Владимир on 06.03.2022.
//

import Foundation

struct DCAService {
    
    func calculate(asset: Asset,
                   initialInvestmentAmount: Double,
                   monthlyDollarAveragingAmount: Double,
                   initialDateOfInvestmentIndex: Int) -> DCAResult {
        
        let investmentAmount = getInvestmentAmount(initialInvestmentAmount: initialInvestmentAmount, monthlyDollarAveragingAmount: monthlyDollarAveragingAmount, initialDateOfInvestmentIndex: initialDateOfInvestmentIndex)
        
        let latestSharePrice = getLatestSharePrice(asset: asset)
        
        let numberOfShares = getNumberOfShares(asset: asset,
                                               initialInvestmentAmount: initialInvestmentAmount,
                                               monthlyDollarAveragingAmount: monthlyDollarAveragingAmount,
                                               initialDateOfInvestmentIndex: initialDateOfInvestmentIndex)
        
        let currentValue = getCurrentValue(numbersOfShares: numberOfShares, latestSharePrice: latestSharePrice)
        
        let isProfitable = currentValue > investmentAmount
        
        return .init(currentValue: currentValue,
                     investmentAmount: investmentAmount,
                     gain: 0,
                     yield: 0,
                     annualReturn: 0, isProfitable: isProfitable)
        
        //currentValue = numbersOfShares (initial + DCA) * latest share price
    }
    
    private func getInvestmentAmount(initialInvestmentAmount: Double, monthlyDollarAveragingAmount: Double, initialDateOfInvestmentIndex: Int) -> Double {
        var totalAmount = Double()
        totalAmount += initialInvestmentAmount
        let dollarCostAveragingAmount = initialDateOfInvestmentIndex.doubleValue * monthlyDollarAveragingAmount
        totalAmount += dollarCostAveragingAmount
        return totalAmount
    }
    
    private func getCurrentValue(numbersOfShares: Double, latestSharePrice: Double) -> Double {
        return numbersOfShares * latestSharePrice
    }
    
    private func getLatestSharePrice(asset: Asset) -> Double {
        return asset.timeSeriesMonthlyAdjusted.getMonthInfos().first?.adjustedClose ?? 0
    }
    
    private func getNumberOfShares(asset: Asset,
                                   initialInvestmentAmount: Double,
                                   monthlyDollarAveragingAmount: Double,
                                   initialDateOfInvestmentIndex: Int) -> Double {
        
        var totalShares = Double()
        
        let initialInvestmentOpenPrice = asset.timeSeriesMonthlyAdjusted.getMonthInfos()[initialDateOfInvestmentIndex].adjustedOpen
        let initialInvestmentShares = initialInvestmentAmount / initialInvestmentOpenPrice
        totalShares += initialInvestmentShares
        asset.timeSeriesMonthlyAdjusted.getMonthInfos().prefix(initialDateOfInvestmentIndex).forEach { (monthInfo) in
            let dcaInvestmentShares = monthlyDollarAveragingAmount / monthInfo.adjustedOpen
            totalShares += dcaInvestmentShares
        }
        return totalShares
    }
}

struct DCAResult {
    let currentValue: Double
    let investmentAmount: Double
    let gain: Double
    let yield: Double
    let annualReturn: Double
    let isProfitable: Bool
}
