//
//  ErrorPresentable.swift
//  Domain
//
//  Created by 김종권 on 2020/12/19.
//

import Foundation
import CommonExtension
import RxSwift
import RxCocoa

public protocol ErrorPresentable: BaseViewController {
    associatedtype ViewModel: ErrorHandleable
    var viewModel: ViewModel! { get }

    func setupErrorHandlerBinding()
}

public extension ErrorPresentable {
    func setupErrorHandlerBinding() {
        viewModel.showUndefinedError.asDriverOnErrorNever()
            .drive(rx.showUndefinedErrorMessageDialog)
            .disposed(by: bag)

        viewModel.showServerErrorMessage.asDriverOnErrorNever()
            .drive(rx.showServiceErrorMessageDialog)
            .disposed(by: bag)
    }
}
