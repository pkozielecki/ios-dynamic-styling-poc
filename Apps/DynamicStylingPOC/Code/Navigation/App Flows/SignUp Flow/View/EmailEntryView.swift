//
//  EmailEntryView.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI

struct EmailEntryView: View {
    let viewModel: EmailEntryViewModel

    var body: some View {
        VStack {
            Text("EmailEntryView")
        }
        .task {
            viewModel.onViewAppeared()
        }
    }
}

private extension EmailEntryView {
    var viewState: EmailEntryViewState {
        viewModel.viewState
    }
}

#if DEBUG
#Preview {
    let viewModel = PreviewEmailEntryViewModel()
    return EmailEntryView(viewModel: viewModel)
}
#endif
