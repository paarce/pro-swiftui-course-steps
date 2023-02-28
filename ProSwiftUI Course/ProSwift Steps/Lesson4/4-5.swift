//
//  SwiftUIView45.swift
//  ProSwift Steps
//
//  Created by Augusto Cordero Perez on 27/2/23.
//

import SwiftUI

struct MansonryLayout: Layout {

    var columns: Int
    var spacing: Double

    init(columns: Int = 3, spacing: Double = 5) {
        self.columns = columns
        self.spacing = spacing
    }

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let width = proposal.replacingUnspecifiedDimensions().width
        let viewFrames = frame(for: subviews, in: width)
        let bottomView = viewFrames.max { $0.maxY < $1.maxY } ?? .zero
        return .init(width: width, height: bottomView.maxY)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let viewFrames = frame(for: subviews, in: bounds.width)

        for index in subviews.indices {
            let frame = viewFrames[index]
            let position = CGPoint(x: bounds.minX + frame.minX, y: bounds.minY + frame.minY)
            subviews[index].place(at: position, proposal: ProposedViewSize(frame.size))
        }
    }

    func frame(for subviews: Subviews, in totalWidth: Double) -> [CGRect] {
        let totalSpacing = spacing * Double(columns - 1)
        let columnWidth = (totalWidth - totalSpacing) / Double(columns)

        let columnWidthWithSpacing = columnWidth + spacing
        let proposedSize = ProposedViewSize(width: columnWidth, height: nil)

        var viewFrames = [CGRect]()
        var columnHeights = Array(repeating: 0.0, count: columns)

        for subview in subviews {

            var selectedColumn = 0
            var selectedHeight = Double.greatestFiniteMagnitude

            for (columnIndex, height) in columnHeights.enumerated() {

                if height < selectedHeight {
                    selectedColumn = columnIndex
                    selectedHeight = height
                }
            }

            let x = Double(selectedColumn) * columnWidthWithSpacing
            let y = columnHeights[selectedColumn]
            let size = subview.sizeThatFits(proposedSize)
            let frame = CGRect(x: x, y: y, width: size.width, height: size.height)

            columnHeights[selectedColumn] += size.height + spacing
            viewFrames.append(frame)

        }
        return viewFrames
    }

}

struct SwiftUIView45: View {

    @State private var columns = 3
    @State private var sizes = (0..<20).map { _ in
        CGSize(width: .random(in: 100...500), height: .random(in: 100...500))
    }

    var body: some View {
        ScrollView {
            MansonryLayout(columns: columns ) {
                ForEach(0..<20) { i in
                    PlaceHolderView(size: sizes[i])
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            Stepper("Columns: \(columns)", value: $columns.animation(), in: 1...6)
                .padding()
                .background(.regularMaterial)
        }
    }
}

struct PlaceHolderView: View {

    let color: Color = [.blue, .red, .cyan, .green, .indigo, .purple, .pink].randomElement()!
    let size: CGSize

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(color)

            Text("\(Int(size.width))x\(Int(size.height))")
                .foregroundColor(.white)
                .font(.headline)
                .minimumScaleFactor(0.5)
        }
        .aspectRatio(size, contentMode: .fill)
    }

}

struct SwiftUIView45_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView45()
    }
}
