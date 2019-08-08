//
//  APIClient.swift
//  WeatherApp
//
//  Created by Yamada Shunya on 2019/08/08.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation

class APIClient {
    static let shered: APIClient = APIClient()
    
    private init() {}
    
    func get<Response: Decodable>(path: String, queries: [URLQueryItem], type: Response.Type,
                                          completion: @escaping ((_ response: Response?, _ error: Error?) -> Void)) {
        var components = URLComponents(string: Configuration.baseUrl + path)
        components?.queryItems = queries
        
        guard let url = components?.url else {
            completion(nil, APIError(localizedDescription: "URL is not correct."))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print(json)
                    
                    let response = try JSONDecoder().decode(type, from: data)
                    completion(response, nil)
                } catch let error {
                    completion(nil, error)
                }
            } else {
                completion(nil, APIError(localizedDescription: "Responsed data is empty or something wrong."))
            }
        }
        task.resume()
    }
}
