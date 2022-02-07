//
//  APIService.swift
//  iOSDollarCalcilator
//
//  Created by Владимир on 07.02.2022.
//

import Foundation
import Combine

struct APIService {
    
    var API_KEY: String {
        return keys.randomElement() ?? ""
    }
    
    let keys = ["Y236PNXTQA5Q6GE8", "KZECPVKAJ0Y9QAMX", "9XKMGKFT1PJC9VQ2"]
    
    func fetchSymbolsPublisher(keywords: String) -> AnyPublisher<SearchResults, Error> {
        
        let urlString = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(keywords)&apikey=\(API_KEY)"
        
        let url = URL(string: urlString)!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: SearchResults.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
