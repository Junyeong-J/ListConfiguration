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
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.backgroundColor = .systemRed
        configuration.showsSeparators = false
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let sectionType = Section.allCases[sectionIndex]
            return self.createBasicLayout()
        }
        return layout
    }
    
    func createBasicLayout() -> NSCollectionLayoutSection {
        /// 각 item의 사이즈 설정
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(44))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        /// 아이템의 마진 값 설정
//        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        
        /// 아이템들이 들어갈 Group 설정
        /// groupSize 설정
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(44))
        /// subitem에 item을 넣어주고 각 그룹 당 아이템이 보여질 갯수는 3개
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        /// 최종적으로 section 설정
        let section = NSCollectionLayoutSection(group: group)
        
        /// 헤더 생성
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        /// 이 Layout은 헤더를 보여지도록 적용
        section.boundarySupplementaryItems = [ header ]
        /// 어떤 형식의 스크롤을 쓸지 결정
//        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        configureDataSource()
        updateSnapshot()
    }
    
    private func configureDataSource() {
        var registration: UICollectionView.CellRegistration<UICollectionViewListCell, Setting>!
        registration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.subTitle
            content.secondaryTextProperties.color = .blue
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

