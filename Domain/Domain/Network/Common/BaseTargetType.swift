//
//  BaseTargetType.swift
//  Domain
//
//  Created by 김종권 on 2020/12/19.
//

import Foundation
import Moya

public protocol BaseTargetType: TargetType { }
extension BaseTargetType {
    public var baseURL: URL {
        return AppSetting.configurations.serviceBaseURL
    }

    public var sampleData: Data {
        return Data()
    }

    public var headers: [String: String]? {
        var header = ["Content-Type": "application/json"]
        let baseHeader = BaseHeader.fetch()
        header["app-device-os-version"] = baseHeader.osVersion
        header["app-version"] = baseHeader.appVersion
        return header
    }
}
