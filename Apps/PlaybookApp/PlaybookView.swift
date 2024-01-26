//
//  PlaybookView.swift
//  Dynamic Styling POC
//

@_exported import Inject
import PlaybookFeature
import SwiftUI

struct PlaybookView: View {
    @ObserveInjection private var iO
    @State private var email: String = ""

    var body: some View {
        PlaybookCatalog(name: "WHG WL", playbook: makePlaybook())
            .id(UUID())
            .enableInjection()
    }
}

extension PlaybookView {
    func makePlaybook() -> Playbook {
        let design = AppDesignSystem(colors: .default, fonts: .default)
        let appStyle = AppStyle(initialDesignSystem: design, intialComponents: .default)
        let playbook = Playbook()
        addTextScenarios(playbook, appStyle)
        addButtonScenarios(playbook, appStyle)
        addTextFieldScenarios(playbook, appStyle)
        return playbook
    }

    func addTextScenarios(_ playbook: Playbook, _ appStyle: AppStyle) {
        playbook.addScenarios(of: "Texts") {
            Scenario("Title", layout: .fill) { _ in
                Text("This is title")
                    .appTextStyleFor(.title, appStyle: appStyle)
            }
            Scenario("Subtitle", layout: .fill) { _ in
                Text("This is subtitle")
                    .appTextStyleFor(.subtitle, appStyle: appStyle)
            }
            Scenario("Text", layout: .fill) { _ in
                Text("This is text")
                    .appTextStyleFor(.text, appStyle: appStyle)
            }
        }
    }

    func addButtonScenarios(_ playbook: Playbook, _ appStyle: AppStyle) {
        playbook.addScenarios(of: "Buttons") {
            Scenario("Primary Button", layout: .fill) { _ in
                VStack {
                    Spacer()
                    Button("Click me") {}
                        .appButtonStyleFor(.primary, appStyle: appStyle)
                    Spacer()
                    Button("Disabled") {}
                        .appButtonStyleFor(.primary, appStyle: appStyle)
                        .disabled(true)
                    Spacer()
                }
            }
            Scenario("Secondary Button", layout: .fill) { _ in
                VStack {
                    Spacer()
                    Button("Click me") {}
                        .appButtonStyleFor(.secondary, appStyle: appStyle)
                    Spacer()
                    Button("Disabled") {}
                        .appButtonStyleFor(.secondary, appStyle: appStyle)
                        .disabled(true)
                    Spacer()
                }
            }
        }
    }

    func addTextFieldScenarios(_ playbook: Playbook, _ appStyle: AppStyle) {
        playbook.addScenarios(of: "Text Fields") {
            Scenario("Email Text Field", layout: .fill) { _ in
                VStack {
                    Spacer()
                    TextField("Email", text: $email)
                        .appTextFieldStyleFor(.email, appStyle: appStyle)
                        .padding(20)
                    Spacer()
                    TextField("Email - disabled", text: $email)
                        .appTextFieldStyleFor(.email, appStyle: appStyle)
                        .padding(20)
                    Spacer()
                }
            }
            Scenario("Password Text Field", layout: .fill) { _ in
                VStack {
                    Spacer()
                    TextField("Password", text: $email)
                        .appTextFieldStyleFor(.password, appStyle: appStyle)
                        .padding(20)
                    Spacer()
                    TextField("Password - disabled", text: $email)
                        .appTextFieldStyleFor(.password, appStyle: appStyle)
                        .padding(20)
                    Spacer()
                }
            }
        }
    }
}
