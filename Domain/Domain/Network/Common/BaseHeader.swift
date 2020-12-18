//
//  BaseHeader.swift
//  Domain
//
//  Created by 김종권 on 2020/12/18.
//

import Foundation
import UIKit

public struct BaseHeader {
    public let osVersion: String
    public let appVersion: String

    public init(
        osVersion: String,
        appVersion: String
    ) {
        self.osVersion = osVersion
        self.appVersion = appVersion
    }
}

public extension BaseHeader {
    static func fetch() -> BaseHeader {
        return BaseHeader(
            osVersion: UIDevice.current.systemVersion,
            appVersion: Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        )
    }
}
