//
//  SignUpRequest.swift
//  Domain
//
//  Created by 김종권 on 2020/12/19.
//

import Foundation

public struct SignUpRequest: Codable {
    public let email: String
    public let password: String

    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
