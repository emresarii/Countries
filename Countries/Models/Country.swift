//
//  Country.swift
//  Countries
//
//  Created by Emre Sarı on 5.08.2022.
//

import Foundation

struct CountriesResponse: Codable {
    let data : [Country]
}

struct CountryResponse: Codable{
    let data : Country
}

struct Country: Codable {
    let code : String
    let name : String
    let wikiDataId: String
    let flagImageUri: String?
    let isSaved :Bool?
    
    
}
