//
//  City.swift
//  CitySearch
//
//  Created by Gayan Dias on 30/01/2565 BE.
//

import Foundation

struct City: Codable, Hashable {
    
    let identifier: Int64
    let country: String
    let name: String
    let coord: Coordinate
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "_id",
             country,
             name,
             coord
    }
}

struct Coordinate: Codable, Hashable {
    
    let lat: Double
    let lon: Double
}
