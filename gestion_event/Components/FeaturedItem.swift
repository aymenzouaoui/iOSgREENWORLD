//
//  FeaturedItem.swift
//  gestion_event
//
//  Created by chaima saadallah on 1/12/2023.
//

import SwiftUI
import Kingfisher

struct FeaturedItem: View {
    var event: Event

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Spacer()
            
            AsyncImage(url: URL(string: "http://localhost:9090/img/\(event.image)")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable() // Appliquer resizable à la vue Image
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200) // Ajuster la taille de l'image ici
                        .clipped()
                case .failure:
                    Image(systemName: "photo") // Vous pouvez utiliser une image de remplacement ici
                        .resizable() // Appliquer resizable à la vue Image
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200) // Ajuster la taille de l'image ici
                        .clipped()
                @unknown default:
                    EmptyView()
                }
            }
            
            Image(event.logo ?? "logo")
                .resizable(resizingMode: .stretch)
                .aspectRatio(contentMode: .fit)
                .frame(width: 26, height: 26)
                .cornerRadius(10)
                .padding(9)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                .strokeStyle(cornerRadius: 16)

            Text(event.titre)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.linearGradient(colors: [.primary, .primary.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))

            HStack {
                Image(systemName: "location.circle.fill")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                Text(event.lieu.uppercased())
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
            }

            Text(event.description)
                .font(.footnote)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.secondary)
        }
        .padding(.all, 20.0)
        .padding(.vertical, 20)
        .frame(height: 350.0)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle()
        .padding(.horizontal, 20)
    }
}

struct FeaturedItem_Previews: PreviewProvider {
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
        
        return FeaturedItem(event: sampleEvent)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
