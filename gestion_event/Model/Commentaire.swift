import Foundation

struct Commentaire: Identifiable, Decodable {
    var id: String // Use UUID for the id property
    let date: String
    let contenu: String
    let eventID: String
    let userID: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id" // Match the key in the JSON data
        case date
        case contenu = "Contenu"
        case eventID
        case userID
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        contenu = try container.decode(String.self, forKey: .contenu)
        eventID = try container.decode(String.self, forKey: .eventID)
        userID = try container.decode(String.self, forKey: .userID)
        date = try container.decode(String.self, forKey: .date)
    }
}
