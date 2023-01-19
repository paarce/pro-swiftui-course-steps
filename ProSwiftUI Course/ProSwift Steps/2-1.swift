//
//  1-8.swift
//  ProSwift Steps
//
//  Created by Augusto Cordero Perez on 17/1/23.
//

import SwiftUI

struct AnimableZindexModifier: ViewModifier, Animatable {
    var animatableData: Double

    func body(content: Content) -> some View {
        content
            .zIndex(animatableData)
    }
}

struct AnimableFontModifier: ViewModifier, Animatable {
    var animatableData: Double

    func body(content: Content) -> some View {
        content
            .font(.system(size: animatableData))
    }
}

struct SwiftUIView21: View {

    @State private var redAtFront = false
    @State private var scaleUp = false
    private let colors: [Color] = [.blue, .green, .orange, .mint, .purple]

    var body: some View {
        rectaglesWithAnimation
//        helloWithAnimation
    }

    @ViewBuilder var helloWithAnimation: some View {

        Text("Hello world")
//            .font(.system(size: scaleUp ? 56 : 24)) // > iOS16
            .animatableFont(scaleUp ? 56 : 24)
            .onTapGesture {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.1)) {
                    scaleUp.toggle()
                }
            }
    }

    @ViewBuilder var rectaglesWithAnimation: some View {
        VStack {
            Button("Toggle zIndex") {
                withAnimation(.linear(duration: 1)) {
                    redAtFront.toggle()
                }
            }

            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.red)
                    .animatableZIndex(redAtFront ? 6 : 0)

                ForEach(0..<5) { i in

                        RoundedRectangle(cornerRadius: 25)
                            .fill(colors[i])
                            .offset(x: Double(i+1) * 20, y: Double(i+1) * 20)
                            .zIndex(Double(i))
                }
            }
            .frame(width: 200, height: 200)
        }
    }
}

struct SwiftUIView21_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView21()
    }
}

private extension View {

    func animatableZIndex(_ index: Double) -> some View {
        self.modifier(AnimableZindexModifier(animatableData: index))
    }

    func animatableFont(_ size: Double) -> some View {
        self.modifier(AnimableFontModifier(animatableData: size))
    }
}
