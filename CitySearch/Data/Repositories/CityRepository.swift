//
//  CityRepository.swift
//  CitySearch
//
//  Created by Gayan Dias on 30/01/2565 BE.
//

import Foundation

typealias GetCitiesCompletion = ([City]?, Error?)->()

protocol CityRepository {
    
    func fetchCities()
    func getCities(prefix: String?, completion: GetCitiesCompletion)
}
