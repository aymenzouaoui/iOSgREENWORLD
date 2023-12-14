//
//  Type.swift
//  GreenWorld
//
//  Created by ChaimaEljed on 30/11/2023.
//
import SwiftUI
struct WasteType: Identifiable, Decodable { // Renamed to WasteType and added Decodable conformance
    var id = UUID().uuidString
    var image_type: String
    var titre: String
    var description: String
   

enum CodingKeys: String, CodingKey {
        case id
        case image_type
        case titre
        case description
    
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        image_type = try container.decode(String.self, forKey: .image_type)
        titre = try container.decode(String.self, forKey: .titre)
        description = try container.decode(String.self, forKey: .description)
        // Assuming color and detail are also String properties; adjust if they are of different types
   
    }
}





