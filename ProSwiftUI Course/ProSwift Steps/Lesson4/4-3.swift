//
//  SwiftUIView43.swift
//  ProSwift Steps
//
//  Created by Augusto Cordero Perez on 22/2/23.
//

import SwiftUI

struct EqualWidthHStack: Layout {

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let maxSize = maxSize(accross: subviews)
        let spacing = spacing(for: subviews)
        let totalSpacing = spacing.reduce(0, +)
        return CGSize(width: maxSize.width * Double(subviews.count) + totalSpacing, height: maxSize.height)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let maxSize = maxSize(accross: subviews)
        let spacing = spacing(for: subviews)

        let proposal = ProposedViewSize(width: maxSize.width, height: maxSize.height)
        var curentX = bounds.minX + maxSize.width / 2

        for index in subviews.indices {
            subviews[index].place(at: CGPoint(x: curentX, y: bounds.midY), anchor: .center, proposal: proposal)
            curentX += maxSize.width + spacing[index]
        }
    }

    private func maxSize(accross subviews: Subviews) -> CGSize {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        return sizes.reduce(.zero) { largest, next in
                .init(width: max(largest.width, next.width), height: max(largest.height, next.height))
        }
    }

    private func spacing(for subviews: Subviews) -> [Double] {
        subviews.indices.map {
            guard $0 < subviews.count - 1 else { return 0 }
            return subviews[$0].spacing.distance(to: subviews[$0 + 1].spacing, along: .horizontal)
        }
    }
}

struct SwiftUIView43: View {
    var body: some View {
        EqualWidthHStack {
            Text("Hello, World!")
                .background(.blue)
            Text("Hello")
                .background(.green)
            Text("shadjksa")
                .background(.green)
        }
    }
}

struct SwiftUIView43_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView43()
    }
}
