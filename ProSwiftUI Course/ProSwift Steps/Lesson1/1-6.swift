//
//  SwiftUIView.swift
//  ProSwift Steps
//
//  Created by Augusto Cordero Perez on 11/1/23.
//

import SwiftUI

enum ViewState {
    case a, b, c, d, e
}

struct ExampleView: View {
    @State private var counter = 0
    let scale: Double

    var body: some View {
        Button("Tap count: \(counter)") {
            counter += 1
        }
        .scaleEffect(scale)
    }
}

struct SwiftUIView16: View {

    @State private var loadState = ViewState.a

    @ViewBuilder var state: some View {
        switch loadState {
        case .a:
            Text("Portafolio")
        case .b:
            Image(systemName: "plus")
        case .c:
            Circle()
        case .d:
            Rectangle()
        case .e:
            RoundedRectangle(cornerRadius: 25.0)
        }
    }

    @State private var scaleUp = false

    var exampleView: some View {

        if scaleUp {
            return ExampleView(scale: 2)
        } else {
            return ExampleView(scale: 1)
        }
    }

    var body: some View {
        VStack {
            exampleView
            Toggle("Scale up", isOn: $scaleUp.animation())
        }
        .padding()
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView16()
    }
}
