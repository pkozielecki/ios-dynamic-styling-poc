//
//  EmailPasswordLoginView.swift
//  Dynamic Styling POC
//

import Common
import CommonUI
import SwiftUI

struct EmailPasswordLoginView: View {
    let viewModel: EmailPasswordLoginViewModel

    var body: some View {
        VStack {
            Text("EmailPasswordLoginView")
        }
        .task {
            viewModel.onViewAppeared()
        }
    }
}

private extension EmailPasswordLoginView {
    var viewState: EmailPasswordLoginViewState {
        viewModel.viewState
    }
}

#if DEBUG
#Preview {
    let viewModel = PreviewEmailPasswordLoginViewModel()
    return EmailPasswordLoginView(viewModel: viewModel)
}
#endif
