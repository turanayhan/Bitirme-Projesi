//
//  HourCell.swift
//  Hizmet Burada
//
//  Created by turan on 10.10.2024.
//
import UIKit
// Saat hücresini temsil eden özel hücre
class Hour: UICollectionViewCell {
    let hourLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(hourLabel)
        hourLabel.frame = contentView.bounds
        hourLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.systemYellow.cgColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(isSelected: Bool) {
        if isSelected {
            contentView.backgroundColor = .systemYellow
            hourLabel.textColor = .white
        } else {
            contentView.backgroundColor = .clear
            hourLabel.textColor = .black
        }
    }
}
