//
//  CityTests.swift
//  CitySearchTests
//
//  Created by Gayan Dias on 31/01/2565 BE.
//

import Foundation
import XCTest

@testable import CitySearch

class CityTests: XCTestCase {
    
    func testCityDecoding() {
        let testBundle = Bundle(for: type(of: self))
        let fileURL = testBundle.url(forResource: "testcity", withExtension: "json")
        XCTAssertNotNil(fileURL)
        let testCityData = FileManager.default.contents(atPath: fileURL!.path)!
        XCTAssertNotNil(testCityData)
        
        var city: City?
        do {
            let decoder = JSONDecoder()
            city = try decoder.decode(City.self, from: testCityData)
        } catch let error {
            print(error)
        }
        
        XCTAssertEqual(city?.country, "UA")
        XCTAssertEqual(city?.name, "Hurzuf")
    }
    
    func testCitiesDecoding() {
        let testBundle = Bundle(for: type(of: self))
        let fileURL = testBundle.url(forResource: "testcities", withExtension: "json")
        XCTAssertNotNil(fileURL)
        let testCityData = FileManager.default.contents(atPath: fileURL!.path)!
        XCTAssertNotNil(testCityData)
        
        var cities: [City]?
        do {
            let decoder = JSONDecoder()
            cities = try decoder.decode([City].self, from: testCityData)
        } catch let error {
            print(error)
        }
        
        XCTAssertEqual(cities?.count, 3)
    }
}
