//
//  PopupDismissHandler.swift
//  Dynamic Styling POC
//

import UIKit

final class PopupDismissHandler: NSObject, UIAdaptivePresentationControllerDelegate {
    private let onDismiss: (() -> Void)?

    init(onDismiss: (() -> Void)?) {
        self.onDismiss = onDismiss
    }

    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        onDismiss?()
    }
}
