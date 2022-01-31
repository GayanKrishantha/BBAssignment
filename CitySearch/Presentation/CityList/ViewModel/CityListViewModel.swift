//
//  CityListViewModel.swift
//  CitySearch
//
//  Created by Gayan Dias on 30/01/2565 BE.
//

import Foundation

class CityListViewModel {
    
    let cityRepository = CityRepositoryInject.provideCityRepository()
    var cities = [City]()
    
    func loadCities(query: String? = nil,
                    completion: @escaping(_ response: [City]) -> Void,
                    failure: @escaping(_ error: String)->()) {
        cityRepository.getCities(prefix: query, completion: {cities, _ in
            if let cities = cities {
                self.cities = cities
                completion(cities)
            } else {
                failure("Error")
            }
        })
    }
}
