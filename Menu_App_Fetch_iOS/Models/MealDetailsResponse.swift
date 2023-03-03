//
//  MealDetailsResponse.swift
//  Menu_App_Fetch_iOS
//
//  Created by Andres S. Hernandez G. on 3/2/23.
//
import Foundation

struct MealDetailsResponse: Decodable {
    let meals: [MealDetails]
}

struct MealDetails: Decodable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    let strInstructions: String
    let ingredients: [String]
    let measures: [String]
    
    enum CodingKeys: String, CodingKey {
        case idMeal
        case strMeal
        case strMealThumb
        case strInstructions
        case strIngredient1
        case strIngredient2
        case strIngredient3
        case strIngredient4
        case strIngredient5
        case strIngredient6
        case strIngredient7
        case strIngredient8
        case strIngredient9
        case strIngredient10
        case strIngredient11
        case strIngredient12
        case strIngredient13
        case strIngredient14
        case strIngredient15
        case strIngredient16
        case strIngredient17
        case strIngredient18
        case strIngredient19
        case strIngredient20
        case strMeasure1
        case strMeasure2
        case strMeasure3
        case strMeasure4
        case strMeasure5
        case strMeasure6
        case strMeasure7
        case strMeasure8
        case strMeasure9
        case strMeasure10
        case strMeasure11
        case strMeasure12
        case strMeasure13
        case strMeasure14
        case strMeasure15
        case strMeasure16
        case strMeasure17
        case strMeasure18
        case strMeasure19
        case strMeasure20
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        
        var ingredientsArray = [String]()
        for index in 1...20 {
            let ingredientKey = "strIngredient\(index)"
            if let ingredient = try container.decodeIfPresent(String.self, forKey: .init(stringValue: ingredientKey)!) {
                ingredientsArray.append(ingredient)
            }
        }
        ingredients = ingredientsArray.filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
        
        var measuresArray = [String]()
        for index in 1...20 {
            let measureKey = "strMeasure\(index)"
            if let measure = try container.decodeIfPresent(String.self, forKey: .init(stringValue: measureKey)!) {
                measuresArray.append(measure)
            }
        }
        measures = measuresArray.filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
    }
}


