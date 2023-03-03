//
//  MealTableViewCell.swift
//  Menu_App_Fetch_iOS
//
//  Created by Andres S. Hernandez G. on 2/28/23.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let reuseIdentifier = "MealCell"
    
    private let mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        
        return imageView
    }()
    
    private let mealNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 2
        label.textAlignment = .left
        
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(mealImageView)
        contentView.addSubview(mealNameLabel)
        
        mealImageView.translatesAutoresizingMaskIntoConstraints = false
        mealNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mealImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mealImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            mealImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            mealImageView.widthAnchor.constraint(equalToConstant: 80),
            mealImageView.heightAnchor.constraint(equalToConstant: 80),
            
            mealNameLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -10),
            mealNameLabel.leadingAnchor.constraint(equalTo: mealImageView.trailingAnchor, constant: 20),
            mealNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configure(with meal: Meal) {
        mealNameLabel.text = meal.name
        mealImageView.loadImageUsingCache(withUrl: URL(string: meal.thumbnailUrl!))
    }
}
