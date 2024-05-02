//
//  EmojiAndColorsCollectionCell.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 02.05.2024.
//

import UIKit

final class EmojiAndColorsCollectionCell: UICollectionViewCell {
    
    static var reuseIdentifier = Identifier.idEmojiAndColorsCell
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.ypBold32()
        label.text = ""
        label.textColor = .YPBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(label)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
