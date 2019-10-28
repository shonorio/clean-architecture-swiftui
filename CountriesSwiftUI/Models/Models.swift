//
//  Models.swift
//  CountriesSwiftUI
//
//  Created by Alexey Naumov on 23.10.2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

import Foundation

struct Country: Codable {
    let name: String
    let population: Int
    let flag: URL?
    let alpha3Code: Code
    
    typealias Code = String
}

extension Country {
    struct Details {
        let capital: String
        let currencies: [Currency]
        let neighbors: [Country]
    }
}

extension Country.Details {
    struct Intermediate: Codable {
        let capital: String
        let currencies: [Country.Currency]
        let borders: [String]
    }
}

extension Country {
    struct Currency: Codable {
        let code: String
        let symbol: String?
        let name: String
    }
}

// MARK: - Helpers

extension Country: Identifiable, Equatable {
    var id: String { alpha3Code }
}

extension Country.Currency: Identifiable, Equatable {
    var id: String { code }
}

extension Country.Details.Intermediate {
    func substituteNeighbors(countries: [Country]) -> Country.Details {
        let countries = self.borders.compactMap { code in
            return countries.first(where: { $0.alpha3Code == code })
        }
        return Country.Details(capital: capital, currencies: currencies, neighbors: countries)
    }
}