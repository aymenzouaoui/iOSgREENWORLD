//
//  Course.swift
//  DesignCodeiOS15
//
//  Created by Alexander Sobolev on 12.5.23..
//

import SwiftUI

struct Event: Identifiable {
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
    Event(index: 1, title: "Chaima", description: "Participez vous", location:"Ariana", image: "event4", background: "", logo: "Logo 2",nbPlace: 50,nbParticipant: 100,datedeb: Date(),datefin: Date())
  
]

var featuredEvents = [
    Event(index: 1, title: "Saadallah", description: "A9wa Event ", location:"Centre ville", image: "event5", background: "", logo: "logo",nbPlace: 50,nbParticipant: 100,datedeb: Date(),datefin: Date())
    
]
