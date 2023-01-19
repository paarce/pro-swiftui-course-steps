//
//  2-2.swift
//  ProSwift Steps
//
//  Created by Augusto Cordero Perez on 17/1/23.
//

import SwiftUI

struct SwiftUIView22: View {
    @State private var isRed = false

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .animatableForegroundColor(isRed ? .red : .blue)
            .font(.largeTitle.bold())
            .onTapGesture {
                withAnimation {
                    isRed.toggle()
                }
            }
    }
}

struct SwiftUIView22_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView22()
    }
}

extension View {
    func animatableForegroundColor(_ color: Color) -> some View {
        self
            .foregroundColor(.white)
            .colorMultiply(color)
    }
}
