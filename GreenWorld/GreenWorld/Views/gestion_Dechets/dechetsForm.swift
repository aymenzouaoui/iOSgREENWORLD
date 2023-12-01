//
//  dechetsForm.swift
//  GreenWorld
//
//  Created by ChaimaEljed on 30/11/2023.
//

import SwiftUI

struct dechetsForm: View {
    @State private var type: String = ""
       @State private var date: Date = Date()
       @State private var poids: String = ""
       @State private var adresse: String = ""
       @State private var isShowingDetails: Bool = false

       var body: some View {
           VStack {
               
               TextField("type", text: $type)
                   .textFieldStyle(RoundedBorderTextFieldStyle())
                   .padding()

               DatePicker("Date", selection: $date, displayedComponents: .date)
                   .padding()

            

               TextField("capacite ", text: $poids)
                   .textFieldStyle(RoundedBorderTextFieldStyle())
                   .padding()

               TextField("Adresse", text: $adresse)
                   .textFieldStyle(RoundedBorderTextFieldStyle())
                   .padding()

               Button(action: {
                   isShowingDetails = true
               }) {
                   Text("Envoyer")
                       .font(.headline)
                       .foregroundColor(.white)
                       .padding()
                       .background(Color.green)
                       .cornerRadius(10)
               }
               .sheet(isPresented: $isShowingDetails) {
                   DetaildechetView(type: type, date: date,poids: poids, adresse: adresse)
               }
           }
           //.padding(.vertical)
          // .padding(.horizontal)
           .background(Image("6743"))
       }
   }

#Preview {
    dechetsForm()
}
