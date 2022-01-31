//
//  CityRepositopryImplement.swift
//  CitySearch
//
//  Created by Gayan Dias on 30/01/2565 BE.
//

import Foundation

class CityRepositoryImplement: CityRepository {
    
    enum RepositoryError: Error {
        case initializationError
        case unknownError
    }
    
    var allCities: [City]?
    var cityTrie: CityTrie?
    
    func fetchCities() {
        guard let fileURL = Bundle.main.url(forResource: "cities",
                                            withExtension: "json") else {
            return
        }
        
        guard let cityData = FileManager.default.contents(atPath: fileURL.path) else {
            return
        }
        
        var cities: [City]?
        do {
            let decoder = JSONDecoder()
            cities = try decoder.decode([City].self, from: cityData)
        } catch let error {
            debugPrint(error)
        }
        
        guard let totalCities = cities else {
            return
        }
        
        let sortedCities = totalCities.sorted(by: { city1, city2 in
            if city1.name != city2.name {
                return city1.name < city2.name
            } else {
                return city1.country < city2.country
            }
        })
        
        self.allCities = sortedCities
        self.cityTrie = CityTrie()
        for city in sortedCities {
            self.cityTrie?.insert(city: city)
        }
    }
    
    func getCities(prefix: String?, completion: GetCitiesCompletion) {

        guard let cityTrie = cityTrie, let allCities = allCities, cityTrie.count > 0, allCities.count > 0 else {
            completion(nil, RepositoryError.initializationError)
            return
        }
        
        guard let lowercasePrefix = prefix?.lowercased() else {
            completion(allCities, nil)
            return
        }
        
        let filteredCities = cityTrie.findCitiesWithPrefix(prefix: lowercasePrefix)
        completion(filteredCities, nil)
    }
}
