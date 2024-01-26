//
//  FileReader.swift
//  Dynamic Styling POC
//

import Foundation
import XCTest

public enum FileReader {
    public static func readAndDecodeBundleResource<T: Decodable>(file name: String, extensionName: String, decodedInto type: T.Type) -> T? {
        guard let filePath = Bundle.module.path(forResource: name, ofType: extensionName),
              let data = try? Data(contentsOf: URL(fileURLWithPath: filePath), options: .mappedIfSafe)
        else {
            return nil
        }

        return try? JSONDecoder().decode(T.self, from: data)
    }
}
