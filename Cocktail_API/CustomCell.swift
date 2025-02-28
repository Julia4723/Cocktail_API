//
//  CustomCell.swift
//  Cocktail_API
//
//  Created by user on 27.02.2025.
//

import UIKit

final class CustomCell: UITableViewCell {
    private let customView = CustomView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: Model) {
        customView.configure(model: model)
    }
}


private extension CustomCell {
    func setup() {
        contentView.addSubview(customView)
        contentView.backgroundColor = .white
        setupLayout()
    }
}


private extension CustomCell {
    func setupLayout() {
        customView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: contentView.topAnchor),
            customView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            //customView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
