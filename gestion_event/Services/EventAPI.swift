//
//  EventAPI.swift
//  gestion_event
//
//  Created by chaima saadallah on 4/12/2023.
//

// EventAPI.swift
// EventAPI.swift
import Combine
import Foundation

class EventAPI: ObservableObject {
    static let shared = EventAPI()

    @Published var events: [Event] = []

    func getAllEvents(completion: @escaping (Result<[Event], Error>) -> Void) {
        guard let url = URL(string: "http://localhost:9090/event") else {
                   print("Invalid URL")
                   completion(.failure(NetworkError.invalidURL))
                   return
               }

               print("Fetching events...")

               let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                   if let error = error {
                       print("Request error: \(error.localizedDescription)")
                       completion(.failure(error))
                       return
                   }

                   guard let httpResponse = response as? HTTPURLResponse else {
                       print("Invalid HTTP Response")
                       completion(.failure(NetworkError.invalidResponse))
                return
            }

            guard httpResponse.statusCode == 200 else {
                print("HTTP Response Status: \(httpResponse.statusCode)")
                completion(.failure(NetworkError.httpError(statusCode: httpResponse.statusCode)))
                return
            }

            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let eventsData = try decoder.decode([Event].self, from: data)

                    DispatchQueue.main.async {
                        self.events = eventsData
                    }

                    completion(.success(eventsData))
                } catch {
                    print("JSON decoding error: \(error)")
                    completion(.failure(error))
                }
            } else {
                print("No data received from the server.")
                completion(.failure(NetworkError.noData))
            }
        }

        task.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int)
    case noData
}
