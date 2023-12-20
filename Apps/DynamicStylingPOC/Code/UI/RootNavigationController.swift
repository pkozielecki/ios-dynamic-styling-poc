//
//  RootNavigationController.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import UIKit

final class RootNavigationController: UINavigationController {
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            // TODO: Temporary solution - to trigger style update.
            let styleProvider: AppStyleProvider = LiveDependencyManager.shared.resolve()
            styleProvider.refreshStyles()
        }
    }
}
