//
//  PlaybookApp.swift
//  Dynamic Styling POC
//

import SwiftUI

@main
struct PlaybookAppApp: App {
    let viewModel = PlaybookViewModel()
    var body: some Scene {
        WindowGroup {
            PlaybookView(viewModel: viewModel)
        }
    }
}
