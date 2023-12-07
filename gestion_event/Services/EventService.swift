//
//  EventService.swift
//  gestion_event
//
//  Created by chaima saadallah on 4/12/2023.
//
import Foundation
import Combine

class EventService: ObservableObject {
    static let shared = EventService()
    
    @Published var events: [Event] = []
    let dateFormatter = DateFormatter()
    
    func getAllEvents(model: Model, completion: @escaping ([Event]?) -> Void) {
        guard let url = URL(string: "http://172.18.24.89:9090/event") else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Request error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let eventsData = try decoder.decode([Event].self, from: data)
                    
                    // Update the @Published property to notify subscribers (like SwiftUI views) of changes
                    DispatchQueue.main.async {
                        self.events = eventsData
                    }
                    
                    completion(eventsData)
                } catch {
                    print("JSON serialization error: \(error.localizedDescription)")
                    completion(nil)
                }
            }
        }
        
        task.resume()
    }
}
