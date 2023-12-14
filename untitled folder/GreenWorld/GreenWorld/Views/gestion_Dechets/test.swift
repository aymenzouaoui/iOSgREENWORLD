//
//  test.swift
//  GreenWorld
//
//  Created by ChaimaEljed on 8/12/2023.
//

import SwiftUI

struct test: View {
    var type_dechets: String
    var date_depot: Date
    var nombre_capacite: Int
    var adresse: String

    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE d MMMM yyyy 'at' h:mm a"
        return dateFormatter.string(from: date_depot)
    }

    var body: some View {
            NavigationView {
                ZStack {
                    Color.green1
                        .ignoresSafeArea()
                    Circle()
                        .scale(1.7)
                        .foregroundColor(.white.opacity(0.15))
                    Circle()
                        .scale(1.35)
                        .foregroundColor(.white)

                    VStack {
                        Text("Recycle")
                            .font(.largeTitle)
                            .bold()
                            .padding()
                        VStack {
                            // Display the details as you wish
                            Text("Type de déchets:                 \(type_dechets)")
                                .padding()
                            Text(" Date de dépôt:                  \(formattedDate)")
                                .padding()
                            Text(" Capacite en g :                 \(nombre_capacite)")
                                .padding()
                            Text("  Adresse :                      \(adresse)")
                                .padding()



                        }
                      
                      

                     
                      
                        
                    
                    } .navigationBarTitle("", displayMode: .inline)

                }.navigationBarHidden(true)
            }
        }
        
    
    }


