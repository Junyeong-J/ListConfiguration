//
//  TalkView.swift
//  ListConfiguration
//
//  Created by 전준영 on 7/20/24.
//

import UIKit
import SnapKit

final class TalkView: BaseView {
    
    private var dataSource: UICollectionViewDiffableDataSource<TalkListSection, ChatRoom>? = nil
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCustomCollectionView())
    private func makeCustomCollectionView() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.headerMode = .none
        configuration.backgroundColor = .white
        configuration.showsSeparators = false
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    override func configureHierarchy() {
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        configureDataSource()
    }
    
    private func configureDataSource() {
        let registration = UICollectionView.CellRegistration<UICollectionViewListCell, ChatRoom> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.chatroomName
            if let lastMessage = itemIdentifier.chatList.last {
                content.secondaryText = lastMessage.message
                content.image = UIImage(named: lastMessage.user.profileImage)
            }
            content.imageProperties.tintColor = .gray
            cell.contentConfiguration = content
            let backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
            cell.backgroundConfiguration = backgroundConfig
        }
        
        dataSource = UICollectionViewDiffableDataSource<TalkListSection, ChatRoom>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: itemIdentifier)
        }
    }
    
    func updateSnapshot(_ chatRooms: [ChatRoom]) {
        var snapshot = NSDiffableDataSourceSnapshot<TalkListSection, ChatRoom>()
        snapshot.appendSections([.main])
        snapshot.appendItems(chatRooms, toSection: .main)
        dataSource?.apply(snapshot)
    }
    
}
