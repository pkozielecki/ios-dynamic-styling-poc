//
//  PlaybookView.swift
//  Dynamic Styling POC
//

import AutomaticSettings
@_exported import Inject
import PlaybookFeature
import SwiftUI

struct PlaybookView: View {
    @ObserveInjection private var iO
    let viewModel: PlaybookViewModel
    @State private var email: String = ""
    @State private var selectedTab: Int = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            VStack {
                PlaybookCatalog(name: "", playbook: makePlaybook())
            }
            .tabItem {
                Label(
                    title: { Text("Playbook") },
                    icon: { Image(systemName: "house.fill") }
                )
            }

            VStack {
                NavigationStack {
                    BetaSettingsView(viewModel: viewModel.settingsViewModel!)
                        .navigationTitle("Settings")
                }
            }
            .tabItem {
                Label(
                    title: { Text("Settings") },
                    icon: { Image(systemName: "gear") }
                )
            }
        }
        .id(UUID())
        .enableInjection()
    }
}

extension PlaybookView {
    func makePlaybook() -> Playbook {
        let playbook = Playbook()
        addTextScenarios(playbook, viewModel.appStyle)
        addButtonScenarios(playbook, viewModel.appStyle)
        addTextFieldScenarios(playbook, viewModel.appStyle)
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
