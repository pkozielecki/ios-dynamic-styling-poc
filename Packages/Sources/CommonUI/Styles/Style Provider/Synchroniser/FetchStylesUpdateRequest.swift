//
//  FetchStylesUpdateRequest.swift
//  Dynamic Styling POC
//

import Common
import Foundation
import NgNetworkModuleCore

struct FetchStylesUpdateRequest: NetworkRequest {
    let method = NetworkRequestType.get
    let path =
        "https://knp1og.am.files.1drv.com/y4mjcBgsZgx3gjjZCnMHX9EH9VxcYZv_yGocxuRK2312uMTC6dQ_rK6iitRvS4LrE7Gme320Ko496Nmiy8pnKJFIGe56BqqoLO78YXF8d69PmQ2KYAYtauXcR3lUIhToCM2KO5CIvx6cuJsVEiIBtRhCUTK2PGny_rf9ViMGaAvPye7bBIQ45u_4yAq0X483p9Pzj7oKPhRwlRu3sUlaPR2RA"
    let additionalHeaderFields: [String: String]

    init() {
        additionalHeaderFields = [
            AppConstants.contentTypeFieldName: AppConstants.contentTypeFieldValue,
            AppConstants.acceptFieldName: AppConstants.acceptFieldValue,
        ]
    }
}

private extension FetchStylesUpdateRequest {}
