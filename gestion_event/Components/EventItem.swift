//
//  EventItem.swift
//  gestion_event
//
//  Created by chaima saadallah on 1/12/2023.
//
/*
import SwiftUI

struct EventItem: View {
    @Binding var show: Bool
    var namespace: Namespace.ID
    var event: Event

    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 12) {
                Text(event.titre)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.linearGradient(colors: [.primary, .primary.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .matchedGeometryEffect(id: "title\(event.id)", in: namespace)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    Image(systemName: "location.circle.fill")
                        .foregroundColor(.green)
                    Text(event.lieu.uppercased())
                        .font(.footnote.weight(.semibold))
                        .foregroundColor(.black)
                        .matchedGeometryEffect(id: "location\(event.id)", in: namespace)
                }
                HStack {
                    Image(systemName: "calendar.circle.fill")
                        .foregroundColor(.green)
                    Text(formatDate(dateFromString(event.dateDebut)))
                        .font(.footnote.weight(.semibold))
                        .foregroundColor(.black)
                        .matchedGeometryEffect(id: "datedeb\(event.id)", in: namespace)
                }
                Text(event.description)
                    .font(.footnote)
                    .foregroundColor(.black)
                    .matchedGeometryEffect(id: "text\(event.id)", in: namespace)
            }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .blur(radius: 30)
                    .matchedGeometryEffect(id: "blur\(event.id)", in: namespace)
            )
        }
        .foregroundStyle(.white)
        .background(
            AsyncImage(url: URL(string: "http://localhost:9090/img/\(event.image)")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable() // Appliquer resizable à la vue Image
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .clipped()
                case .failure:
                    Image(systemName: "photo") // Vous pouvez utiliser une image de remplacement ici
                        .resizable() // Appliquer resizable à la vue Image
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .clipped()
                @unknown default:
                    EmptyView()
                }
            }
        )
        .padding(20)
        .matchedGeometryEffect(id: "image\(event.id)", in: namespace)
        .background(
            Image(event.background ?? "") // Fournir un nom d'image par défaut ou gérer le cas nil
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "green\(event.id)", in: namespace)
                .clipped()
        )
        .mask(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .matchedGeometryEffect(id: "mask\(event.id)", in: namespace)
        )
        .frame(height: 300)
        .onTapGesture {
            withAnimation {
                show.toggle()
            }
        }
    }

    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy" // Définissez votre format de date souhaité
        return dateFormatter.string(from: date)
    }

    func dateFromString(_ dateString: String) -> Date {
        let dateFormatter = ISO8601DateFormatter()
        if let date = dateFormatter.date(from: dateString) {
            return date
        } else {
            // Retourner une date par défaut ou gérer l'erreur selon les besoins
            return Date()
        }
    }
}

struct EventItem_Previews: PreviewProvider {
    @Namespace static var namespace

    static var previews: some View {
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

        return EventItem(show: .constant(true), namespace: namespace, event: sampleEvent)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}*/
