//
//  SettingViewController.swift
//  ListConfiguration
//
//  Created by 전준영 on 7/19/24.
//

import UIKit
import SnapKit

final class SettingViewController: UIViewController {
    
    private let viewModel = SettingViewModel()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Setting>? = nil
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
        bindData()
    }
    
    private func bindData() {
        viewModel.inputViewDidLoadTrigger.value = ()
        viewModel.ouputAllCaseSetting.bind { [weak self] value in
            self?.updateSnapshot(value)
        }
    }
    
    private func configureDataSource() {
        var registration: UICollectionView.CellRegistration<UICollectionViewListCell, Setting>!
        registration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.subTitle
            content.image = UIImage(systemName: "star.fill")
            content.imageProperties.tintColor = .orange
            cell.contentConfiguration = content
            let backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
            cell.backgroundConfiguration = backgroundConfig
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration<UICollectionViewListCell>(elementKind: UICollectionView.elementKindSectionHeader) { supplementaryView, elementKind, indexPath in
            var configuration = UIListContentConfiguration.groupedHeader()
            configuration.textProperties.color = .black
            if let section = self.dataSource?.snapshot().sectionIdentifiers[indexPath.section] {
                configuration.text = section.rawValue
            }
            supplementaryView.contentConfiguration = configuration
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Setting>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: itemIdentifier)
        })
        
        dataSource?.supplementaryViewProvider = { collectionView, elementKind, indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
    }
    
    private func updateSnapshot(_ sections: [SettingSection]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Setting>()
        for section in sections{
            snapshot.appendSections([section.section])
            snapshot.appendItems(section.settingList, toSection: section.section)
        }
        dataSource?.apply(snapshot)
    }
}

