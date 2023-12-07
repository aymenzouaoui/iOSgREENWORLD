import SwiftUI

struct ReservationView: View {
    enum FocusedField {
        case fName, lName, email, pNumber, age
    }
    
    @State private var fName = ""
    @State private var lName = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    @State private var age = ""
    let eventID: UUID // Pass event ID as a parameter

    @FocusState private var fieldFocus: FocusedField?
    @State private var selectedDate = Date()
    @State private var reservationError: String?

    var body: some View {
        NavigationView {
            Form {
                Section("Date") {
                    DatePicker("Choisissez une date", selection: $selectedDate, displayedComponents: .date)
                }
                
                Button(action: {
                    makeReservation()
                }, label: {
                    Text("Reserver")
                        .frame(maxWidth: .infinity)
                })
                .buttonStyle(.borderedProminent)
                .tint(.green)
                
                // Display error message if reservationError is not nil
                Text(reservationError ?? "")
                    .foregroundColor(.red)
            }
            .onSubmit {
                switchField(currentField: fieldFocus ?? .fName)
            }
            .navigationTitle("Reservation Form")
        }
    }
    
    func switchField(currentField: FocusedField) {
        switch currentField {
        case .fName:
            fieldFocus = .lName
        case .lName:
            fieldFocus = .email
        case .email:
            fieldFocus = .pNumber
        case .pNumber:
            fieldFocus = .age
        case .age:
            fieldFocus = .fName
        }
    }
    
    func makeReservation() {
        // Convert the UUID to a string representation

        // Assuming you have a backend URL for making reservations
        guard let url = URL(string: "http://localhost:9090/api") else {
            print("Invalid URL")
            return
        }
        
        // Prepare the data for the reservation request
        let dateFormatter = DateFormatter.iso8601Full
        let dateString = dateFormatter.string(from: selectedDate)
        
        let reservationData: [String: Any] = [
            "date_reservation": dateString,
            "eventID": "656f7ccf6b3a7e28e9b49249",
            "userID": "6557fea6fb5c6a93876129f1"   // Replace with the actual userID
            // Include other necessary data fields like fName, lName, email, etc.
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: reservationData)
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            // Make the reservation request
            URLSession.shared.dataTask(with: request) { data, response, error in
                // Handle the response (success or failure)
                if let error = error {
                    print("Error making reservation request: \(error)")
                    // Display an error message
                    reservationError = "Error making reservation. Please try again."
                } else if let data = data {
                    // Parse the response if needed
                    // For example, if your backend returns a success message
                    if let result = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print("Reservation success: \(result)")
                        // Display a success message
                        reservationError = "Reservation added successfully!"
                    }
                } else {
                    print("Unexpected response format")
                    // Display an error message
                    reservationError = "Unexpected response format."
                
                }
            }.resume()
            
        } catch {
            print("Error serializing reservation data: \(error)")
            // Display an error message
            reservationError = "Error serializing reservation data."
        }
    }

    struct ReservationView_Previews: PreviewProvider {
        static var previews: some View {
            // Assuming you have an event with a valid UUID for testing
            let sampleEventID = UUID()

            // Use the eventID parameter when creating ReservationView
            ReservationView(eventID: sampleEventID)
        }
    }
    
}
