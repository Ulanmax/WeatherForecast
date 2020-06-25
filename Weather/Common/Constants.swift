//
//  Constants.swift
//  Weather
//
//  Created by Maks Niagolov on 2020/06/25.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static let apiKey: String = "6e583e9a3ff709cf0d4cc360eef6c558"
}

public enum APIError: Error {
    case cannotParse
    case unknownError
    case connectionError
    case invalidCredentials
    case notFound
    case invalidResponse
    case serverError
    case serverUnavailable
    case timeOut
    case unsupportedURL
    case mailExist

    static func checkErrorCode(_ errorCode: Int) -> APIError {
        switch errorCode {
        case 401:
            return .invalidCredentials
        case 404:
            return .notFound
        case 409:
            return .mailExist
        default:
            return .unknownError
        }
    }
}
