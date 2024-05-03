//
//  EmojiAndColorsCollectionDelegate.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 02.05.2024.
//

import UIKit

protocol EmojiAndColorsCollectionDelegate: AnyObject {
    func addNewEmoji(_ emoji: String)
    func addNewColor(_ color: UIColor)
}

final class EmojiAndColorsCollection: NSObject {
    
    weak var delegate: EmojiAndColorsCollectionDelegate?
    
    private let params = GeometricParams(
        cellCount: 6,
        leftInset: 25,
        rightInset: 25,
        cellSpacing: 5
    )
    
    private var emojis = Resources.emojis
    private var colors = Resources.colors
    
    override init() {
        super.init()
        for i in 1...18 {
            colors.append(UIColor(named: String(i)) ?? .clear)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension EmojiAndColorsCollection: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        emojis.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: EmojiAndColorsCollectionCell.reuseIdentifier,
            for: indexPath
        ) as? EmojiAndColorsCollectionCell else {
            return UICollectionViewCell()
        }
        switch indexPath.section {
        case 0:
            cell.layer.cornerRadius = 16
            cell.label.text = emojis[indexPath.row]
        case 1:
            cell.layer.cornerRadius = 13
            cell.label.text = ""
            cell.contentView.backgroundColor = colors[indexPath.row]
        default:
            break
        }
        
        cell.prepareForReuse()
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: SupplementaryView.identifier,
            for: indexPath
        ) as? SupplementaryView else {
            return UICollectionReusableView()
        }
        switch indexPath.section {
        case 0:
            view.titleLabel.text = "Emoji"
        case 1:
            view.titleLabel.text = "Цвет"
        default:
            break
        }
        
        return view
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension EmojiAndColorsCollection: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(
            collectionView,
            viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader,
            at: indexPath
        )
        
        return headerView.systemLayoutSizeFitting(
            CGSize(
                width: collectionView.frame.width,
                height: UIView.layoutFittingExpandedSize.height
            ),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: 25, left: params.leftInset, bottom: 25, right: params.rightInset)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let availableWidth = collectionView.frame.width - params.paddingWidth
        let cellWidth = availableWidth / CGFloat(params.cellCount)
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        params.cellSpacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        params.cellSpacing
    }
}

// MARK: - UICollectionViewDelegate
extension EmojiAndColorsCollection: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? EmojiAndColorsCollectionCell {
            switch indexPath.section {
            case 0:
                for item in 0..<collectionView.numberOfItems(inSection: 0){
                    guard 
                        let cell = collectionView.cellForItem(at: IndexPath(row: item, section: 0))
                    else { return }
                    cell.backgroundColor = .clear
                }
                cell.backgroundColor = .YPLightGray
                delegate?.addNewEmoji(cell.label.text ?? "")
            case 1:
                for item in 0..<collectionView.numberOfItems(inSection: 1) {
                    guard let cell = collectionView.cellForItem(at: IndexPath(row: item, section: 1)) else { return }
                    cell.backgroundColor = .clear
                    cell.layer.borderWidth = 0
                }
                cell.layer.borderColor = cell.contentView.backgroundColor?.withAlphaComponent(0.3).cgColor
                cell.layer.borderWidth = 3
                delegate?.addNewColor(cell.contentView.backgroundColor ?? .clear)
            default:
                break
            }
        }
    }
}
