//
//  SearchTextField.swift
//  RickMortyTestApp
//
//  Created by Adlet Zhantassov on 06.11.2023.
//

import UIKit

final class SearchTextField: UITextField {
    
    private let padding = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)

    init(placeholder: String) {
        super.init(frame: .zero)
        
        setupTextField(placeholder: placeholder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    private func setupTextField(placeholder: String) {
        textColor = .gray
        layer.cornerRadius = 5
        layer.backgroundColor = UIColor.white.cgColor
        layer.borderColor = UIColor.systemGray3.cgColor
        layer.borderWidth = 1
        
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowRadius = 2
//        layer.shadowOpacity = 0.1
//        layer.shadowOffset = CGSize(width: 10, height: 10)
//        
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        font = .boldSystemFont(ofSize: 18)
        
//        heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    
}
