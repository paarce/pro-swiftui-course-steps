//
//  SwiftUIView43Challenge.swift
//  ProSwift Steps
//
//  Created by Augusto Cordero Perez on 22/2/23.
//

import SwiftUI

struct EqualHeightVStack: Layout {

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let maxSize = maxSize(accross: subviews)
        let spacing = spacing(for: subviews)
        let totalSpacing = spacing.reduce(0, +)
        return CGSize(width: 100, height: maxSize.height * Double(subviews.count) + totalSpacing)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let maxSize = maxSize(accross: subviews)
        let spacing = spacing(for: subviews)

        let proposal = ProposedViewSize(width: maxSize.width, height: maxSize.height)
        var curentY = bounds.minY + maxSize.height / 2

        for index in subviews.indices {
            subviews[index].place(at: CGPoint(x: bounds.midX, y: curentY), anchor: .center, proposal: proposal)
            curentY += maxSize.height + spacing[index]
        }
    }

    private func maxSize(accross subviews: Subviews) -> CGSize {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        return sizes.reduce(.zero) { largest, next in
                .init(width: 100, height: max(largest.height, next.height))
        }
    }

    private func spacing(for subviews: Subviews) -> [Double] {
        subviews.indices.map {
            guard $0 < subviews.count - 1 else { return 0 }
            return subviews[$0].spacing.distance(to: subviews[$0 + 1].spacing, along: .vertical)
        }
    }
}


struct SwiftUIView43Challenge: View {
    var body: some View {
        EqualHeightVStack {
            Text("Hello, World! Hello, World! Hello, World! Hello, World!")
                .lineLimit(0)
                .frame(width: 50)
//                .background(.blue)
            Text("Hello")
//                .background(.green)
            Text("shadjksa")
//                .background(.green)
            Text("shadjksa")
//                .background(.green)
            Text("shadjksa")
//                .background(.green)
            Text("shadjksa")
//                .background(.green)
            Text("shadjksa")
//                .background(.green)
        }
        .frame(maxWidth: 50)
        .frame(width: 50)
        .background(.cyan)
    }
}

struct SwiftUIView43Challenge_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView43Challenge()
    }
}
