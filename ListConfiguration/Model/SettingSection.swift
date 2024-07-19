//
//  SettingSection.swift
//  ListConfiguration
//
//  Created by 전준영 on 7/20/24.
//

import Foundation

struct Setting: Hashable, Identifiable {
    let id = UUID()
    let subTitle: String
}

struct SettingSection: Hashable {
    let section: Section
    let settingList: [Setting]
}

enum Section: String, CaseIterable, Hashable {
    case allSetting = "전체 설정"
    case personalSetting = "개인 설정"
    case other = "기타"
}
