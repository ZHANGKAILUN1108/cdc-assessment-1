//
//  CryptoTableViewCell.swift
//  cdc-assessment-1
//
//  Created by Jacob Zhang on 2024/11/7.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {
    static let identifier = "CryptoTableViewCell"
    
    private let topBorder: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let bottomBorder: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(topBorder)
        contentView.addSubview(bottomBorder)
        
        NSLayoutConstraint.activate([
            topBorder.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topBorder.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topBorder.topAnchor.constraint(equalTo: contentView.topAnchor),
            topBorder.heightAnchor.constraint(equalToConstant: CDCSpaceConstants.spaceXSmall),
            
            bottomBorder.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomBorder.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomBorder.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomBorder.heightAnchor.constraint(equalToConstant: CDCSpaceConstants.spaceXSmall)
        ])

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: CDCSpaceConstants.space16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -CDCSpaceConstants.space16)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with crypto: CryptoModel) {
        titleLabel.text = crypto.title
    }
}
