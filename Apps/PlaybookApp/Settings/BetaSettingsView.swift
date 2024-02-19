//
//  BetaSettingsView.swift
//  Dynamic Styling POC
//

import AutomaticSettings
import Common
import CommonUI
import Foundation
import SwiftUI

struct BetaSettingsView: View, AutomaticSettingsViewDSL {
    typealias ExternalData = BetaSettingsExternalData
    typealias Settings = BetaSettings

    @ObservedObject
    var viewModel: AutomaticSettingsViewModel<BetaSettings, BetaSettingsExternalData>

    var body: some View {
        VStack(spacing: 10) {
            Button("Save", action: viewModel.saveChanges)
                .buttonStyle(.borderedProminent)
            Form {
                Section(header: Text("Colors")) {
                    colorsLink()
                }
                Section(header: Text("Text styles")) {
                    titleFontLink()
                    subtitleFontLink()
                    textFontLink()
                }
            }
        }
        .padding()
    }
}
