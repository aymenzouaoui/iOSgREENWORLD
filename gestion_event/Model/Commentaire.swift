import Foundation

struct Commentaire: Identifiable {
    let id: String
    let date: Date
    let contenu: String
    let eventID: String
    let userID: String
    
    init?(json: [String: Any]) {
        guard
            let id = json["_id"] as? String,
            let date_String = json["date"] as? String,
            let date = ISO8601DateFormatter().date(from: date_String),
            let contenu = json["Contenu"] as? String,
            let eventID = json["eventID"] as? String,
            let userID = json["userID"] as? String
        else {
            return nil
        }

        self.id = id
        self.date = date
        self.contenu = contenu
        self.eventID = eventID
        self.userID = userID
    }
}

extension Commentaire {
    func toJSON() -> [String: Any] {
        return [
            "date": date,
            "Contenu": contenu,
            "eventID": eventID,
            "userID": userID
        ]
    }
}
