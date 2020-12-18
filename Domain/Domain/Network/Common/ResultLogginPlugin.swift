//
//  ResultLogginPlugin.swift
//  Domain
//
//  Created by 김종권 on 2020/12/18.
//

import Foundation
import Moya

final class RequestLoggingPlugin: PluginType {

    // api 호출 바로 전 동작
    func willSend(_ request: RequestType, target: TargetType) {
        guard let httpRequest = request.request else {
            print("[SEND] invalid request")
            return
        }

        let url = httpRequest.description
        let method = httpRequest.httpMethod ?? "unknown method"
        var log = "[SEND] \(method) \(target)\n\(url)\n"
        if let urlReadable = url.removingPercentEncoding, url != urlReadable {
            log.append("\(urlReadable)\n")
        }

        if let headers = httpRequest.allHTTPHeaderFields, !headers.isEmpty {
            log.append("header: \(headers)\n")
        }

        if let body = httpRequest.httpBody, let bodyString = String(bytes: body, encoding: String.Encoding.utf8) {
            log.append("\(bodyString)\n")
        }

        log.append("[SEND] END \(method)")
        print(log, "\n")
    }

    /// API Response
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case let .success(response):
            onSuceed(response, target: target, isFromError: false)
        case let .failure(error):
            onFail(error, target: target)
        }
    }

    func onSuceed(_ response: Response, target: TargetType, isFromError: Bool) {
        let request = response.request
        let url = request?.url?.absoluteString ?? "nil"
        let statusCode = response.statusCode

        var log = "[RCV] \(statusCode) \(target)\n\(url)\n"
        if let urlReadable = url.removingPercentEncoding, url != urlReadable {
            log.append("\(urlReadable)\n")
        }

        response.response?.allHeaderFields.forEach {
            log.append("\($0): \($1)\n")
        }

        if let reString = String(bytes: response.data, encoding: String.Encoding.utf8) {
            log.append("\(reString)\n")
        }

        log.append("[RCV] END HTTP (\(response.data.count)-byte body)")
        print(log, "\n")
    }

    func onFail(_ error: MoyaError, target: TargetType) {
        if let response = error.response {
            onSuceed(response, target: target, isFromError: true)
            return
        }

        var log = "[RCV] \(error.errorCode) \(target)\n"
        log.append("\(error.failureReason ?? error.errorDescription ?? "unknown error")\n")
        log.append("[RCV] END HTTP")
        print(log, "\n")
    }
}
