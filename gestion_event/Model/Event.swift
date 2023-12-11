//
//  Event.swift
//  gestion_event
//
//  Created by chaima saadallah on 1/12/2023.
//

import SwiftUI
import Foundation
struct Event: Identifiable, Decodable {
    let id: UUID
    var titre: String
    var dateDebut: String
    var dateFin: String
    var lieu: String
    var description: String
    var nbparticipant: Int
    var nbPlace: Int
    var image: String
    var latitude: Double?
    var longitude: Double?
    var comments: [Commentaire]?
    var __v: Int
    var background: String?
    var logo: String?
    var index: Int?

    private enum CodingKeys: String, CodingKey {
        case id
        case titre
        case dateDebut
        case dateFin
        case lieu
        case description
        case nbparticipant
        case nbPlace
        case image
        case latitude
        case longitude
        case comments  // Include the property in coding keys
        case __v
        case background
        case logo
        case index
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
        titre = try container.decode(String.self, forKey: .titre)
        dateDebut = try container.decode(String.self, forKey: .dateDebut)
        dateFin = try container.decode(String.self, forKey: .dateFin)
        lieu = try container.decode(String.self, forKey: .lieu)
        description = try container.decode(String.self, forKey: .description)
        nbparticipant = try container.decode(Int.self, forKey: .nbparticipant)
        nbPlace = try container.decode(Int.self, forKey: .nbPlace)
        image = try container.decode(String.self, forKey: .image)
        latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
        longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)
        comments = try container.decodeIfPresent([Commentaire].self, forKey: .comments)  // Decode as [Commentaire]
        __v = try container.decode(Int.self, forKey: .__v)
        background = try container.decodeIfPresent(String.self, forKey: .background)
        logo = try container.decodeIfPresent(String.self, forKey: .logo)
        index = try container.decodeIfPresent(Int.self, forKey: .index)
    }
}
extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
}
