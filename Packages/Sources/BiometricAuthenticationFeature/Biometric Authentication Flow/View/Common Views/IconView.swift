//
//  IconView.swift
//  Dynamic Styling POC
//

import SwiftUI

struct IconView: View {
    var iconName: String
    var tintColor: Color

    var body: some View {
        Image(systemName: iconName)
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .colorMultiply(tintColor)
    }
}
