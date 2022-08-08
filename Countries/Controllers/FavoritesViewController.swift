//
//  FavoritesViewController.swift
//  Countries
//
//  Created by Emre Sarı on 5.08.2022.
//

import UIKit

class FavoritesViewController: UIViewController {

    var ss = [String]()
    var code = [String]()
    var saveTable = UITableView()
    override func viewDidLoad() {
        assignArray()
        super.viewDidLoad()
        print(ss)
        view.backgroundColor = .systemBackground
        title = "Saved"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        
        view.addSubview(saveTable)
        saveTable.delegate = self
        saveTable.dataSource = self
        saveTable.frame = view.frame.inset(by: UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        assignArray()
        saveTable.reloadData()
        
    }
    
    func assignArray() {
        if (ss != ArrayHelper.sharedInstance.collection) {
        ss = ArrayHelper.sharedInstance.collection
            code = ArrayHelper.sharedInstance.collectionCode
        } else {
            
        }
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    
    }
    
   

}


extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ss.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = ss[indexPath.row]
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
           
           let code = code[indexPath.row]
            print(code)
           
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
