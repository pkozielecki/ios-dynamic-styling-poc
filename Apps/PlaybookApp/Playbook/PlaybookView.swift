//
//  PlaybookView.swift
//  Dynamic Styling POC
//

import AutomaticSettings
import PlaybookFeature
import SwiftUI

struct PlaybookView: View {
    let viewModel: PlaybookViewModel
    @State private var selectedTab: Int = 0

    init(viewModel: PlaybookViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        PlaybookCatalog(name: "", playbook: PlaybookView.makePlaybook(appStyle: viewModel.appStyle))
    }
}

extension PlaybookView {
    static func makePlaybook(appStyle: AppStyle) -> Playbook {
        let playbook = Playbook()
        addTextScenarios(playbook, appStyle)
        addButtonScenarios(playbook, appStyle)
        addTextFieldScenarios(playbook, appStyle)
        return playbook
    }

    static func addTextScenarios(_ playbook: Playbook, _ appStyle: AppStyle) {
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

    static func addButtonScenarios(_ playbook: Playbook, _ appStyle: AppStyle) {
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

    static func addTextFieldScenarios(_ playbook: Playbook, _ appStyle: AppStyle) {
        playbook.addScenarios(of: "Text Fields") {
            Scenario("Email Text Field", layout: .fill) { _ in
                VStack {
                    Spacer()
                    TextField("Email", text: .constant("my@email.com"))
                        .appTextFieldStyleFor(.email, appStyle: appStyle)
                        .padding(20)
                    Spacer()
                    TextField("Email - disabled", text: .constant(""))
                        .appTextFieldStyleFor(.email, appStyle: appStyle)
                        .padding(20)
                    Spacer()
                }
            }
            Scenario("Password Text Field", layout: .fill) { _ in
                VStack {
                    Spacer()
                    TextField("Password", text: .constant("my@email.com"))
                        .appTextFieldStyleFor(.password, appStyle: appStyle)
                        .padding(20)
                    Spacer()
                    TextField("Password - disabled", text: .constant(""))
                        .appTextFieldStyleFor(.password, appStyle: appStyle)
                        .padding(20)
                    Spacer()
                }
            }
        }
    }
}
