//
//  SearchView.swift
//  DesignCodeiOS15
//
//  Created by Alexander Sobolev on 29.5.23..
//

import SwiftUI

struct SearchView: View {
    @Environment(\.dismiss) private var dismiss
    @Namespace var namespace
    @State var selectedEvent = events[0]
    @State var selectedIndex  = 0
    @State var showEvent     = false
    @State var text           = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    content
                }
                .padding(20)
                .background(.ultraThinMaterial, in:
                 RoundedRectangle(cornerRadius: 30, style: .continuous))
                .strokeStyle(cornerRadius: 30)
                .padding(20)
                .background(
                    Rectangle()
                        .fill(.regularMaterial)
                        .frame(height: 200)
                        .frame(maxHeight: .infinity, alignment: .top)
                        .offset(y: -200)
                        .blur(radius: 20)
                )
                .background(
                Image("Blob 1")
                    .offset(x: -100, y: -200)
                )
            }
            .searchable(
            text: $text,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "SwiftUI, React UI Design") {
                ForEach(suggestions) { suggestion in
                    Button {
                        text = suggestion.text
                    } label: {
                        Text(suggestion.text)
                            .searchCompletion(suggestion.text)
                    }
                }
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Text("Done")
                        .bold()
                }
            }
            .sheet(isPresented: $showEvent) {
                CourseView(show: $showEvent, event: events[selectedIndex], namespace: namespace)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        //SearchView()
    }
}

