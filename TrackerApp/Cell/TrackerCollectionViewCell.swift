//
//  TrackerCollectionViewCell.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 22.04.2024.
//

import UIKit

protocol TrackerCollectionViewCellDelegate: AnyObject {
    func didTapedDoneButton(cell: TrackerCollectionViewCell)
}

final class TrackerCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: TrackerCollectionViewCellDelegate?
    
    static let identifire = Identifier.idTrackerCell
    
    private lazy var colorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var emojiLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.backgroundColor = .YPWhiteAlpha
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var trackerNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .YPWhite
        label.font = Resources.Fonts.ypMedium12()
        label.numberOfLines = 2
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .natural
        label.textColor = .YPBlack
        label.font = Resources.Fonts.ypMedium12()
        label.text = "0 дней"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.YPWhite, for: .normal)
        button.layer.cornerRadius = 17
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(didTapedButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let pinImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "pin.fill")
        imageView.tintColor = .white
        imageView.isHidden = true
        return imageView
    }()
    
    private var days = 0 {
        didSet {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .currency
            numberFormatter.locale = Locale.current
            counterLabel.text = String.localizedStringWithFormat(
                NSLocalizedString("numberOfDays", comment: "Number of checked days"),
                days
            )
        }
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
        contentView.addSubview(colorView)
        contentView.addSubview(addButton)
        contentView.addSubview(counterLabel)
        colorView.addSubview(emojiLabel)
        colorView.addSubview(trackerNameLabel)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            colorView.topAnchor.constraint(equalTo: contentView.topAnchor),
            colorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            colorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            colorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -42),
            
            emojiLabel.leadingAnchor.constraint(equalTo: colorView.leadingAnchor, constant: 12),
            emojiLabel.topAnchor.constraint(equalTo: colorView.topAnchor, constant: 12),
            emojiLabel.heightAnchor.constraint(equalToConstant: 24),
            emojiLabel.widthAnchor.constraint(equalToConstant: 24),
            
            trackerNameLabel.leadingAnchor.constraint(equalTo: colorView.leadingAnchor, constant: 12),
            trackerNameLabel.trailingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: -12),
            trackerNameLabel.bottomAnchor.constraint(equalTo: colorView.bottomAnchor, constant: -12),
            
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            addButton.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 8),
            addButton.heightAnchor.constraint(equalToConstant: 34),
            addButton.widthAnchor.constraint(equalToConstant: 34),
            
            counterLabel.centerYAnchor.constraint(equalTo: addButton.centerYAnchor),
            counterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12)
        ])
    }
    
    func configeCell(tracker: Tracker) {
        trackerNameLabel.text = tracker.text
        emojiLabel.text = tracker.emoji
        colorView.backgroundColor = tracker.color
        addButton.backgroundColor = tracker.color
    }
    
    func configRecord(countDay: Int, isDoneToday: Bool) {
        addButton.setTitle(isDoneToday ? "✓" : "+", for: .normal)        
        addButton.layer.opacity = isDoneToday ? 0.3 : 1
        updateCounter(countDay)
    }
    
    private func updateCounter(_ counter: Int) {
        switch counter {
        case _ where (1 == counter % 10) && !(10...19 ~= counter % 100):
            counterLabel.text = String(counter) + " " + "день"
        case _ where (2...4 ~= counter % 10) && !(10...19 ~= counter % 100):
            counterLabel.text = String(counter) + " " + "дня"
        default:
            counterLabel.text = String(counter) + " " + "дней"
        }
    }
    
    @objc func didTapedButton() {
        delegate?.didTapedDoneButton(cell: self)
    }
}
