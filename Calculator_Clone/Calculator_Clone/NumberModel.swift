//
//  NumberModel.swift
//  Calculator_Clone
//
//  Created by rbwo on 2022/05/29.
//

import Foundation

final class NumberModel: ObservableObject {
    @Published var visualData : String = "0"
    @Published var data : String = "0"
    @Published var subData : Int = 0
    
    func numberCheck(_ number: String) {
        
        if number == "0" {
            
        }
        
    }
    
}
