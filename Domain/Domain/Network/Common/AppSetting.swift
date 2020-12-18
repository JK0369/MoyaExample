//
//  AppSetting.swift
//  Domain
//
//  Created by 김종권 on 2020/12/18.
//

import Foundation

public struct AppConfigurations {
    public let useStub = false
    public var serviceBaseURL = URL(string: "https://sample/")!
    public var bearerToken: String?
}

public class AppSetting {
    public static var configurations = AppConfigurations()
    
}
