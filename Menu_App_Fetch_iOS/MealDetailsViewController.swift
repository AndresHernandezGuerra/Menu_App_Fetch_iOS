//
//  MealDetailsViewController.swift
//  Menu_App_Fetch_iOS
//
//  Created by Andres S. Hernandez G. on 2/28/23.
//

import UIKit

class MealDetailsViewController: UIViewController {
    
    // MARK: - Properties
    var meal: MealDetails?
    var ingredientsAndMeasures = [String]()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let mealNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ingredientsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Here is what you will need to make the dish:"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let instructionsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Preparation instructions:"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let instructionsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMeasuresAndIngredients()
        setupUI()
        setupScrollView()
    }
    
    // MARK: - Helper Functions
    
    private func setupMeasuresAndIngredients() {
        let measures = meal?.measures
        let ingredients = meal?.ingredients
        for (index, element) in measures!.enumerated() {
            let combinedElements = "\(element) of \(ingredients![index])"
            ingredientsAndMeasures.append(combinedElements)
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShareButton))
        
        if let meal = meal {
            mealNameLabel.text = meal.strMeal
            ingredientsLabel.text = "->  " + ingredientsAndMeasures.joined(separator: "\n->  ")
            instructionsLabel.text = meal.strInstructions
            mealImageView.loadImageUsingCache(withUrl: URL(string: meal.strMealThumb))
        }
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(mealImageView)
        scrollView.addSubview(mealNameLabel)
        scrollView.addSubview(ingredientsTitleLabel)
        scrollView.addSubview(ingredientsLabel)
        scrollView.addSubview(instructionsTitleLabel)
        scrollView.addSubview(instructionsLabel)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            
            mealNameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15),
            mealNameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            mealNameLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15),
            
            mealImageView.topAnchor.constraint(equalTo: mealNameLabel.bottomAnchor, constant: 15),
            mealImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mealImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mealImageView.heightAnchor.constraint(equalToConstant: 300),
            mealImageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            ingredientsTitleLabel.topAnchor.constraint(equalTo: mealImageView.bottomAnchor, constant: 15),
            ingredientsTitleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            ingredientsTitleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -5),
            
            ingredientsLabel.topAnchor.constraint(equalTo: ingredientsTitleLabel.bottomAnchor, constant: 15),
            ingredientsLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            ingredientsLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15),
            
            instructionsTitleLabel.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 15),
            instructionsTitleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            instructionsTitleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -5),
            
            instructionsLabel.topAnchor.constraint(equalTo: instructionsTitleLabel.bottomAnchor, constant: 15),
            instructionsLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -15),
            instructionsLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            instructionsLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15)
        ])
    }
    
    // MARK: - Share Action Button
    
    @objc private func didTapShareButton() {
        guard let mealName = mealNameLabel.text, let mealImage = mealImageView.image else {
            return
        }
        
        let activityViewController = UIActivityViewController(activityItems: [mealName, mealImage], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
}
