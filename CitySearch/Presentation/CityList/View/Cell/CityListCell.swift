//
//  CityListCell.swift
//  CitySearch
//
//  Created by Gayan Dias on 30/01/2565 BE.
//

import UIKit

class CityListCell: UITableViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityCodinateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCityValues(city: City) {
        self.cityNameLabel.text = "\(city.name), \(city.country)"
        self.cityCodinateLabel.text = "(\(city.coord.lat), \(city.coord.lon))"
    }
}
