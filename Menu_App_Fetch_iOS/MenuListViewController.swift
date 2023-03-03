//
//  ViewController.swift
//  Menu_App_Fetch_iOS
//
//  Created by Andres S. Hernandez G. on 2/28/23.
//

import UIKit

class MenuListViewController: UIViewController {
    
    // MARK: - Properties

    private let menuTableView = UITableView()
    private var meals: [Meal] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        title = "Desserts"

        setupTableView()
        fetchMenu()
    }
    
    // MARK: -  Private Methods
    
    private func setupTableView() {
        
        view.addSubview(menuTableView)
        
        menuTableView.translatesAutoresizingMaskIntoConstraints = false
        menuTableView.tableFooterView = UIView()
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        NSLayoutConstraint.activate([
            menuTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            menuTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        menuTableView.register(MealTableViewCell.self, forCellReuseIdentifier: MealTableViewCell.reuseIdentifier)
    }
    
    private func fetchMenu() {
        Networking.fetchMeals(for: "Dessert") { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let meals):
                self.meals = meals.sorted { $0.name < $1.name }
                DispatchQueue.main.async {
                    self.menuTableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching desserts data: \(error.description)")
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension MenuListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = menuTableView.dequeueReusableCell(withIdentifier: MealTableViewCell.reuseIdentifier, for: indexPath) as? MealTableViewCell else {
            return UITableViewCell()
        }
        let meal = meals[indexPath.row]
        cell.configure(with: meal)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MenuListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMeal = meals[indexPath.row]
        Networking.fetchMealDetails(for: selectedMeal.id) { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let mealDetails):
                DispatchQueue.main.async {
                    let mealDetailsVC = MealDetailsViewController()
                    mealDetailsVC.meal = mealDetails
                    self.navigationController?.pushViewController(mealDetailsVC, animated: true)
                }
            case .failure(let error):
                print("Error fetching this dessert's data: \(error.description)")
            }
        }
    }
}

