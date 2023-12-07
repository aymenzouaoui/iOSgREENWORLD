//
//  EventListView.swift
//  gestion_event
//
//  Created by chaima saadallah on 1/12/2023.
//

import SwiftUI
struct EventListView: View {
    @EnvironmentObject var model: Model
    @Namespace var namespace
    @State var showStatusBar = true
    @State var hasScrolled = false
    @State var showEvent = false
    @State var selectedIndex = 0
    @State private var image: UIImage? = nil



    @State var selectedID: UUID? // Use optional UUID to track selected event
    @State var show = false
    var events:Event
    @ObservedObject var eventAPI = EventAPI.shared
    @State private var showDetails: [UUID: Bool] = [:]
    
    struct EventListView_Previews: PreviewProvider {
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
            
            return EventListView(events: sampleEvent)
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
    
    // ... (existing code)
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    scrollDetection
                    
                    featured
                    
                    Text("Events".uppercased())
                        .font(.footnote.weight(.semibold))
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 300), spacing: 20)], spacing: 20) {
                        if !show {
                            cards
                        }else
                        {
                            ForEach(eventAPI.events) { event in
                                NavigationLink(
                                    destination: EventView(show: $showEvent, event: event, namespace: namespace),
                                    tag: event.id,
                                    selection: $selectedID,
                                    label: {
                                        FeaturedItem(
                                            event: event
                                        )
                                        .onTapGesture {
                                            withAnimation(.openCard) {
                                                selectedID = event.id
                                                model.showDetail.toggle()
                                                showStatusBar = false
                                            }
                                        }
                                    }
                                )

                            }
                        }
                        }
                            .padding(.horizontal, 20)
                            .onAppear {
                                eventAPI.getAllEvents { _ in }
                            }
                    }
                    .coordinateSpace(name: "scroll")
                    .safeAreaInset(edge: .top, content: {
                        Color.clear.frame(height: 70)
                    })
                    
                    if show {
                        detail
                    }
                }
                .statusBarHidden(!showStatusBar)
                .onChange(of: show) { newValue in
                    withAnimation(.closeCard) {
                        showStatusBar = !newValue
                    }
                }
                .navigationTitle("Liste des événements")
            }
        }
    private func uiImage(from image: Image) -> UIImage {
        // Your UIImage conversion code
        // ...
        return UIImage(systemName: "photo")!
    }
        
    }

extension EventListView {
    var scrollDetection: some View {
        GeometryReader { proxy in
            Color.clear.preference(
                key: ScrollPreferenceKey.self,
                value: proxy.frame(in: .named("scroll")).minY
            )
        }
        .frame(height: 0)
        .onPreferenceChange(ScrollPreferenceKey.self, perform: { value in
            withAnimation(.easeInOut) {
                if value < 0 {
                    hasScrolled = true
                } else {
                    hasScrolled = false
                }
            }
        })
    }
    var featured: some View {
        TabView {
            ForEach(eventAPI.events.indices, id: \.self) { index in
                
                GeometryReader { proxy in
                    FeaturedItem(event: eventAPI.events[index])
                        .frame(maxWidth: 500)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 40)
                        .rotation3DEffect(
                            .degrees(proxy.frame(in: .global).minX / -10),
                            axis: (x: 0, y: 1, z: 0), perspective: 1
                        )
                        .shadow(color: Color("Shadow").opacity(0.3),
                                radius: 10, x: 0, y: 10)
                        .blur(radius: abs(proxy.frame(in: .global).minX) / 40)
                        .overlay(
                            Image(eventAPI.events[index].image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .offset(x: 32, y: -80)
                                .frame(height: 230)
                                .offset(x: proxy.frame(in: .global).minX / 40)
                                .rotation3DEffect(
                                    .degrees(proxy.frame(in: .global).minX / -10),
                                    axis: (x: 0, y: 1, z: 0), perspective: 1
                                )
                                .blur(radius: abs(proxy.frame(in: .global).minX) / 40)
                        )
                        .onTapGesture {
                            showEvent = true
                            selectedIndex = index
                        }
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 430)
        .background(
            Image("Blob 1")
                .offset(x: 250, y: -100)
        )
        .sheet(isPresented: $showEvent) {
            EventView(show: $showEvent, event: eventAPI.events[selectedIndex], namespace: namespace)
        }
    }

    var cards: some View {
        ForEach(eventAPI.events) { event in
            FeaturedItem(event: event)
            
                .onTapGesture {
                    withAnimation(.openCard) {
                        show.toggle()
                        model.showDetail.toggle()
                        showStatusBar = false
                        selectedID = event.id
                    }
                }
        }
        
    }

    var detail: some View {
        ForEach(eventAPI.events) { event in
            if event.id == selectedID {
                EventView(show: $show, event: event, namespace: namespace)
                    .zIndex(1)
                    .transition(.asymmetric(
                        insertion: .opacity.animation(.easeInOut(duration: 0.1)),
                        removal:   .opacity.animation(.easeInOut(duration: 0.3).delay(0.2))))
            }
        }
    }
}

