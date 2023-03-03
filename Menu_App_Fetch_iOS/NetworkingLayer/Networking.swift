//
//  Networking.swift
//  Menu_App_Fetch_iOS
//
//  Created by Andres S. Hernandez G. on 2/28/23.
//
import Foundation

enum NetworkingError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
}

class Networking {
    
    // MARK: - Properties
    private static let  baseURL = "https://www.themealdb.com/api/json/v1/1/"
    
    // MARK: - Network call functions
    
    static func fetchMeals(for category: String, completion: @escaping (Result<[Meal], NetworkingError>) -> Void) {
        guard let requestUrl = URL(string: "\(baseURL)filter.php?c=\(category)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: requestUrl) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode),
                  let jsonData = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let meals = try JSONDecoder().decode(MealsResponse.self, from: jsonData)
                completion(.success(meals.meals))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    static func fetchMealDetails(for mealId: String, completion: @escaping (Result<MealDetails, NetworkingError>) -> Void) {
        guard let  requestUrl = URL(string: "\(baseURL)/lookup.php?i=\(mealId)") else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: requestUrl) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode),
                  let jsonData = data else {
                completion(.failure(.invalidResponse))
                return
            }

            do {
                let mealDetails = try JSONDecoder().decode(MealDetailsResponse.self, from: jsonData)
                guard let selectedMeal = mealDetails.meals.first else { return }
    
                completion(.success(selectedMeal))
                return
            } catch {
                completion(.failure(.decodingError))
                return
            }
                
        }.resume()
    }
}

// MARK: - Response Model

struct MealsResponse: Codable {
    let meals: [Meal]
}

// MARK: - Error Descriptions Extension

extension NetworkingError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .invalidURL:
            return "The category you are trying to search is invalid"
        case .invalidResponse:
            return "The server response was invalid"
        case .decodingError:
            return "There was an error decoding the data fetched"
        }
    }
}
