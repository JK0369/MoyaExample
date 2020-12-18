//
//  MemberInfoRequest.swift
//  Domain
//
//  Created by 김종권 on 2020/12/19.
//

import Foundation

public struct MemberInfoRequest: Codable {
    public let memberID: String

    enum CodingKeys: String, CodingKey {
        case memberID = "memberId"
    }

    public init(memberID: String) {
        self.memberID = memberID
    }
}
