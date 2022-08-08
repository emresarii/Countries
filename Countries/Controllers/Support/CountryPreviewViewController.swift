//
//  CountryPreviewViewController.swift
//  Countries
//
//  Created by Emre Sarı on 6.08.2022.
//

import UIKit
import WebKit
import SDWebImage





extension UIImageView {
    
    
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}

class CountryPreviewViewController: UIViewController {
    
    
    var urlExt: String = ""
    private let titleLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "Harry potter"
        return label
    }()
    
    private let overviewLabel: UILabel = {
       
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "This is the best movie ever to watch as a kid!"
        return label
    }()
    
    private let moreInfoButton: UIButton = {
       
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.init(named: "reverseDefault")
        button.setTitle("More Information", for: .normal)
        button.setTitleColor(UIColor.init(named: "defaultColor"), for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        
        return button
    }()
    
    @objc func buttonAction(sender: UIButton!) {
        if let url = URL(string: "https://www.wikidata.org/wiki/\(urlExt)"){
            UIApplication.shared.open(url)
        }
    }
    
    private let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
       }()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(moreInfoButton)
        view.addSubview(flagImageView)
        
        configureConstraints()
        
    }
   
    

    
    func configureConstraints() {
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
        ]
        let flagImageViewConstraints = [
            flagImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
                flagImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                flagImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                flagImageView.heightAnchor.constraint(equalToConstant: 300)
                ]
      
        
        let overviewLabelConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: flagImageView.bottomAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let downloadButtonConstraints = [
            moreInfoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            moreInfoButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 25),
            moreInfoButton.widthAnchor.constraint(equalToConstant: 140),
            moreInfoButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(flagImageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(overviewLabelConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
        
    }
    

    public func configure(with model: CountryPreviewModel) {
        titleLabel.text = model.name
        overviewLabel.text = model.code
        urlExt = model.wikiDataId!
        
        
        guard let url = URL(string: model.flagImageUri ?? "") else {
                    return
                }
                
                flagImageView.sd_setImage(with: url, completed: nil)
            }


        

}

