import Foundation

struct Reservation: Identifiable {
    let id: String
    let date_reservation: Date
    let eventID: UUID  // Update the type to UUID
    let userID: String // Mettez à jour le type de l'ID de l'utilisateur
    
    init?(json: [String: Any]) {
        guard
            let id = json["_id"] as? String,
            let date_reservationString = json["date_reservation"] as? String,
            let date_reservation = ISO8601DateFormatter().date(from: date_reservationString),
            let eventIDString = json["eventID"] as? String,
                    let eventID = UUID(uuidString: eventIDString),            
                let userID = json["userID"] as? String
        else {
            return nil
        }

        self.id = id
        self.date_reservation = date_reservation
        self.eventID = eventID
        self.userID = userID
    }
}

