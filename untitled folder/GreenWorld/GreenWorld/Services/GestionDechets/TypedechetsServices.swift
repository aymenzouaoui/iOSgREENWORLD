//
//  TypedechetsServices.swift
//  GreenWorld
//
//  Created by ChaimaEljed on 4/12/2023.
//

import Foundation

class TypedechetsServices: ObservableObject {
    
    @Published var wasteTypes: [WasteType] = []

    func getAllTypes(completion: @escaping ([WasteType]?) -> Void) {
            guard let url = URL(string: "http://192.168.0.130:9090/type") else {
                completion(nil)
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"

            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
                    completion(nil)
                    return
                }

                do {
                    let decodedData = try JSONDecoder().decode([WasteType].self, from: data)
                    print(decodedData )
                    DispatchQueue.main.async {
                        self.wasteTypes = decodedData
                        completion(decodedData)
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(nil)
                }
            }.resume()
        }
    
    /*
    func getAllTypes(completion: @escaping ([WasteType]?) -> Void) {
        guard let url = URL(string: "http://192.168.0.130:9090/type") else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            do {
                let decoder = JSONDecoder()
                let types = try decoder.decode([WasteType].self, from: data)
                completion(types)
            } catch {
                print("Error decoding data: \(error)")
                completion(nil)
            }
        }.resume()
    }*/
}
