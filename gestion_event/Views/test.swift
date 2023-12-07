//
//  test.swift
//  gestion_event
//
//  Created by chaima saadallah on 5/12/2023.
//

import SwiftUI

struct TestView: View {
    @ObservedObject var eventAPI = EventAPI.shared

      var body: some View {
          NavigationView {
              List(eventAPI.events) { event in
                  NavigationLink(destination: EventDetailView(event: event)) {
                      EventRowView(event: event)
                  }
              }
              .navigationTitle("Liste des événements")
          }
          .onAppear {
              // Chargez les événements lorsque la vue apparaît
              eventAPI.getAllEvents { _ in }
          }
      }
  
}
struct EventRowView: View {
    var event: Event

    var body: some View {
        VStack(alignment: .leading) {
            Text(event.titre)
                .font(.headline)
            Text(event.lieu)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

struct EventDetailView: View {
    var event: Event

    var body: some View {
        // Ajoutez le code pour afficher les détails de l'événement ici
        Text("Détails de l'événement: \(event.titre)")
    }
}


struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
