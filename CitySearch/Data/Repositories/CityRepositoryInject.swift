//
//  CityRepositopryInject.swift
//  CitySearch
//
//  Created by Gayan Dias on 30/01/2565 BE.
//

import Foundation

class CityRepositoryInject {
    static let shared: CityRepositoryInject = CityRepositoryInject()
    
    lazy var cityRepository: CityRepository = { return CityRepositoryImplement() }()
    
    static func provideCityRepository() -> CityRepository {
        return shared.cityRepository
    }
}
