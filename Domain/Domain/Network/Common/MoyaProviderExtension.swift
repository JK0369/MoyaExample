//
//  MoyaProviderExtension.swift
//  Domain
//
//  Created by 김종권 on 2020/12/18.
//

import Foundation
import Moya
import RxSwift

// Plugin을 설정 하기 위한 extension
public extension MoyaProvider {

    // real
    static func makeProvider() -> MoyaProvider<Target> {
        if AppSetting.configurations.useStub { // mock data
            return MoyaProvider<Target>.init(stubClosure: MoyaProvider<Target>.delayedStub(0.5), plugins: [RequestLoggingPlugin()])
        } else { // real data
            let authPlugin = AccessTokenPlugin { _ in
                if let token = AppSetting.configurations.bearerToken {
                    return token
                } else {
                    return ""
                }
            }
            return .init(plugins: [RequestLoggingPlugin(), authPlugin] )
        }
    }

    // mock
    static func makeStubProvider() -> MoyaProvider<Target> {
        return MoyaProvider<Target>.init(stubClosure: MoyaProvider<Target>.delayedStub(0.5), plugins: [RequestLoggingPlugin()])
    }
}

// 에러 처리를 위한 커스텀 reqeust
// 아래 1~3먼저 정의 후 extension

// 1. BaseResponsable: api호출 reponse에서 success, error 둘 중 responseCode를 error로 보내는 로직 정의
// 2. BaseResponse: 기본 response형식
// 3. BaseServiceError: Error타입 정의

public extension Reactive where Base: MoyaProviderType {
    func request<D: BaseResponsable>(_ token: Base.Target, callbackQueue: DispatchQueue? = nil, response type: D.Type) -> Single<D> {
        return Single.create { [weak base] single in
            let cancellableToken = base?.request(token, callbackQueue: callbackQueue, progress: nil) { result in
                switch result {
                case let .success(response):
                    do {
                        // 밑 두 줄 코드가 없다면, BaseResponse형식으로는 무조건 response오지만 responseCode가 0이 아닌지 먼저 판단하기 위함
                        let checkResponse = try response.map(BaseResponse.self)
                        try checkResponse.filterSuccessfulResponseCode()

                        let result = try response.map(type)
                        single(.success(result))
                    } catch let error {
                        if error is BaseServiceError {
                            single(.error(error))
                        } else if let moyaError = error as? MoyaError {
                            let baseError = BaseServiceError.moyaError(moyaError)
                            single(.error(baseError))
                        }
                    }
                case let .failure(error):
                    let tapError = BaseServiceError.moyaError(error)
                    single(.error(tapError))
                }
            }

            return Disposables.create {
                cancellableToken?.cancel()
            }
        }
    }
}
