//
//  Model.swift
//  GreenWorld
//
//  Created by ChaimaEljed on 30/11/2023.
//

import SwiftUI
import Combine

class Model: ObservableObject {
   
    
    // Modal
    @Published var showModal: Bool      = false
    @Published var dismissModal: Bool   = false
    
    // Detail View
    @Published var showDetail: Bool     = false
    @Published var selectedCourse: Int  = 0
}

