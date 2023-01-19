//
//  2-6.swift
//  ProSwift Steps
//
//  Created by Augusto Cordero Perez on 18/1/23.
//

import SwiftUI

extension AnyTransition {

    static var conffeti: AnyTransition {
        .modifier(
            active: ConffetiModifier(shape: .blue, size: 3),
            identity:  ConffetiModifier(shape: .blue, size: 3)
        )
    }

    static func confetti<T: ShapeStyle>(shape: T = .blue, size: Double = 3.0) -> AnyTransition {
        .modifier(
            active: ConffetiModifier(shape: shape, size: size),
            identity:  ConffetiModifier(shape: shape, size: size)
        )
    }
}

struct ConffetiModifier<T: ShapeStyle>: ViewModifier {
    private let speed = 0.3

    var shape: T
    var size: Double

    @State private var circleSize = 0.00001
    @State private var strockMultiplier = 1.0

    @State private var confettiIsHidden = true
    @State private var conffetiMovement = 0.7
    @State private var conffetiScale = 1.0

    @State private var contentScale = 0.00001

    func body(content: Content) -> some View {
        content
            .hidden()
            .padding(10)
            .overlay(
                ZStack {
                    GeometryReader { proxy in
                        Circle()
                            .strokeBorder(shape, lineWidth: proxy.size.width / 2 * strockMultiplier)
                            .scaleEffect(circleSize)

                        ForEach(0..<15) { i in
                            Circle()
                                .fill(shape)
                                .frame(width: size + sin(Double(i)), height: size + sin(Double(i)))
//                                .frame(width: size + Double(i), height: size + Double(i))
                                .scaleEffect(conffetiScale)
                                .offset(x: proxy.size.width / 2 * conffetiMovement)
//                                .offset(x: proxy.size.width / 2 * conffetiMovement + (i.isMultiple(of: 2) ? size : 0))
                                .rotationEffect(.degrees(24 * Double(i)))
                                .offset(x: (proxy.size.width - size) / 2, y: (proxy.size.height - size) / 2)
                                .opacity(confettiIsHidden ? 0 : 1)
                        }
                    }

                    content
                        .scaleEffect(contentScale)
                }
            )
            .padding(-10)
            .onAppear {
                withAnimation(.easeIn(duration: speed)) {
                    circleSize = 1
                }

                withAnimation(.easeIn(duration: speed).delay(speed)) {
                    strockMultiplier = 0.00001
                }
                withAnimation(.interpolatingSpring(stiffness: 50, damping: 5).delay(speed)) {
                    contentScale = 1
                }

                withAnimation(.easeOut(duration: speed).delay(speed * 1.25)) {
                    confettiIsHidden = false
                    conffetiMovement  = 1.2
                }

                withAnimation(.easeOut(duration: speed).delay(speed * 2)) {
                    conffetiScale = 0.00001
                }
            }
    }
}


struct SwiftUIView26: View {

    @State private var isFavorite = false
    private var mainColor: Color = .red

    var body: some View {
        VStack(spacing: 60) {
            ForEach([Font.largeTitle, Font.system(size: 72)], id: \.self) { font in
                Button {
                    isFavorite.toggle()
                } label: {
                    if isFavorite {
                        Image(systemName: "heart.fill")
                            .foregroundColor(mainColor)
                            .transition(.confetti(shape: .angularGradient(colors: [.red, .yellow, .green, .blue, .purple], center: .center, startAngle: .zero, endAngle: .degrees(360))))
                    } else {
                        Image(systemName: "heart")
                            .foregroundColor(mainColor)
                        //TODO: How can I rollbak that transition
                    }
                }
                .font(font)
            }
        }
    }
}

struct SwiftUIView26_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView26()
    }
}
