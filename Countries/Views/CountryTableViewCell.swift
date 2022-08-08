//
//  CountryTableViewCell.swift
//  Countries
//
//  Created by Emre Sarı on 6.08.2022.
//

import UIKit

protocol TableView{
    func onClickCell(index: Int)
}

class CountryTableViewCell: UITableViewCell {

    

    static let identifier = "CountryTableViewCell"
    
    private var countries: [Country] = [Country]()
    var cellDelegate : TableView?
    var index: IndexPath?
    private let playTitleButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        button.setBackgroundImage(UIImage(systemName: "star.fill"), for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemRed
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        return button
    }()
    
    @objc func buttonClicked() {
        cellDelegate?.onClickCell(index: (index?.row)!)
        if playTitleButton.isSelected == true {
            playTitleButton.isSelected = false
        }
        else {
            playTitleButton.isSelected = true
        }
        }
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.init(named:"reverseDefault")
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        contentView.addSubview(titleLabel)
        contentView.addSubview(playTitleButton)
        
        applyConstraints()
        
    }
    
    
    
    private func applyConstraints() {
       
        
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ]
        
        
        let playTitleButtonConstraints = [
            playTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(playTitleButtonConstraints)
    }
    
    
    
    public func configure(with model: CountryViewModel) {

        titleLabel.text = model.countryName }
    
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
