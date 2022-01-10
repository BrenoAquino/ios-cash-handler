//
//  Localizable.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import Foundation

enum Localizable {
    
    enum Common {
        static let cancel: String = "Cancelar"
    }
    
    enum Home {
        static let userTitle: String = "Breno Aquino"
        static let companyTitle: String = "Charles Inc."
        static let userInitials: String = "BA"
        
        static let operationOptionsTitle: String = "Tipo de operação a ser adicionada"
        static let cashInOption: String = "Cash In"
        static let cashOutOption: String = "Cash Out"
    }
    
    enum OperationForm {
        static let operationFormTitle: String = "Operação"
        
        static let operationTitle: String = "Nome da Operação"
        static let operationPlaceholder: String = "Nome da origem, produto ou serviço"
        
        static let dateTitle: String = "Data"
        static let datePlaceholder: String = "DD/MM/YYYY"
        
        static let valueTitle: String = "Valor"
        static let valuePlaceholder: String = "R$ 0.000,00"
        
        static let categoryTitle: String = "Categoria"
        static let categoryPlaceholder: String = "Ex: Refeição"
        
        static let paymentTypeTitle: String = "Meio de Pagamento"
        static let paymentPlaceholder: String = "Ex: Cartão de Crédito"
        
        static let buttonTitle: String = "Adicionar"
    }
}
