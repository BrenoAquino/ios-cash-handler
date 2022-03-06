//
//  MaskedUITextField.swift
//  
//
//  Created by Breno Aquino on 06/03/22.
//

import UIKit
import SwiftUI

public class MaskedUITextField: UIView {
    
    private let placeholder: String?
    private let formatter: (_ text: String?) -> String?
    
    @Binding private var text: String
    
    // MARK: - Layout Vars
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(textDidChage), for: .editingChanged)
        textField.placeholder = placeholder
        return textField
    }()
    
    // MARK: - Life Cycle
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(placeholder: String? = nil, formatter: @escaping (_ text: String?) -> String?, text: Binding<String>) {
        self.placeholder = placeholder
        self.formatter = formatter
        self._text = text
        
        super.init(frame: .zero)
        setupLayout()
    }
    
    // MARK: - Setups
    private func setupLayout() {
        addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - Text Field
    @objc private func textDidChage() {
        if textField.text == formatter(nil) || textField.text == formatter(.empty) {
            textField.text = nil
        } else {
            textField.text = formatter(textField.text)
        }
    }
}
