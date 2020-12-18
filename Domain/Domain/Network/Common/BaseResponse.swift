//
//  BaseResponse.swift
//  Domain
//
//  Created by 김종권 on 2020/12/18.
//

import Foundation

public struct BaseResponse: BaseResponsable {
    public let responseCode: Int
    public let message: String
}
