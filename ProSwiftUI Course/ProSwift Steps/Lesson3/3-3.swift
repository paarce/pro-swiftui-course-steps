//
//  3-3.swift
//  ProSwift Steps
//
//  Created by Augusto C.P. on 23/1/23.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Image(systemName: "sun.max")
                .transformEnvironment(\.font) { font in
                    font = font?.weight(.bold)
                }
            Text("Welcome!")
        }
    }
}

struct SwiftUIView33: View {
    var body: some View {
        WelcomeView()
            .font(.largeTitle)
    }
}

struct SwiftUIView33_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView33()
    }
}
