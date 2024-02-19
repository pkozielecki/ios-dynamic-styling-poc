//
//  PlaybookViewModel.swift
//  Dynamic Styling POC
//

import Foundation
import Observation
import PlaybookFeature
import SwiftUI

@Observable
final class PlaybookViewModel {
    private(set) var appStyle = AppStyle.default
    private(set) var settingsViewModel: AutomaticSettingsViewModel<BetaSettings, BetaSettingsExternalData>?
    var selectedTab: Int = 0

    init() {
        settingsViewModel = AutomaticSettingsViewModel(
            settings: BetaSettings(),
            externalData: BetaSettingsExternalData(),
            save: {
                self.updateAppStyle(with: $0)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.selectedTab = 0
                }
            },
            dismiss: {}
        )
    }
}

private extension PlaybookViewModel {
    func updateAppStyle(with betaSettings: BetaSettings) {
        let designSystem = AppDesignSystem(
            colors: .init(
                betaColors: betaSettings.colors
            ),
            fonts: .init(
                title: betaSettings.titleFont.appFont,
                subtitle: betaSettings.subtitleFont.appFont,
                text: betaSettings.textFont.appFont
            )
        )
        appStyle = AppStyle(initialDesignSystem: designSystem, intialComponents: .default)
    }
}

extension AppColors {
    init(betaColors: BetaSettings.Colors) {
        self.init(
            error500: AppColor(lightModeValue: betaColors.error500, darkModeValue: betaColors.error500),
            informative500: AppColor(lightModeValue: betaColors.informative500, darkModeValue: betaColors.informative500),
            neutral500: AppColor(lightModeValue: betaColors.neutral500, darkModeValue: betaColors.neutral500),
            primary100: AppColor(lightModeValue: betaColors.primary100, darkModeValue: betaColors.primary100),
            primary500: AppColor(lightModeValue: betaColors.primary500, darkModeValue: betaColors.primary500),
            primary900: AppColor(lightModeValue: betaColors.primary900, darkModeValue: betaColors.primary900),
            secondary100: AppColor(lightModeValue: betaColors.secondary100, darkModeValue: betaColors.secondary100),
            secondary500: AppColor(lightModeValue: betaColors.secondary500, darkModeValue: betaColors.secondary500),
            secondary900: AppColor(lightModeValue: betaColors.secondary900, darkModeValue: betaColors.secondary900),
            success500: AppColor(lightModeValue: betaColors.success500, darkModeValue: betaColors.success500),
            tertiary100: AppColor(lightModeValue: betaColors.tertiary100, darkModeValue: betaColors.tertiary100),
            text500: AppColor(lightModeValue: betaColors.text500, darkModeValue: betaColors.text500),
            warning500: AppColor(lightModeValue: betaColors.warning500, darkModeValue: betaColors.warning500),
            clear: AppColor(lightModeValue: betaColors.clear, darkModeValue: betaColors.clear)
        )
    }
}

private extension AppStyle {
    static var `default`: AppStyle {
        let design = AppDesignSystem(colors: .default, fonts: .default)
        return AppStyle(initialDesignSystem: design, intialComponents: .default)
    }
}
