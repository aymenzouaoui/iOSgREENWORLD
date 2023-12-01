//
//  Suggestion.swift
//  GreenWorld
//
//  Created by ChaimaEljed on 30/11/2023.
//

import SwiftUI

struct Suggestion: Identifiable {
    let id = UUID()
    var text: String
}

var suggestions = [
    Suggestion(text: "SwiftUI"),
    Suggestion(text: "Flutter"),
    Suggestion(text: "Design"),
    Suggestion(text: "React")
]
