//
//  CommentView.swift
//  gestion_event
//
//  Created by chaima saadallah on 1/12/2023.
//
import SwiftUI

struct CommentView: View {
    @State private var feedbackText = ""
    @State private var reservationError: String?
    @State private var isCommentAdded: Bool = false // Nouvelle variable d'état
    var event: Event
        var associatedComments: [Commentaire]
    init(event: Event, associatedComments: [Commentaire]) {
        self.event = event
        self.associatedComments = associatedComments
    }

    var body: some View {
            VStack {
                HStack {
                    Image(systemName: "pencil.circle.fill")
                        .font(.largeTitle)
                    
                    Text("Feedback")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                
                
                .padding()
                
                VStack {
                    Image(systemName: "bubble.left.fill")
                        .font(.title)
                        .foregroundColor(.gray)
                        .padding(.bottom, 8)
                    
                    TextEditor(text: $feedbackText)
                        .frame(height: 200)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(.bottom, 16)
                }
                
                HStack {
                    Button(action: submitFeedback) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .padding(.trailing)
                    
                    Button(action: cancelFeedback) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                }
                .padding(.bottom)
                // Affiche le tick de validation si le commentaire est ajouté avec succès
                if isCommentAdded {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.green)
                        .padding()
                }
            }
            
            .padding()
            .onTapGesture {
                // Hide the keyboard when tapping outside the text editor
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            
        }
    func submitFeedback() {
        guard let url = URL(string: "http://localhost:9090/comment") else {
            print("Invalid URL")
            return
        }

        let dateFormatter = ISO8601DateFormatter()
        let dateFormatted = dateFormatter.string(from: Date())

        let commentData: [String: Any] = [
            "date": dateFormatted,
            "Contenu": feedbackText,
            "eventID": event.id, // Utilisez l'identifiant de l'événement
            "userID": "654f70fb5cb452f9138dbf46"
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: commentData)

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData

            // Faites la requête de commentaire
            URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async { // Mettez à jour l'interface utilisateur sur le thread principal
                    if let error = error {
                        print("Error making commentaire request: \(error)")
                        reservationError = "Error making commentaire. Please try again."
                    } else if let data = data {
                        if let result = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            print("Commentaire success: \(result)")
                            reservationError = "Commentaire added successfully!"
                            isCommentAdded = true
                        }
                    } else {
                        print("Unexpected response format")
                        reservationError = "Unexpected response format."
                    }
                }
            }.resume()

        } catch {
            print("Error serializing comment data: \(error)")
            reservationError = "Error serializing comment data."
        }
    }

        func cancelFeedback() {
            // Logic to cancel the feedback
            feedbackText = ""
        }
    }


