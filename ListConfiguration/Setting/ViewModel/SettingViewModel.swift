//
//  SettingViewModel.swift
//  ListConfiguration
//
//  Created by 전준영 on 7/20/24.
//

import Foundation

final class SettingViewModel {
    
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    var ouputAllCaseSetting: Observable<[SettingSection]> = Observable([])
    
    init() {
        transForm()
    }
    
    private func transForm() {
        inputViewDidLoadTrigger.bind { [weak self] _ in
            self?.loadSettingView()
        }
    }
    
    private func loadSettingView() {
        ouputAllCaseSetting.value = SettingData.allCaseSetting
    }
}
