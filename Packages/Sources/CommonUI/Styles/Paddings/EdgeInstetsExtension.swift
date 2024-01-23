//
//  EdgeInstetsExtension.swift
//  Dynamic Styling POC
//

import SwiftUI

public extension [CGFloat] {
    var edgeInsets: EdgeInsets {
        switch count {
        case 1:
            .init(top: self[0], leading: self[0], bottom: self[0], trailing: self[0])
        case 2:
            .init(top: self[0], leading: self[1], bottom: self[1], trailing: self[1])
        case 3:
            .init(top: self[0], leading: self[1], bottom: self[2], trailing: self[2])
        case 4...:
            .init(top: self[0], leading: self[1], bottom: self[2], trailing: self[3])
        default:
            .init()
        }
    }
}
