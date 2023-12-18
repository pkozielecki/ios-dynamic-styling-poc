//
//  AlertPresenter.swift
//  Dynamic Styling POC
//

import UIKit

public enum AcceptanceAlertAction: Equatable {
    case yes, no
}

public protocol AlertPresenter: AnyObject {
    func showInfoAlert(
        on viewController: UIViewController,
        title: String,
        message: String?,
        buttonTitle: String,
        completion: (() -> Void)?
    )

    // swiftlint:disable function_parameter_count
    func showAcceptanceAlert(
        on viewController: UIViewController,
        title: String,
        message: String?,
        yesActionTitle: String,
        noActionTitle: String,
        yesActionStyle: UIAlertAction.Style,
        noActionStyle: UIAlertAction.Style,
        completion: ((AcceptanceAlertAction) -> Void)?
    )
    // swiftlint:enable function_parameter_count
}

public extension AlertPresenter {
    func showInfoAlert(
        on viewController: UIViewController,
        title: String,
        message: String?,
        completion: (() -> Void)?
    ) {
        showInfoAlert(
            on: viewController,
            title: title,
            message: message,
            buttonTitle: "OK",
            completion: completion
        )
    }

    func showAcceptanceAlert(
        on viewController: UIViewController,
        title: String,
        message: String?,
        completion: ((AcceptanceAlertAction) -> Void)?
    ) {
        showAcceptanceAlert(
            on: viewController,
            title: title,
            message: message,
            yesActionTitle: "Yes",
            noActionTitle: "No",
            yesActionStyle: .default,
            noActionStyle: .default,
            completion: completion
        )
    }
}
