//
//  DataExtension.swift
//  Dynamic Styling POC
//

import Foundation

public extension Data {
    func decode<T: Decodable>(into type: T.Type) -> T? {
        try? JSONDecoder().decode(T.self, from: self)
    }
}
