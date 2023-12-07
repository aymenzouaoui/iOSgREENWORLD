//
//  ContentView.swift
//  gestion_event
//
//  Created by chaima saadallah on 1/12/2023.
//

import SwiftUI
import CoreData
struct ContentView: View {
    @EnvironmentObject var model: Model
    
    var body: some View {
        ZStack(alignment: .bottom) {
            EventListView(events: createSampleEvent()) // Pass a single Event instance
        }
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 44)
        }
    }
    
    func createSampleEvent() -> Event {
        let jsonString = """
        {
            "titre": "Sample Event",
            "dateDebut": "2023-12-01T12:00:00Z",
            "dateFin": "2023-12-02T12:00:00Z",
            "lieu": "Sample Location",
            "description": "This is a sample event.",
            "nbparticipant": 50,
            "nbPlace": 100,
            "image": "sample_image",
            "latitude": 37.7749,
            "longitude": -122.4194,
            "__v": 1,
            "background": "sample_background",
            "logo": "sample_logo",
            "index": 0
        }
        """

        let jsonData = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let sampleEvent = try! decoder.decode(Event.self, from: jsonData)

        return sampleEvent
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(Model())
    }
}
