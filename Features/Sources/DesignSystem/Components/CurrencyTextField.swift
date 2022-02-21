//
//  CurrencyTextField.swift
//  
//
//  Created by Breno Aquino on 16/02/22.
//

import SwiftUI
import UIKit

//public struct CurrencyTextField: UIViewRepresentable {
//    
//    @Binding var value: Double?
//    
//    public func makeCoordinator() -> CurrencyTextField.Coordinator {
//        Coordinator(value: $value,
//                    isResponder: self.isResponder,
//                    alwaysShowFractions: self.alwaysShowFractions,
//                    numberOfDecimalPlaces: self.numberOfDecimalPlaces,
//                    currencySymbol: self.currencySymbol,
//                    onReturn: self.onReturn){ flag in
//            self.onEditingChanged(flag)
//        }
//    }
//    
//    public func makeUIView(context: UIViewRepresentableContext<Self>) -> UITextField {
//        let textField = UITextField()
//        textField.delegate = context.coordinator
//        context.coordinator
//        
//        textField.addTarget(context.coordinator, action: #selector(context.coordinator.textFieldEditingDidBegin(_:)), for: .editingDidBegin)
//        textField.addTarget(context.coordinator, action: #selector(context.coordinator.textFieldEditingDidEnd(_:)), for: .editingDidEnd)
//        
//        textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
//        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
//        
//        return textField
//    }
//    
//    public func updateUIView(_ uiView: UITextField, context: Context) {
//    }
//    
//    public class Coordinator: NSObject, UITextFieldDelegate {
//        
//        @Binding var value: Double?
//        
//        var internalValue: Double?
//        var onEditingChanged: (Bool)->()
//        var didBecomeFirstResponder = false
//        
//        init(value: Binding<Double?>,
//             isResponder: Binding<Bool>?,
//             alwaysShowFractions: Bool,
//             numberOfDecimalPlaces: Int,
//             currencySymbol: String?,
//             onReturn: @escaping () -> Void = {},
//             onEditingChanged: @escaping (Bool) -> Void = { _ in }
//        ) {
//            print("coordinator init")
//            _value = value
//            internalValue = value.wrappedValue
//            self.isResponder = isResponder
//            self.alwaysShowFractions = alwaysShowFractions
//            self.numberOfDecimalPlaces = numberOfDecimalPlaces
//            self.currencySymbol = currencySymbol
//            self.onReturn = onReturn
//            self.onEditingChanged = onEditingChanged
//        }
//        
//        public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//            // get new value
//            let originalText = textField.text
//            let text = textField.text as NSString?
//            let newValue = text?.replacingCharacters(in: range, with: string)
//            let display = newValue?.currencyFormat(decimalPlaces: self.numberOfDecimalPlaces, currencySymbol: self.currencySymbol)
//            
//            // validate change
//            if !shouldAllowChange(oldValue: textField.text ?? "", newValue: newValue ?? "") {
//                return false
//            }
//            
//            // update binding variable
//            self.value = newValue?.double ?? 0
//            self.internalValue = value
//            
//            // don't move cursor if nothing changed (i.e. entered invalid values)
//            if textField.text == display && string.count > 0 {
//                return false
//            }
//            
//            // update textfield display
//            textField.text = display
//            
//            // calculate and update cursor position
//            // update cursor position
//            let beginningPosition = textField.beginningOfDocument
//            
//            var numberOfCharactersAfterCursor: Int
//            if string.count == 0 && originalText == display {
//                // if deleting and nothing changed, use lower bound of range
//                // to allow cursor to move backwards
//                numberOfCharactersAfterCursor = (originalText?.count ?? 0) - range.lowerBound
//            } else {
//                numberOfCharactersAfterCursor = (originalText?.count ?? 0) - range.upperBound
//            }
//            
//            let offset = (display?.count ?? 0) - numberOfCharactersAfterCursor
//            
//            let cursorLocation = textField.position(from: beginningPosition, offset: offset)
//            
//            if let cursorLoc = cursorLocation {
//                /**
//                  Shortly after new text is being pasted from the clipboard, UITextField receives a new value for its
//                  `selectedTextRange` property from the system. This new range is not consistent to the formatted text and
//                  calculated caret position most of the time, yet it's being assigned just after setCaretPosition call.
//                  
//                  To insure correct caret position is set, `selectedTextRange` is assigned asynchronously.
//                  (presumably after a vanishingly small delay)
//                  */
//                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
//                    textField.selectedTextRange = textField.textRange(from: cursorLoc, to: cursorLoc)
//                 }
//            }
//            
//            // prevent from going to didChange
//            // all changes to textfield already made
//            return false
//        }
//        
//        func shouldAllowChange(oldValue: String, newValue: String) -> Bool {
//            // return if already has decimal
//            if newValue.numberOfDecimalPoints > 1 {
//                return false
//            }
//            
//            // limits integers length
//            if newValue.integers.count > 9 {
//                return false
//            }
//            
//            // limits fractions length
//            if newValue.fractions?.count ?? 0 > self.numberOfDecimalPlaces {
//                return false
//            }
//            
//            return true
//        }
//        
//        public func textFieldDidBeginEditing(_ textField: UITextField) {
//            DispatchQueue.main.async {
//                self.isResponder?.wrappedValue = true
//            }
//        }
//        
//        public func textFieldDidEndEditing(_ textField: UITextField) {
//            textField.text = self.value?.currencyFormat(decimalPlaces: self.numberOfDecimalPlaces, forceShowDecimalPlaces: self.alwaysShowFractions, currencySymbol: self.currencySymbol)
//            DispatchQueue.main.async {
//                self.isResponder?.wrappedValue = false
//            }
//        }
//        
//        @objc func textFieldEditingDidBegin(_ textField: UITextField){
//            onEditingChanged(true)
//        }
//        @objc func textFieldEditingDidEnd(_ textField: UITextField){
//            onEditingChanged(false)
//        }
//        
//        public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//            if let nextField = textField.superview?.superview?.viewWithTag(textField.tag + 1) as? UITextField {
//                nextField.becomeFirstResponder()
//            } else {
//                textField.resignFirstResponder()
//            }
//            self.onReturn()
//            return true
//        }
//    }
//}
