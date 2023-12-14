//
//  TypeItem.swift
//  GreenWorld
//
//  Created by ChaimaEljed on 5/12/2023.
//

import Foundation
import SwiftUI

struct TypeItem: Identifiable { // Renamed to WasteType and added Decodable conformance
    var id = UUID().uuidString
    var color: Color
    var detail: String
}
