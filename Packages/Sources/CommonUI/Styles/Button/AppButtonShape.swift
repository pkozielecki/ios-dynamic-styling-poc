//
//  AppButtonShape.swift
//  Dynamic Styling POC
//

import SwiftUI

public enum AppButtonShape: Equatable, Codable {
    case capsule
    case roundedRectangle(CGFloat)
    case `default`
    case circle
}
