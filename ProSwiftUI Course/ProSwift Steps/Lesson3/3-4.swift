//
//  3-4.swift
//  ProSwift Steps
//
//  Created by Augusto C.P. on 23/1/23.
//

import SwiftUI

struct WidthPreferenceKey: PreferenceKey {
    static var defaultValue = 0.0

    static func reduce(value: inout Double, nextValue: () -> Double) {
        value += nextValue()
    }
}

struct SizingView: View {

    @State private var width = 50.0

    var body: some View {
        Color.red
            .frame(width: width, height: 100)
            .onTapGesture {
                width = Double.random(in: 50...160)
            }
            .preference(key: WidthPreferenceKey.self, value: width)
    }
}

struct SwiftUIView34: View {

    @State private var width = 50.0

    var body: some View {
        NavigationStack {
            VStack {
                SizingView()
                SizingView()
                SizingView()

//                Text("100%")
//                    .frame(width: width)
//                    .background(Color.red)
//                Text("150%")
//                    .frame(width: width * 1.5)
//                    .background(Color.green)
//                Text("200%")
//                    .frame(width: width * 2)
//                    .background(Color.blue)
            }
            .onPreferenceChange(WidthPreferenceKey.self) {
                width = $0
            }
            .navigationTitle("Width \(width)")
        }
    }
}

struct SwiftUIView34_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView34()
    }
}
