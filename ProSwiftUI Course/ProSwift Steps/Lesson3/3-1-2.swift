//
//  3-1.swift
//  ProSwift Steps
//
//  Created by Augusto C.P. on 19/1/23.
//

import SwiftUI

struct StokeWidthKey: EnvironmentKey {
    static var defaultValue = 1.0
}

struct CiclesView: View {
//    @Environment(\.stokeWidth) var stokeWidth
    @Environment(\.theme.strokeWidth) var strokeWidth

    var body: some View {
        VStack {
            ForEach(0..<2) { _ in
                Circle()
                    .stroke(.red, lineWidth: strokeWidth)
             }
        }
    }
}

struct TitleFontKey: EnvironmentKey {
    static var defaultValue = Font.custom("Georgia", size: 34)
}

class ThemeManager: ObservableObject {
    @Published var activeTheme: any Theme = DefaultTheme()

    static var shared = ThemeManager()
    private init() {}
}

protocol Theme {
    var strokeWidth: Double { get set }
    var titleFont: Font { get set }
}

struct DefaultTheme: Theme {
    var strokeWidth = 1.0
    var titleFont = TitleFontKey.defaultValue
}

struct ThemeKey: EnvironmentKey {
    static var defaultValue: any Theme = ThemeManager.shared.activeTheme
}

struct ThemeModifier: ViewModifier {

    @ObservedObject var themeManager: ThemeManager = .shared

    func body(content: Content) -> some View {
        content.environment(\.theme, themeManager.activeTheme)
    }
}

struct SwiftUIView312: View {

//    @State private var sliderValue = 1.0
//    @State private var titleFont = Font.largeTitle

    @ObservedObject var theme: ThemeManager = .shared

    var body: some View {
        circles
    }

    var circles: some View {

        VStack {
            CiclesView()
            Text("Hello, world")
                .font(theme.activeTheme.titleFont)

            Slider(value: $theme.activeTheme.strokeWidth, in: 1...10)

            Button("Default Font") {
                theme.activeTheme.titleFont = .largeTitle
            }
            Button("Custom Font") {
                theme.activeTheme.titleFont = TitleFontKey.defaultValue
            }
        }
//        .stokeWidth(sliderValue)
//        .titleFont(titleFont)
        .environmentObject(theme)
    }
}

struct SwiftUIView312_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView312()
    }
}

private extension View {
    func stokeWidth(_ width: Double = 1.0) -> some View {
        environment(\.stokeWidth, width)
    }

    func titleFont(_ font: Font) -> some View {
        environment(\.titleFont, font)
    }

    func themed() -> some View {
        modifier(ThemeModifier())
    }
}

private extension EnvironmentValues {

    var stokeWidth: Double {
        get { self[StokeWidthKey.self] }
        set { self[StokeWidthKey.self] = newValue }
    }

    var titleFont: Font {
        get { self[TitleFontKey.self] }
        set { self[TitleFontKey.self] = newValue }
    }

    var theme: any Theme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}
