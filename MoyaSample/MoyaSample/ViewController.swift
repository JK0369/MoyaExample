//
//  ViewController.swift
//  MoyaSample
//
//  Created by 김종권 on 2020/12/18.
//

import UIKit
import Domain
import CommonExtension
import RxSwift
import RxCocoa

class ViewController: BaseViewController, ErrorPresentable {

    var viewModel: SampleVM!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupOutputBinding()
    }

    private func setupOutputBinding() {
        setupErrorHandlerBinding() // custom
    }
}

