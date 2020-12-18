//
//  BaseServiceError.swift
//  Domain
//
//  Created by 김종권 on 2020/12/18.
//

import Foundation
import Moya

public enum BaseServiceError: Error {
    case moyaError(MoyaError)
    case invalidResponse(responseCode: Int, message: String) // response code가 0이 아닌경우
}

extension BaseServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .moyaError(let moyaError):
            return moyaError.localizedDescription
        case let .invalidResponse(responseCode, messase):
            return "\(messase)(\(responseCode))"
        }
    }
}

//public static BaseErrorMessage {
//    static let common: [String: String] = [ // 의미: [responseCode: Message]
//        "1": "인터넷에 연결되지 않음",
//        "2": "잘못된 인증번호 입니다",
//    ]
//}
