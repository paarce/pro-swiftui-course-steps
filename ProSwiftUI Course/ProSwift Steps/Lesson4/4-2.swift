//
//  4-2.swift
//  ProSwift Steps
//
//  Created by Augusto Cordero Perez on 24/1/23.
//

import SwiftUI

struct RadialLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let radius = min(bounds.size.width, bounds.size.height) / 2
        let angle = Angle.degrees(360 / Double(subviews.count)).radians

        for (index, subview) in subviews.enumerated() {
            let viewSize = subview.sizeThatFits(.unspecified)
            let offset: Double = .pi / 2
            let xPos = cos(angle * Double(index) - offset) * (radius - viewSize.width / 2)
            let yPos = sin(angle * Double(index) - offset) * (radius - viewSize.height / 2)

            let point = CGPoint(x: bounds.midX + xPos, y: bounds.midY + yPos)
            subview.place(at: point, anchor: .center, proposal: .unspecified)
        }
    }
}

struct SwiftUIView42: View {

    @State private var count = 16
    let size = 40.0

    var body: some View {
        RadialLayout {
            ForEach(0..<count, id: \.self) { _ in
                Circle()
                    .frame(width: size, height: size)
            }
        }
        .safeAreaInset(edge: .bottom) {
            Stepper("Count: \(count)", value: $count.animation(), in: 0...36)
                .padding()
        }
    }
}

struct SwiftUIView42_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView42()
    }
}
