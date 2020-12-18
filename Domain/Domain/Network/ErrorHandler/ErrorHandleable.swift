//
//  ErrorHandleable.swift
//  Domain
//
//  Created by 김종권 on 2020/12/19.
//

import Foundation
import RxSwift
import RxCocoa

public protocol ErrorHandleable {
    var showUndefinedError: PublishRelay<String> { get }
    var showServerErrorMessage: PublishRelay<String> { get }

    func handleError(_ error: Error)
}

public extension ErrorHandleable {
    func handleError(_ error: Error) {
        if case .invalidResponse = error as? BaseServiceError {
            showServerErrorMessage.accept(error.localizedDescription)
        } else {
            showUndefinedError.accept(error.localizedDescription)
        }
    }
}
