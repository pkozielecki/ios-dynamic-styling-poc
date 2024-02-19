//
//  PlaybookApp.swift
//  Dynamic Styling POC
//

import SwiftUI

@main
struct PlaybookApp: App {
    let viewModel = PlaybookViewModel()

    var body: some Scene {
        WindowGroup {
            TabView(selection: Binding<Int>.init(get: { viewModel.selectedTab }, set: { viewModel.selectedTab = $0 })) {
                PlaybookView(viewModel: viewModel)
                    .tag(0)
                    .tabItem {
                        Label(
                            title: { Text("Playbook") },
                            icon: { Image(systemName: "house.fill") }
                        )
                    }

                NavigationStack {
                    BetaSettingsView(viewModel: viewModel.settingsViewModel!)
                        .navigationTitle("Settings")
                }
                .tag(1)
                .tabItem {
                    Label(
                        title: { Text("Settings") },
                        icon: { Image(systemName: "gear") }
                    )
                }
            }
        }
    }
}
