//
//  WasteService.swift
//  GreenWorld
//
//  Created by ChaimaEljed on 5/12/2023.
//

import Foundation

class WasteService {
    func addWasteData(Type_dechets: String, date_depot: Date, nombre_capacite: Int, adresse: String, completion: @escaping (Result<Dechets, Error>) -> Void) {
        // Assuming you have a URL for your backend endpoint
        let url = URL(string: "http://192.168.0.130:9090/dechets")!

        // Prepare the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // Create a dictionary with the data
        let wasteData = [
            "Type_dechets": Type_dechets,
            "date_depot": date_depot.timeIntervalSince1970, // Convert date to timestamp
            "nombre_capacite": nombre_capacite,
            "adresse": adresse,
        ] as [String : Any]

        // Convert the dictionary to JSON data
        guard let jsonData = try? JSONSerialization.data(withJSONObject: wasteData) else {
            completion(.failure(NSError(domain: "", code: 400, userInfo: nil)))
            return
        }

        // Attach the JSON data to the request
        request.httpBody = jsonData

        // Make the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle the response
            if let error = error {
                completion(.failure(error))
                return
            }

            // Parse the response data
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let newType = try decoder.decode(Dechets.self, from: data)
                    completion(.success(newType))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NSError(domain: "", code: 500, userInfo: nil)))
            }
        }

        task.resume()
    }
    
    
   
}
