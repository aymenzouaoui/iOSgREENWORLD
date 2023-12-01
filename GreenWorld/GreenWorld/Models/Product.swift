import Foundation

struct Product: Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var image: String
    var price: Int
    var quantity: Int

    init?(json: [String: Any]) {
        guard
            let title = json["title"] as? String,
            let description = json["description"] as? String,
            let image = json["image"] as? String,
            let price = json["price"] as? Int,
            let quantity = json["quantity"] as? Int
        else {
            return nil
        }

        self.title = title
        self.description = description
        self.image = image
        self.price = price
        self.quantity = quantity
    }
}
