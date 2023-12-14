//
//  Dechets.swift
//  GreenWorld
//
//  Created by ChaimaEljed on 30/11/2023.
//

import SwiftUI

struct Dechets: Identifiable, Decodable {
    var id = UUID().uuidString
    var Type_dechets: String
    var date_depot: Date
    var nombre_capacite: Int
    var adresse: String
    //var qrcode:String
    
    enum CodingKeys: String, CodingKey {
        case Type_dechets
        case date_depot
        case nombre_capacite
        case adresse
       // case qrcode
    }
}

    
