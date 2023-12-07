//
//  CourseItem.swift
//  DesignCodeiOS15
//
//  Created by Alexander Sobolev on 14.5.23..
//

import SwiftUI

struct CourseItem: View {
    @Binding var show: Bool
    var namespace: Namespace.ID
    var event: Event = events[0]
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 12) {
                Text(event.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.linearGradient(colors: [.primary, .primary.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .matchedGeometryEffect(id: "title\(event.id)", in: namespace)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack{
                    
                    Image(systemName: "location.circle.fill").foregroundColor(.green)
                    Text(event.location.uppercased())
                        .font(.footnote.weight(.semibold))
                        .foregroundColor(.black)
                        .matchedGeometryEffect(id: "location\(event.id)", in: namespace)
                }
                HStack {
                    Image(systemName: "calendar.circle.fill")
                        .foregroundColor(.green)
                    Text(formatDate(event.datedeb))
                        .font(.footnote.weight(.semibold))
                        .foregroundColor(.black)
                        .matchedGeometryEffect(id: "datedeb\(event.id)", in: namespace)
                }
                Text(event.description)
                    .font(.footnote)
                    .foregroundColor(.black)
                    .matchedGeometryEffect(id: "text\(event.id)", in: namespace)
            }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .blur(radius: 30)
                    .matchedGeometryEffect(id: "blur\(event.id)", in: namespace)
            )
        }
        .foregroundStyle(.white)
        .background(
            Image(event.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(20)
                .matchedGeometryEffect(id: "image\(event.id)", in: namespace)
        )
        .background(
            Image(event.background)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "green\(event.id)", in: namespace)
        )
        .mask(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .matchedGeometryEffect(id: "mask\(event.id)", in: namespace)
              )
        .frame(height: 300)
    }
}

struct CourseItem_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        CourseItem(show: .constant(true), namespace: namespace)
    }
}
func formatDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    return dateFormatter.string(from: date)
}
