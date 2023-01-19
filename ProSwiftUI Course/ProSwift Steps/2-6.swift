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
            active: ConffetiModifier(color: .blue, size: 3),
            identity:  ConffetiModifier(color: .blue, size: 3)
        )
    }

    static func confetti(color: Color = .blue, size: Double = 3.0) -> AnyTransition {
        .modifier(
            active: ConffetiModifier(color: color, size: size),
            identity:  ConffetiModifier(color: color, size: size)
        )
    }
}

struct ConffetiModifier: ViewModifier {
    private let speed = 0.3

    var color: Color
    var size: Double

    @State private var circleSize = 0.00001
    @State private var strockMultiplier = 1.0

    @State private var confettiIsHidden = true
    @State private var conffetiMovement = 0.7
    @State private var conffetiScale = 1.0

    func body(content: Content) -> some View {
        content
            .hidden()
            .padding(10)
            .overlay(
                ZStack {
                    GeometryReader { proxy in
                        Circle()
                            .strokeBorder(color, lineWidth: proxy.size.width / 2 * strockMultiplier)
                            .scaleEffect(circleSize)
                    }
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
            }
    }
}


struct SwiftUIView26: View {

    @State private var isFavorite = false
    private var mainColor: Color = .red


    init(isFavorite: Bool = false, mainColor: Color = .red) {
        self.isFavorite = isFavorite
        self.mainColor = mainColor
        let foo = zip([1,2,3,4,5,6,7,8], ["a", "b", "c"])
        let wizards1 = ["Harry", "Ron", "Hermione"]
        let animals1 = ["Hedwig", "Scabbers", "Crookshanks"]
        let combined1 = zip(wizards1, animals1)

        print(Array(foo))
    }

    var body: some View {
        VStack(spacing: 60) {
            ForEach([Font.body, Font.largeTitle], id: \.self) { font in
                Button {
                    isFavorite.toggle()
                } label: {
                    if isFavorite {
                        Image(systemName: "heart.fill")
                            .foregroundColor(mainColor)
                            .transition(.confetti(color: mainColor))
                    } else {
                        Image(systemName: "heart")
                            .foregroundColor(mainColor)
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
