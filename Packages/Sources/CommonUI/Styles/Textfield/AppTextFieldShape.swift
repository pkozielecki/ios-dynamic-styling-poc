//
//  AppTextFieldShape.swift
//  Dynamic Styling POC
//

import SwiftUI

public enum AppTextFieldShape: Equatable, Codable {
    case rounded(cornerRadius: CGFloat)
    case plain
}
