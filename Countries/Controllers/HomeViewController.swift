//
//  HomeViewController.swift
//  Countries
//
//  Created by Emre Sarı on 5.08.2022.
//


import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    
    private var countries: [Country] = [Country]()
    var saveList = [String]()
    var saveListCode = [String]()
    private let countriesTable: UITableView = {
       
        let table = UITableView()
        table.register(CountryTableViewCell.self, forCellReuseIdentifier: CountryTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Countries"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        
        view.addSubview(countriesTable)
        countriesTable.delegate = self
        countriesTable.dataSource = self
        countriesTable.frame = view.frame.inset(by: UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30))
        fetchCountries()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    
    }
    
   
    private func fetchCountries() {
        APICall.shared.getCountries{ [weak self] result in
            switch result {
            case .success(let countries):
                self?.countries = countries
                DispatchQueue.main.async {
                    self?.countriesTable.reloadData()
                    print(countries)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier, for: indexPath) as? CountryTableViewCell else {
            return UITableViewCell()
        }
        
        let country = countries[indexPath.row]
        cell.configure(with: CountryViewModel(countryName: country.name ?? "", flagImageUri:country.flagImageUri ?? "", code: country.code ?? "", wikiDataId: country.wikiDataId ?? ""))
        cell.cellDelegate = self
        cell.index = indexPath
        cell.backgroundColor = UIColor.init(named: "defaultColor")
        cell.layer.borderColor = UIColor.init(named: "reverseDefault")?.cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 15
        cell.clipsToBounds = true
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.deselectRow(at: indexPath, animated: true)
           
           let country = countries[indexPath.row]
           
            let code = country.code
           
           
           APICall.shared.getCountry(with: code) { [weak self] result in
               switch result {
               case .success(let country):
                    DispatchQueue.main.async {
                       print(country)
                       let vc = CountryPreviewViewController()
                       vc.configure(with: CountryPreviewModel(name: country.name, flagImageUri:country.flagImageUri ?? "", code: code, wikiDataId: country.wikiDataId))
                       self?.navigationController?.pushViewController(vc, animated: true)
                   }

                   
               case .failure(let error):
                   print(error)
               }
           }
}
}

extension HomeViewController: TableView {
    func onClickCell(index: Int) {
        print("\(index) is clicked")
        var tempName = countries[index].name
        var tempCode = countries[index].code
        if saveList.contains(tempName) == false{
            saveList.append(tempName)
            saveListCode.append(tempCode)
            ArrayHelper.sharedInstance.collectionCode = saveListCode
            ArrayHelper.sharedInstance.collection = saveList
        } else{
            saveList.removeAll(where: { $0 == tempName })
            saveListCode.removeAll(where: { $0 == tempCode })
            ArrayHelper.sharedInstance.collectionCode = saveListCode
            ArrayHelper.sharedInstance.collection = saveListCode
        }
        print("\(countries[index].name) is clicked")
        print(saveListCode)
        print(saveList)
        
    }
}
