//
//  2-4.swift
//  ProSwift Steps
//
//  Created by Augusto Cordero Perez on 17/1/23.
//

import SwiftUI

extension Animation {

    static var edgeBounce: Animation {
        Animation.timingCurve(0, 1, 1, 0)
    }

    static func edgeBounce(duration: TimeInterval = 0.2) -> Animation {
        Animation.timingCurve(0, 1, 1, 0, duration: duration)
    }

    static func easeInOutBack(duration: TimeInterval = 0.2) -> Animation {
        Animation.timingCurve(0, 1, 1, 0, duration: duration)
    }

    static var easeInOutBack: Animation {
        Animation.timingCurve(0.7, -0.5, 0.3, 1.5)
    }
}

struct SwiftUIView24: View {

    @State private var offset = -200.0

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .offset(y: offset)
            .animation(.easeInOutBack(duration: 2).repeatForever(), value: offset)
            .onTapGesture {
                offset = 200
            }

    }
}

struct SwiftUIView24_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView24()
    }
}
