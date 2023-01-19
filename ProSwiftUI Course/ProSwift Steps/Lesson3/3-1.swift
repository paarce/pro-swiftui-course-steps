//
//  3-1.swift
//  ProSwift Steps
//
//  Created by Augusto C.P. on 19/1/23.
//

import SwiftUI


struct FromElementIsRequuired: EnvironmentKey {
    static var defaultValue = true
}
struct RequirableTextField: View {
    @Environment(\.required) var required

    let title: String
    @Binding var text: String

    var body: some View {
        HStack {
            TextField(title, text: $text)

            if required {
                Image(systemName: "asterisk")
                    .imageScale(.small)
                    .foregroundColor(.red)
            }
        }
    }
}

struct StokeWidthKey: EnvironmentKey {
    static var defaultValue = 1.0
}

struct CiclesView: View {
    @Environment(\.stokeWidth) var stokeWidth

    var body: some View {
        VStack {
            Circle()
                .stroke(.red, lineWidth: stokeWidth)
            Circle()
                .stroke(.red, lineWidth: stokeWidth)
        }
    }
}

struct SwiftUIView31: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var makeRequired = false

    @State private var sliderValue = 1.0

    var body: some View {
//        form
        circles
    }

    var form: some View {
        Form {
            RequirableTextField(title: "First name", text: $firstName)
            RequirableTextField(title: "Last name", text: $lastName)
            Toggle("MakeRequired", isOn: $makeRequired.animation())
        }
        .required(makeRequired)
    }


    var circles: some View {

        VStack {
            CiclesView()
            Slider(value: $sliderValue, in: 1...10)
        }
        .stokeWidth(sliderValue)
    }
}

struct SwiftUIView31_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView31()
    }
}

private extension View {
    func required(_ makeRequired: Bool = true) -> some View {
        environment(\.required, makeRequired)
    }

    func stokeWidth(_ width: Double = 1.0) -> some View {
        environment(\.stokeWidth, width)
    }
}


private extension EnvironmentValues {
    var required: Bool {
        get { self[FromElementIsRequuired.self] }
        set { self[FromElementIsRequuired.self] = newValue }
    }

    var stokeWidth: Double {
        get { self[StokeWidthKey.self] }
        set { self[StokeWidthKey.self] = newValue }
    }
}
