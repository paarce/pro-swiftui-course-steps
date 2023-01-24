//
//  3-5.swift
//  ProSwift Steps
//
//  Created by Augusto Cordero Perez on 24/1/23.
//

import SwiftUI

struct Category: Identifiable, Equatable {
    let id: String
    let symbol: String
}

struct CategoryPreference: Equatable {
    let category: Category
    let anchor: Anchor<CGRect>
}

struct CategoryPreferenceKey: PreferenceKey {
    static var defaultValue = [CategoryPreference]()

    static func reduce(value: inout [CategoryPreference], nextValue: () -> [CategoryPreference]) {
        value.append(contentsOf: nextValue())
    }
}

struct CategoryButton: View {
    var category: Category
    @Binding var selection: Category?

    var body: some View {
        Button {
            withAnimation {
                selection = category
            }
        } label: {
            VStack {
                Image(systemName: category.symbol)
                Text(category.id)
            }
        }
        .buttonStyle(.plain)
//        .accessibilityElement()
//        .accessibilityLabel(category.id)
        .anchorPreference(key: CategoryPreferenceKey.self, value: .bounds) {
            [CategoryPreference(category: category, anchor: $0)]
        }
    }
}

struct SwiftUIView35: View {

    @State var selection: Category?

    let categories = [
        Category(id: "Arctic", symbol: "snowflake"),
        Category(id: "Beach", symbol: "beach.umbrella"),
        Category(id: "Shared Homes", symbol: "house"),
    ]

    var body: some View {
        VStack {
            HStack {
                ForEach(categories) { category in
                    CategoryButton(category: category, selection: $selection)
                }
            }

            List(categories) { category in
                HStack {
                    Button(category.id) {
                        withAnimation {
                            selection = category
                        }
                    }

                    if selection == category {
                        Spacer()
                        Image(systemName: "checkmark")
                    }
                }
            }

            if let selection {
                Text("Selected: \(selection.id)")
            }

        }
        .overlayPreferenceValue(CategoryPreferenceKey.self) { preferences in
            GeometryReader { proxy in
                if let selected = preferences.first(where: { $0.category == selection }) {
                    let frame = proxy[selected.anchor]

                    Rectangle()
                        .fill(.black)
                        .frame(width: frame.width, height: 2)
                        .position(x: frame.midX, y: frame.maxY)
                }
            }
        }
    }
}

struct SwiftUIView35_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView35()
    }
}
