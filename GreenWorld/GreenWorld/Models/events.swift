//
//  events.swift
//  GreenWorld
//
//  Created by ChaimaEljed on 30/11/2023.
//

import SwiftUI

struct event: Identifiable {
    let id = UUID()
    var index: Int
    var title: String
    var description: String
    var location: String
    var image: String
    var background: String
    var logo: String
    var nbPlace: Int
    var nbParticipant: Int
    var datedeb: Date
    var datefin: Date
}

var events = [
    event(index: 1, title: "Chaima", description: "Participez vous", location:"Ariana", image: "event4", background: "", logo: "Logo 2",nbPlace: 50,nbParticipant: 100,datedeb: Date(),datefin: Date())
  
]

var featuredEvents = [
    event(index: 1, title: "Saadallah", description: "A9wa Event ", location:"Centre ville", image: "event5", background: "", logo: "logo",nbPlace: 50,nbParticipant: 100,datedeb: Date(),datefin: Date())
    
]
