//
//  MemberInfoResponse.swift
//  Domain
//
//  Created by 김종권 on 2020/12/19.
//

import Foundation

// MARK: - MemberInfoResponse
public struct MemberInfoResponse: BaseResponsable {
    public let responseCode: Int
    public let message: String
    public let result: MemberInfoResult
}

// MARK: - Result
public struct MemberInfoResult: Codable {
    public let phoneNumber, name: String
}

/* json
 {
    "responseCode":0,
    "message":"success",
    "result":{
       "phoneNumber":"01012341234"
    }
 }
 */
