//
//  BaseResponsable.swift
//  Domain
//
//  Created by 김종권 on 2020/12/18.
//

import Foundation

public protocol BaseResponsable: Codable {
    var responseCode: Int { get }
    var message: String { get }
}

extension BaseResponsable {
    @discardableResult
    func filterSuccessfulResponseCode() throws -> Self { // 0이 아니면 오류 발생
        if self.responseCode != 0 {
            throw BaseServiceError.invalidResponse(responseCode: responseCode, message: self.message)
        }
        return self
    }
}
