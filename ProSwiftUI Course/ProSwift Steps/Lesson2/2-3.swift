//
//  2-3.swift
//  ProSwift Steps
//
//  Created by Augusto Cordero Perez on 17/1/23.
//

import SwiftUI

struct CountingText: View, Animatable {
    var value: Double
    var fractionalLength = 1

    var animatableData: Double {
        get { value }
        set { value = newValue }
    }

    var body: some View {
        Text(value.formatted(.number.precision(.fractionLength(fractionalLength))))
    }
}

struct TypewirtterText: View, Animatable {

    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    @Environment(\.accessibilityReduceMotion) var accessibilityReduceMotion

    var value: Int
    var contentText: String

    var animatableData: Double {
        get { Double(value) }
        set { value = Int(newValue) }
    }

    var body: some View {
        if accessibilityVoiceOverEnabled || accessibilityReduceMotion {
            Text(contentText)
        } else {
            ZStack {
                Text(contentText)
                    .hidden()
                    .overlay (
                        Text(contentText.prefix(value)),
                        alignment: .topLeading
                    )
            }
        }
    }
}

struct SwiftUIView23: View {

    @State private var countingValue = 0.0
    @State private var typingLengthValue = 0
    var text: String = "Rastreadores a los que se les ha impedido obtener información sobre ti"

    var body: some View {
//        counting
        typing
    }

    var typing: some View {
        VStack {
            TypewirtterText(value: typingLengthValue, contentText: text)
                .frame(width: 300, alignment: .leading)

            Button("Type!") {
                withAnimation(.linear(duration: 5)) {
                    typingLengthValue = text.count
                }
            }
            Button("Reset") {
                typingLengthValue = 0
            }
        }
    }

    var counting: some View {
        CountingText(value: countingValue)
            .font(.largeTitle)
            .onTapGesture {
                withAnimation(.linear(duration: 1)) {
                    countingValue = 200
                }
            }
    }
}

struct SwiftUIView23_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView23()
    }
}
