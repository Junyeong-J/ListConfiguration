//
//  SettingData.swift
//  ListConfiguration
//
//  Created by 전준영 on 7/20/24.
//

import Foundation

struct SettingData {
    
    static let allCaseSetting: [SettingSection] = [
        SettingSection(section: .allSetting,
                       settingList: [
                        Setting(subTitle: "공지사항"),
                        Setting(subTitle: "실험실"),
                        Setting(subTitle: "버전 정보")
                       ]
                      ),
        SettingSection(section: .personalSetting,
                       settingList: [
                        Setting(subTitle: "개인/보안"),
                        Setting(subTitle: "알림"),
                        Setting(subTitle: "채팅"),
                        Setting(subTitle: "멀티프로필")
                       ]
                      ),
        SettingSection(section: .other,
                       settingList: [
                        Setting(subTitle: "고객센터/도움말")
                       ]
                      )
        
    ]
    
}
