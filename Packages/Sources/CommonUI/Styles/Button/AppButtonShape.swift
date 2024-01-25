//
//  AppButtonShape.swift
//  Dynamic Styling POC
//

import SwiftUI

public enum AppButtonShape: Equatable, Codable {
    case capsule
    case roundedRectangle(cornerRadius: CGFloat)
    case `default`
    case circle
}
