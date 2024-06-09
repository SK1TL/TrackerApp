//
//  SupplementaryView.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 02.05.2024.
//

import UIKit

final class SupplementaryView: UICollectionReusableView {
    
    static let identifier = Identifier.idSupple
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.ypBold19()
        label.textColor = .toggleBlackWhiteColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubview() {
        addSubview(headerLabel)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
