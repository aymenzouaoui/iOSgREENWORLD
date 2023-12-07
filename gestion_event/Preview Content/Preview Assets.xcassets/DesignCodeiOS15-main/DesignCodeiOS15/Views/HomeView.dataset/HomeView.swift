//
//  HomeView.swift
//  DesignCodeiOS15
//
//  Created by Alexander Sobolev on 11.5.23..
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model: Model
    @Namespace var namespace
    @State var showStatusBar = true
    @State var selectedIndex = 0
    @State var hasScrolled   = false
    @State var showEvent    = false
    @State var selectedID    = UUID()
    @State var show          = false
    
    
    
    var body: some View {
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
                
                LazyVGrid(columns: [GridItem(
                    .adaptive(minimum: 300), spacing: 20)], spacing: 20) {
                    if !show {
                        cards
                    } else {
                        ForEach(events) { event in
                            Rectangle()
                                .fill(.white)
                                .frame(height: 300)
                                .cornerRadius(30)
                                .shadow(color: Color("Shadow"), radius: 20, x: 0, y: 10)
                                .opacity(0.3)
                                .padding(.horizontal, 30)
                        }
                    }
                }
                .padding(.horizontal, 20)
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
                if newValue {
                    showStatusBar = false
                } else {
                    showStatusBar = true
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(Model())
    }
}

extension HomeView {
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
            ForEach(Array(featuredEvents.enumerated()), id: \.offset) { index, event in
                GeometryReader { proxy in
                    FeaturedItem(event: event)
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
                            Image(event.image)
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
            CourseView(show: $showEvent, event: featuredEvents[selectedIndex], namespace: namespace)
        }
    }
    
    var cards: some View {
        ForEach(events) { event in
            CourseItem(show: $show, namespace: namespace, event: event)
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
        ForEach(events) { event in
            if event.id == selectedID {
                CourseView(show: $show, event: event, namespace: namespace)
                    .zIndex(1)
                    .transition(.asymmetric(
                        insertion: .opacity.animation(.easeInOut(duration: 0.1)),
                        removal:   .opacity.animation(.easeInOut(duration: 0.3).delay(0.2))))
            }
        }
    }
}
