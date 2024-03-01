//
//  DelayGenerator.swift
//  Dynamic Styling POC
//

import Foundation

public protocol DelayGenerator: AnyObject {
    func generate(delay: Double) async
}

public final class LiveDelayGenerator: DelayGenerator {
    public init() {}

    public func generate(delay: Double) async {
        try? await Task.sleep(nanoseconds: UInt64(delay * 1000000000.0))
    }
}
