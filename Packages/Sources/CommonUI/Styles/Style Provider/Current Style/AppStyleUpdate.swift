//
//  AppStyleUpdate.swift
//  Dynamic Styling POC
//

import Foundation

public struct AppStyleUpdate: Equatable, Codable {
    public let designSystem: AppDesignSystemUpdate?
    public let components: AppComponentsStylesUpdate?
}
