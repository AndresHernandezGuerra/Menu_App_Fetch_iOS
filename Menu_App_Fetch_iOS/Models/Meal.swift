//
//  Meal.swift
//  Menu_App_Fetch_iOS
//
//  Created by Andres S. Hernandez G. on 2/28/23.
//

import Foundation

struct Meal: Codable {
    let id: String
    let name: String
    let thumbnailUrl: String?

    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnailUrl = "strMealThumb"
    }
}
