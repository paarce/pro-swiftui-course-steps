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

struct SwiftUIView311: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var makeRequired = false

    var body: some View {
        form
    }

    var form: some View {
        Form {
            RequirableTextField(title: "First name", text: $firstName)
            RequirableTextField(title: "Last name", text: $lastName)
            Toggle("MakeRequired", isOn: $makeRequired.animation())
        }
        .required(makeRequired)
    }

}

struct SwiftUIView311_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView311()
    }
}

private extension View {
    func required(_ makeRequired: Bool = true) -> some View {
        environment(\.required, makeRequired)
    }
}


private extension EnvironmentValues {
    var required: Bool {
        get { self[FromElementIsRequuired.self] }
        set { self[FromElementIsRequuired.self] = newValue }
    }
}
