//
//  AccountTarget.swift
//  Domain
//
//  Created by 김종권 on 2020/12/19.
//

import Foundation
import Moya
import CommonExtension

public enum AccountTarget {
    case memberInfo(MemberInfoRequest)
    case signUp(SignUpRequest)
}

extension AccountTarget: BaseTargetType {
    public var path: String {
        switch self {
        case .memberInfo:
            return "member/memberInfo"
        case .signUp:
            return "member/signUp"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .memberInfo:
            return .get
        case .signUp:
            return .post
        }
    }

    public var sampleData: Data {
        switch self {
        case .memberInfo:
            return """
                 {
                    "responseCode":0,
                    "message":"success",
                    "result":{
                       "phoneNumber":"01012341234"
                    }
                 }
                """.data(using: .utf8)!
        case .signUp:
            return """
            {
              "statusCode" : 0,
              "message" : "COMMON_OK"
            }
            """.data(using: .utf8)!
        }
    }

    public var task: Task {
        switch self {
        case .memberInfo(let request): // query string 방법 (get)
            return .requestParameters(parameters: request.toDictionary(), encoding: URLEncoding.queryString) // toDictionary는 커스텀 commonExtension
        case .signUp(let request): // body에 데이터를 넣는 경우 (post, put, delete)
            return .requestJSONEncodable(request)
        }
    }
}
