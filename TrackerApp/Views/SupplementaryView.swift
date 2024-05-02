//
//  SupplementaryView.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 02.05.2024.
//

import UIKit

final class SupplementaryView: UICollectionReusableView {
    
    static let identifier = Identifier.idSupply
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.ypBold19()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(titleLabel)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
