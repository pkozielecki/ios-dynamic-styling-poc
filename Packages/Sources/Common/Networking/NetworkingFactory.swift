//
//  NetworkingFactory.swift
//  Dynamic Styling POC
//

@_exported import ConcurrentNgNetworkModule
import Foundation
@_exported import NgNetworkModuleCore

public enum NetworkingFactory {
    public static func makeNetworkModule(baseURL: URL) -> NetworkModule {
        let requestBuilder = DefaultRequestBuilder(baseURL: baseURL)
        return DefaultNetworkModule(requestBuilder: requestBuilder)
    }
}
