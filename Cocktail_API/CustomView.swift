//
//  CustomView.swift
//  Cocktail_API
//
//  Created by user on 27.02.2025.
//

import UIKit

final class CustomView: UIView {
    private let nameLabel = UILabel.makeLabel(font: .systemFont(ofSize: 20, weight: .bold), textColor: .black)
    private let ingredientsLabel = UILabel.makeLabel(font: .systemFont(ofSize: 16, weight: .regular), textColor: .black, numberOfLines: 1)
    private let instructionLabel = UILabel.makeLabel(font: .systemFont(ofSize: 16, weight: .regular), textColor: .systemGray, numberOfLines: 1)
   

    override init(frame: CGRect) {
        super .init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    func configure(model: Model) {
        nameLabel.text = model.name
        ingredientsLabel.text = model.ingredients.joined(separator: ", ")
        instructionLabel.text = model.instructions
    }
}

private extension CustomView {
    func setup() {
        addSubviews()
        setupLayout()
    }
    
    func addSubviews() {
        [nameLabel, ingredientsLabel, instructionLabel].forEach { view in
            addSubview(view)
        }
    }
}



private extension CustomView {
    func setupLayout() {
        [nameLabel, ingredientsLabel, instructionLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            
            ingredientsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            ingredientsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            ingredientsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            ingredientsLabel.heightAnchor.constraint(equalToConstant: 60),
            
            instructionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            instructionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            instructionLabel.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 8),
            instructionLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}
