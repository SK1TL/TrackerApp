//
//  StatisticCell.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 05.06.2024.
//

import UIKit

final class StatisticCell: UITableViewCell {
    
    static let identifier = Identifier.idStatisticCell

    private let containerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.ypBold34()
        label.textColor = .toggleBlackWhiteColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.ypMedium12()
        label.textColor = .toggleBlackWhiteColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Methods
    
    func configureCell(with model: StatisticsCellModel) {
        contentView.backgroundColor = .YPWhite
        
        addSubview()
        setConstraints()
        addGradientBorder()
        
        valueLabel.text = model.value
        descriptionLabel.text = model.description
    }
    
    private func addSubview() {
        contentView.addSubview(containerView)
        containerView.addSubview(valueLabel)
        containerView.addSubview(descriptionLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            valueLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            valueLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            valueLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            
            descriptionLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 7),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        ])
    }
    
    private func addGradientBorder() {
        let gradient = UIImage.gradientImage(
            bounds: containerView.bounds,
            colors: [
                UIColor.color(from: "FD4C49"),
                UIColor.color(from: "46E69D"),
                UIColor.color(from: "007BFA")
            ]
        )
        let gradientColor = UIColor(patternImage: gradient)
        
        containerView.layer.borderColor = gradientColor.cgColor
        containerView.layer.borderWidth = 2
        containerView.layer.cornerRadius = 16
    }
}
