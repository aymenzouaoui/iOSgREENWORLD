//
//  Model.swift
//  gestion_event
//
//  Created by chaima saadallah on 1/12/2023.
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
