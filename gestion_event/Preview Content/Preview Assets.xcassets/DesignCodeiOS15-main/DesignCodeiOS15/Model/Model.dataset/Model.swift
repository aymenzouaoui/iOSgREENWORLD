//
//  Model.swift
//  DesignCodeiOS15
//
//  Created by Alexander Sobolev on 19.5.23..
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

