//
//  TalkViewModel.swift
//  ListConfiguration
//
//  Created by 전준영 on 7/20/24.
//

import Foundation

final class TalkViewModel {
    
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    var ouputTalkList: Observable<[ChatRoom]> = Observable([])
    
    init() {
        transForm()
    }
    
    private func transForm() {
        inputViewDidLoadTrigger.bind { [weak self] _ in
            self?.loadSettingView()
        }
    }
    
    private func loadSettingView() {
        ouputTalkList.value = mockChatList
    }
    
}
