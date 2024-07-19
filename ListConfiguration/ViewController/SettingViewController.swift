//
//  SettingViewController.swift
//  ListConfiguration
//
//  Created by 전준영 on 7/19/24.
//

import UIKit
import SnapKit

struct Setting: Hashable, Identifiable {
    let id = UUID()
    let subTitle: String
}

final class SettingViewController: UIViewController {
    
    enum Section: CaseIterable {
        case allSetting
        case personalSetting
        case other
        
        var title: String {
            switch self {
            case .allSetting:
                return "전체 설정"
            case .personalSetting:
                return "개인 설정"
            case .other:
                return "기타"
            }
        }
    }
    
    let allSetting = [
        Setting(subTitle: "공지사항"),
        Setting(subTitle: "실험실"),
        Setting(subTitle: "버전 정보")
    ]
    
    let personalSetting = [
        Setting(subTitle: "개인/보안"),
        Setting(subTitle: "알림"),
        Setting(subTitle: "채팅"),
        Setting(subTitle: "멀티프로필")
    ]
    
    let other = [
        Setting(subTitle: "고객센터/도움말")
    ]
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Setting>!
    private lazy var collectionView = makeCollectionView()
    
    func makeCollectionView() -> UICollectionView {
        
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.headerMode = .supplementary
        configuration.backgroundColor = .systemRed
        configuration.showsSeparators = false
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        collectionView.backgroundColor = .black
        configureDataSource()
        updateSnapshot()
    }
    
    private func configureDataSource() {
        var registration: UICollectionView.CellRegistration<UICollectionViewListCell, Setting>!
        registration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.subTitle
            content.image = UIImage(systemName: "star.fill")
            content.imageProperties.tintColor = .orange
            cell.contentConfiguration = content
            var backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
            cell.backgroundConfiguration = backgroundConfig
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration<UICollectionViewListCell>(elementKind: UICollectionView.elementKindSectionHeader) { supplementaryView, elementKind, indexPath in
            var configuration = UIListContentConfiguration.groupedHeader()
            configuration.textProperties.color = .black
            configuration.text = self.dataSource.snapshot().sectionIdentifiers[indexPath.section].title
            supplementaryView.contentConfiguration = configuration
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Setting>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: itemIdentifier)
        })
        
        dataSource.supplementaryViewProvider = { collectionView, elementKind, indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
    }
    
    func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Setting>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(allSetting, toSection: .allSetting)
        snapshot.appendItems(personalSetting, toSection: .personalSetting)
        snapshot.appendItems(other, toSection: .other)
        dataSource.apply(snapshot)
    }
}

