//
//  CommonExtension.swift
//  CommonExtension
//
//  Created by 김종권 on 2020/12/19.
//

import Foundation
import RxSwift
import RxCocoa

public extension Encodable {
    func toDictionary() -> [String: Any] {
        do {
            let data = try JSONEncoder().encode(self)
            let dic =  try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            return dic ?? [:]
        } catch {
            return [:]
        }
    }
}

public extension ObservableType {
    func asDriverOnErrorNever() -> Driver<Element> {
        return asDriver { error in
            return .never()
        }
    }
}
