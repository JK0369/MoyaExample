//
//  BaseViewController.swift
//  MoyaSample
//
//  Created by 김종권 on 2020/12/19.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

open class BaseViewController: UIViewController {
    public let bag = DisposeBag()
}

extension Reactive where Base: BaseViewController {
    var showUndefinedErrorMessageDialog: Binder<String> {
        return Binder(base) { vc, errorMsg in
            print("error = \(errorMsg)")
        }
    }

    var showServiceErrorMessageDialog: Binder<String> {
        return Binder(base) { vc, errorMsg in
            print("error = \(errorMsg)")
        }
    }
}
