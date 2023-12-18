//
//  LiveAlertPresenter.swift
//  Dynamic Styling POC
//

import UIKit

public final class LiveAlertPresenter: AlertPresenter {
    private(set) var alertController: UIAlertController?

    public init() {}

    public func showInfoAlert(
        on viewController: UIViewController,
        title: String,
        message: String?,
        buttonTitle: String,
        completion: (() -> Void)?
    ) {
        let okAction = UIAlertAction(title: buttonTitle, style: .default, handler: { _ in
            completion?()
        })
        showAlert(title: title, message: message, on: viewController, actions: [okAction])
    }

    // swiftlint:disable function_parameter_count
    public func showAcceptanceAlert(
        on viewController: UIViewController,
        title: String,
        message: String?,
        yesActionTitle: String,
        noActionTitle: String,
        yesActionStyle: UIAlertAction.Style,
        noActionStyle: UIAlertAction.Style,
        completion: ((AcceptanceAlertAction) -> Void)?
    ) {
        let yesAction = UIAlertAction(title: yesActionTitle, style: yesActionStyle, handler: { _ in
            completion?(.yes)
        })
        let noAction = UIAlertAction(title: noActionTitle, style: noActionStyle, handler: { _ in
            completion?(.no)
        })
        showAlert(title: title, message: message, on: viewController, actions: [yesAction, noAction])
    }
    // swiftlint:enable function_parameter_count
}

// MARK: - Private Methods

private extension LiveAlertPresenter {
    func showAlert(title: String, message: String?, on viewController: UIViewController, actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alertController.addAction($0) }
        viewController.present(alertController, animated: true, completion: nil)
        self.alertController = alertController
    }
}
