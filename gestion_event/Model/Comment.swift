import Foundation

struct Comment: Decodable, Identifiable {
    var id: String { idComment }
    let idComment: String
    var Contenu: String?
    var date: String?
    var userID: String?
    let eventID: String?

    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case Contenu
        case date
        case userID
        case eventID
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idComment = try container.decode(String.self, forKey: .id)
        Contenu = try? container.decode(String.self, forKey: .Contenu)
        date = try? container.decode(String.self, forKey: .date)
        userID = try? container.decode(String.self, forKey: .userID)
        eventID = try container.decode(String.self, forKey: .eventID)
    }
}
