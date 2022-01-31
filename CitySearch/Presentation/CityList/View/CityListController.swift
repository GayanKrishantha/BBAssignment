//
//  CityListController.swift
//  CitySearch
//
//  Created by Gayan Dias on 30/01/2565 BE.
//

import UIKit

class CityListController: UIViewController {
    
    @IBOutlet weak var citySearchBar: UISearchBar!
    @IBOutlet weak var cityTableView: UITableView!
    
    var viewModel: CityListViewModel = CityListViewModel()
    let tableCellIdentifier = String(describing: CityListCell.self)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableViewCell()
        self.citySearchBar?.delegate = self
        self.citySearchBar?.returnKeyType = .done
        self.loadCities()
    }
    
    private func registerTableViewCell() {
        self.cityTableView.register(UINib(nibName: tableCellIdentifier,
                                       bundle: Bundle.main),
                                forCellReuseIdentifier: tableCellIdentifier)
    }
    
    private func loadCities(query: String? = nil) {
        self.viewModel.loadCities(query: query) { [self] response in
            self.cityTableView.reloadData()
        } failure: { error in
            //handel error
        }
    }
}
 
extension CityListController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.cities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityListCell", for: indexPath)
            as! CityListCell
        let city = self.viewModel.cities[indexPath.row]
        cell.setCityValues(city: city)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = self.viewModel.cities[indexPath.row]
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "CityMap") as! CityMapController
        controller.viewModel = CityMapViewModel()
        controller.viewModel.city = city
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension CityListController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        (self.citySearchBar.text == nil || citySearchBar.text == "") ?
        loadCities() :
        self.perform(#selector(self.reload), with: nil, afterDelay: 0.3)
    }
    
    @objc func reload(_ searchBar: UISearchBar) {
        guard let query = self.citySearchBar?.text, query.trimmingCharacters(in: .whitespaces) != "" else {
            loadCities()
            return
        }
        self.loadCities(query: query)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.citySearchBar.resignFirstResponder()
    }
}
