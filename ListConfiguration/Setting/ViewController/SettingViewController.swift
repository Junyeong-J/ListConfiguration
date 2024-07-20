//
//  SettingViewController.swift
//  ListConfiguration
//
//  Created by 전준영 on 7/19/24.
//

import UIKit

final class SettingViewController: BaseViewController<SettingView> {
    
    private let viewModel = SettingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
    
    override func configureView() {
        super.configureView()
    }
    
}

extension SettingViewController {
    private func bindData() {
        viewModel.inputViewDidLoadTrigger.value = ()
        viewModel.ouputAllCaseSetting.bind { [weak self] value in
            self?.rootView.updateSnapshot(value)
        }
    }
}
