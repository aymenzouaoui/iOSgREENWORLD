//
//  EventView.swift
//  gestion_event
//
//  Created by chaima saadallah on 1/12/2023.
//

import SwiftUI

struct EventView: View {
    @EnvironmentObject var model: Model
    @Binding var show: Bool
    @State var viewState: CGSize = .zero
    @State var showContent = true
    @State var isDraggable = true
    @State var appear = [false, false, false]
    var event: Event
    @State private var showReservationView = false
    @State private var showCommentairenView = false
    @State private var isFavorite = false
    @ObservedObject var eventAPI = EventAPI.shared

    var namespace: Namespace.ID

    var body: some View {
        ZStack {
            ScrollView {
                cover

                if showContent {
                    content
                        .offset(y: 120)
                        .padding(.bottom, 200)
                        .opacity(appear[2] ? 1 : 0)
                }
            }
            .background(Color("vert"))
            .coordinateSpace(name: "scroll")
            .onAppear { model.showDetail = true }
            .onDisappear { model.showDetail = false }
            .background(Color("green"))
            .mask(RoundedRectangle(cornerRadius: viewState.width / 3, style: .continuous))
            .shadow(color: .black.opacity(0.3), radius: 30, x: 0, y: 10)
            .scaleEffect(viewState.width / -500 + 1)
            .background(.black.opacity(viewState.width / 500))
            .background(.ultraThinMaterial)
            .gesture(isDraggable ? drag : nil)
            .ignoresSafeArea()

            closeButton
        }
        .onAppear {
            fadeIn()
        }
        .onChange(of: show) { newValue in
            fadeOut()
        }
    }
}

// ... (EventView extension and helper functions)

