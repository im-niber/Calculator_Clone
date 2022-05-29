//
//  NumberModel.swift
//  Calculator_Clone
//
//  Created by rbwo on 2022/05/29.
//

import Foundation

final class NumberModel: ObservableObject {
    @Published var visualData: String = "1.23e10"
    @Published var firstNumber: Int?
    @Published var secondNumber: Int?
    
    var isZero : Bool {
        return visualData == "0" ? true : false
    }
    
    func numberCheck(_ number: String) {
        
        if number == "0" {
            
        }
        
    }
    
}
