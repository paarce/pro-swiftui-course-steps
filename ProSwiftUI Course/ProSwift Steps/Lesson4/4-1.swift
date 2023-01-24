//
//  4-1-1.swift
//  ProSwift Steps
//
//  Created by Augusto Cordero Perez on 24/1/23.
//

import SwiftUI

struct ExampleBoxView: View {

    @State private var counter = 0
    let color: Color

    var body: some View {
        Button {
            counter += 1
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
                .overlay {
                    Text(String(counter))
                        .foregroundColor(.white)
                        .font(.largeTitle)
                }
        }
        .frame(width: 100, height: 100)
        .rotationEffect(.degrees(.random(in: -20...20)))
    }
}

struct SwiftUIView41: View {

    private let layouts = [AnyLayout(VStackLayout()), AnyLayout(HStackLayout()), AnyLayout(ZStackLayout()), AnyLayout(GridLayout())]

    @State private var currentLayout = 0

    var layout: AnyLayout {
        layouts[currentLayout]
    }

    var body: some View {
        VStack {
            Spacer()
            layout {
                GridRow {
                    ExampleBoxView(color: .red)
                    ExampleBoxView(color: .blue)
                }
                GridRow {
                    ExampleBoxView(color: .green)
                    ExampleBoxView(color: .black)
                }
            }
            Spacer()

            Button("Change layout") {
                currentLayout += 1
                if currentLayout == layouts.count {
                    currentLayout = 0
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray)
    }
}

struct SwiftUIView41_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView41()
    }
}