// Separate extension for clarity
extension EventView {
    var closeButton: some View {
        Button {
            showContent.toggle()
            withAnimation(.closeCard) {
                show.toggle()
                model.showDetail.toggle()
            }
        } label: {
            Image(systemName: "xmark")
                .font(.body.weight(.bold))
                .foregroundColor(.secondary)
                .padding(8)
                .background(.ultraThinMaterial, in: Circle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding(30)
        .ignoresSafeArea()
    }
    
    var cover: some View {
        GeometryReader { proxy in
            let scrollY = proxy.frame(in: .named("scroll")).minY
            
            VStack {
                Spacer()
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: scrollY > 0 ? 500 + scrollY : 500)
            .foregroundStyle(.black)
            .background(
                AsyncImage(url: URL(string: "http://localhost:9090/img/\(event.image)")) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable() // Appliquer resizable à la vue Image
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .clipped()
                    case .failure:
                        Image(systemName: "photo") // Vous pouvez utiliser une image de remplacement ici
                            .resizable() // Appliquer resizable à la vue Image
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .clipped()
                    @unknown default:
                        EmptyView()
                    }
                }
                
                    .padding(20)
                    .frame(maxWidth: 500)
                    .matchedGeometryEffect(id: "image\(event.id)", in: namespace)
                    .offset(y: scrollY > 0 ? scrollY * -0.8 : 0)
            )
            
            .background(
                Image(event.background ?? "")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .matchedGeometryEffect(id: "white\(event.id)", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
                    .scaleEffect(scrollY > 0 ? scrollY / 1000 + 1 : 1)
                    .blur(radius: scrollY / 10)
            )
            
            .mask(
                RoundedRectangle(cornerRadius: appear[0] ? 0 : 30, style: .continuous)
                    .matchedGeometryEffect(id: "mask\(event.id)", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
            )
            
            
            .overlay (
                overlayContent
                    .offset(y: scrollY > 0 ? scrollY * -0.6 : 0)
            )
            
        }
        .frame(height: 500)
        
    }
    var content: some View {
        VStack(alignment: .leading, spacing: 30) {
            HStack(spacing: 20) {
                Button(action: {
                    showReservationView = true
                }) {
                    HStack {
                        Image(systemName: "person.fill.checkmark")
                        Text("Participer")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
                }
                .sheet(isPresented: $showReservationView) {
                    ReservationView(eventID: event.id)
                }
                
                
                Button(action: {
                    showCommentairenView = true
                }) {
                    HStack {
                        Image(systemName: "message")
                        Text("Commenter")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
                }
                .sheet(isPresented: $showCommentairenView) {
                    CommentView()
                }
            }
        }
        .padding(20)
    }
    
    var overlayContent: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            Text(event.titre)
                .font(.largeTitle.weight(.bold))
                .matchedGeometryEffect(id: "title\(event.id)", in: namespace)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                Image(systemName: "location.circle.fill")
                    .foregroundColor(.green)
                Text("Lieu  : ")
                    .font(.footnote.weight(.semibold))// Modifier la couleur de l'icône selon vos préférences
                Text(event.lieu.uppercased())
                    .font(.footnote.weight(.semibold))
                    .matchedGeometryEffect(id: "location\(event.id)", in: namespace)
            }
            
            HStack {
                
                Image(systemName: "calendar.circle.fill")
                    .foregroundColor(.green)
                Text("Date début de l'événement : ")
                    .font(.footnote.weight(.semibold))
                Text(formatDate(dateFromString(event.dateDebut)))
                    .font(.footnote.weight(.semibold))
                    .matchedGeometryEffect(id: "datedeb\(event.id)", in: namespace)
            }
            HStack {
                
                Image(systemName: "calendar.circle.fill")
                    .foregroundColor(.green)
                Text("Date début de l'événement : ")
                    .font(.footnote.weight(.semibold))
                Text(formatDate(dateFromString(event.dateFin)))
                    .font(.footnote.weight(.semibold))
                    .matchedGeometryEffect(id: "dateFin\(event.id)", in: namespace)
            }
            Text("Description : ")
                .font(.footnote.weight(.semibold))
            Text(event.description)
                .font(.footnote)
                .matchedGeometryEffect(id: "description\(event.id)", in: namespace)
            HStack {
                Spacer()
                Button(action: {
                    
                }) {
                    Image(systemName: "suit.heart.fill")
                        .foregroundColor(.red)
                        .padding()
                        .background(Color.white)
                        .clipShape(Circle())
                }
            }
        }
        .padding(.top, 35)
        .padding(.horizontal)
        
        
        
        .background(
            Rectangle()
                .fill(.ultraThinMaterial)
                .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .matchedGeometryEffect(id: "blur\(event.id)", in: namespace)
        )
        .offset(y: 250)
        .padding(20)
        
    }
    
    var drag: some Gesture {
        DragGesture(minimumDistance: 30, coordinateSpace: .local)
            .onChanged { value in
                guard value.translation.width > 0 else { return }
                
                if value.startLocation.x < 100 {
                    withAnimation {
                        viewState = value.translation
                    }
                }
                
                if viewState.width > 250 {
                    close()
                }
            }
            .onEnded { value in
                if viewState.width > 180 {
                    close()
                } else {
                    withAnimation(.openCard) {
                        viewState = .zero
                    }
                }
            }
    }
    
    func fadeIn() {
        withAnimation(.easeInOut.delay(0.3)) {
            appear[0] = true
        }
        withAnimation(.easeInOut.delay(0.4)) {
            appear[1] = true
        }
        withAnimation(.easeInOut.delay(0.5)) {
            appear[2] = true
        }
    }
    
    func fadeOut() {
        appear[0] = false
        appear[1] = false
        appear[2] = false
    }
    
    func close() {
        showContent = false
        withAnimation {
            viewState = .zero
        }
        withAnimation(.closeCard.delay(0.2)) {
            model.showDetail = false
            model.selectedCourse = 0
            show = false
        }
        isDraggable = false
    }
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
    
    func dateFromString(_ dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: dateString) {
            return date
        } else {
            // Return a default date or handle the error as needed
            return Date()
        }
    }
    
    
    struct EventView_Previews: PreviewProvider {
        @Namespace static var namespace
        
        static var previews: some View {
            let jsonString = """
    {
        "titre": "Sample Event",
        "dateDebut": "2023-12-01T12:00:00Z",
        "dateFin": "2023-12-02T12:00:00Z",
        "lieu": "Sample Location",
        "description": "This is a sample event.",
        "nbparticipant": 50,
        "nbPlace": 100,
        "image": "sample_image",
        "latitude": 37.7749,
        "longitude": -122.4194,
        "__v": 1,
        "background": "sample_background",
        "logo": "sample_logo",
        "index": 0
    }
    """
            
            let jsonData = jsonString.data(using: .utf8)!
            let decoder = JSONDecoder()
            let sampleEvent = try! decoder.decode(Event.self, from: jsonData)
            
            return  EventView(show: .constant(true), event: sampleEvent,namespace: namespace)
        }
    }
}
