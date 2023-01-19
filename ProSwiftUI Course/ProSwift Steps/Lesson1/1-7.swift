//
//  1-7.swift
//  ProSwift Steps
//
//  Created by Augusto Cordero Perez on 11/1/23.
//

import SwiftUI

struct SwiftUIView17: View {

    @State private var items = Array(1...20)

    var body: some View {

        VStack(spacing: 0) {
            List(items, id: \.self) {
                Text("Item \($0)")
            }

            Button("Suffle") {
                withAnimation {
                    items.shuffle()
                }
            }
        }

    }
}

struct SwiftUIView17_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView17()
    }
}
