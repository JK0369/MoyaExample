//
//  SampleVM.swift
//  MoyaSample
//
//  Created by 김종권 on 2020/12/19.
//

import Foundation
import Domain
import CommonExtension
import RxSwift
import RxCocoa
import Moya

class SampleVM: ErrorHandleable {

    let accountUseCase = MoyaProvider<AccountTarget>.makeProvider()
    let bag = DisposeBag()

    var showUndefinedError = PublishRelay<String>()
    var showServerErrorMessage = PublishRelay<String>()

    func member() {
        let request = MemberInfoRequest(memberID: "123")
        accountUseCase.rx.request(.memberInfo(request), response: MemberInfoResponse.self)
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] (result) in
                switch result {
                case .success(let response):
                    print(response.result)
                case .error(let error):
                    self?.handleError(error)
                }
            }.disposed(by: bag)
    }

}
