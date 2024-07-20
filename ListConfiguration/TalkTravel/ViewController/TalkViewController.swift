//
//  TalkViewController.swift
//  ListConfiguration
//
//  Created by 전준영 on 7/20/24.
//

import UIKit

final class TalkViewController: BaseViewController<TalkView>{
    
    private let viewModel = TalkViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
    
    override func configureView() {
        super.configureView()
    }
    
}

extension TalkViewController {
    private func bindData() {
        viewModel.inputViewDidLoadTrigger.value = ()
        viewModel.ouputTalkList.bind { [weak self] value in
            self?.rootView.updateSnapshot(value)
        }
    }
}
