//
//  2-5.swift
//  ProSwift Steps
//
//  Created by Augusto Cordero Perez on 18/1/23.
//

import SwiftUI

func withMotionAnimation<Result>(_ animation: Animation? = .default, body: () throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}

func withoutMotionAnimation<Result>(body: () throws -> Result) rethrows -> Result {
    var transaction = Transaction()
    transaction.disablesAnimations = true
    return try withTransaction(transaction, body)
}

func withHighPriorityMotionAnimation<Result>(_ animation: Animation? = .default, body: () throws -> Result) rethrows -> Result {
    var transaction = Transaction(animation: animation)
    transaction.disablesAnimations = true
    return try withTransaction(transaction, body)
}

struct MotionAnimationModifier<V: Equatable>: ViewModifier {

    @Environment(\.accessibilityReduceMotion) var accessibilityReduceMotion
    let animation: Animation?
    let value: V

    func body(content: Content) -> some View {
        if accessibilityReduceMotion {
            content
        } else {
            content.animation(animation, value: value)
        }
    }
}

private extension View {

    func motionAnimation<V: Equatable>(_ animation: Animation?, value:V) -> some View {
        self.modifier(MotionAnimationModifier(animation: animation, value: value))
    }
}



struct CircleGrid: View {
    var useRedFill = false

    var body: some View {
        LazyVGrid(columns: [.init(.adaptive(minimum: 64))]) {
            ForEach(0..<30) { i in
                Circle()
                    .fill(useRedFill ? .red : .blue)
                    .frame(height: 64)
                    .transaction { trans in
                        trans.animation = trans.animation?.delay(Double(i) / 10)
                    }
            }
        }
    }
}

struct SwiftUIView25: View {

    @State private var scale = 1.0
    @State private var useRedFill = false

    var body: some View {
        VStack {
            CircleGrid(useRedFill: useRedFill)

            Spacer()

            Button("Toggle Color") {
                withAnimation(.easeInOut) {
                    useRedFill.toggle()
                }
            }
        }
    }

    var tapButton: some View {
        Button("Tap") {
            withoutMotionAnimation {
                scale += 1
            }
        }
        .scaleEffect(scale)
        .motionAnimation(.default, value: scale)
    }
}

struct SwiftUIView25_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView25()
    }
}
