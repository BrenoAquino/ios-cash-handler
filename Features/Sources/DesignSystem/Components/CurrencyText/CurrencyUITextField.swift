//
//  CurrencyUITextField.swift
//  
//
//  Created by Breno Aquino on 27/02/22.
//

import UIKit
import SwiftUI

public class CurrencyUITextField: UIView {
    
    @Binding private var value: Double
    
    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    private lazy var textReferEmpty: String = {
        var zero = formatter.string(for: Double.zero) ?? .empty
        zero.removeLast()
        return zero
    }()
    
    // MARK: Gets
    private var textValue: String {
        return textField.text ?? .empty
    }

    private var doubleValue: Double {
        return (decimal as NSDecimalNumber).doubleValue
    }

    private var decimal: Decimal {
        return textValue.decimal / pow(10, formatter.maximumFractionDigits)
    }
    
    // MARK: - Layout Vars
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(textDidChage), for: .editingChanged)
        textField.keyboardType = .decimalPad
        textField.placeholder = formatter.string(for: Double.zero) ?? .empty
        return textField
    }()
    
    // MARK: - Life Cycle
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(value: Binding<Double>) {
        self._value = value
        
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
        if textField.text == textReferEmpty {
            textField.text = .empty
        } else {
            textField.text = formatter.string(for: decimal) ?? .empty
        }
        value = doubleValue
    }
}
