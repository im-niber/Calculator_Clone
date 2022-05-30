//
//  NumberModel.swift
//  Calculator_Clone
//
//  Created by rbwo on 2022/05/29.
//

import Foundation

final class NumberModel: ObservableObject {
    @Published var visualData: String = "0"
    
    @Published var currentNumber: Double = 0.0
    
    var temp1: Double = 0.0
    var temp2: Double = 0.0
    
    @Published var isOp: Bool = false
    @Published var isTwoCurrent: Bool = false
    
    var isDot: Bool = false
    
    let billionNumber = 1000000000.0
    let minNumber = 0.00000001
    
    var insertNumCount = 0
    
    // 숫자 버튼 기능, . , %  포함 !
    func letterInsert(_ input: String) {
        if input == "0" {
            if visualData != "0" && insertNumCount < 9 {
                insertNumCount += 1
                visualData += input
            }
        }
        else if input == "%"{
            if visualData != "0"{
                visualData = String(Double(visualData)! / 100)
            }
        }
        else if input == "." {
            if insertNumCount < 9 && !isDot {
                isDot = true
                visualData += "."
            }
        }
        else if input == "±" {
            
            if visualData[visualData.startIndex] == "-" {
                visualData.removeFirst()
            } else{
                visualData.insert("-", at: visualData.startIndex)
            }
        }
        
        else {
            if visualData == "0" && insertNumCount < 9 {
                visualData = ""
                visualData += input
                insertNumCount += 1
            }
            else if visualData.contains(".") && insertNumCount < 9{
                visualData += input
                insertNumCount += 1
            }
            else if insertNumCount < 9 {
                visualData += input
                insertNumCount += 1
            }
        }
        
        insertTempNumber()
        
        print("---visualData---")
        print(visualData)
        print("---currentNumber---")
        print(currentNumber)
        
    }
    
    // 너무 크거나 작은 숫자 변환
    // 숫자 문자형으로 변환
    func changeNumber(_ num: Double?) -> String {
        print("before change")
        
        if isDot {
            var checkDotZero = String(num!)
            print(checkDotZero)
            if checkDotZero[checkDotZero.index(before: checkDotZero.endIndex)] == "0" {
                checkDotZero.removeLast()
                return checkDotZero
            }
        }
        
        guard let temp = num else {
            return "0"
        }
        if temp != 0 && temp > 0 {
            if temp >= billionNumber || temp < minNumber  {
                let formatter = NumberFormatter()
                formatter.numberStyle = .scientific
                formatter.positiveFormat = "0.###E0"
                formatter.exponentSymbol = "e"
                
                if let scientificFormatted = formatter.string(for: temp) {
                    
                    print("scienetific")
                    print(scientificFormatted)
                    return scientificFormatted
                }
            }
        }
        
        
        let formatter2 = NumberFormatter()
        formatter2.numberStyle = .decimal
        formatter2.maximumFractionDigits = 8
        let result = formatter2.string(for: temp) ?? "0"
        
        //  guard let string = formatter2.string(for: num) else { return "오류"}
        
        return result
    }
    
    // 현재 숫자입력된 내용을 지우는 함수
    // 관련된 체크 변수들도 다 초기화 
    func deleteButton() {
        if isOp == false {
            temp1 = 0.0
            currentNumber = 0.0
            insertNumCount = 0
            visualData = "0"
            isDot = false
        }
        else if isTwoCurrent {
            temp2 = 0.0
            currentNumber = 0.0
            insertNumCount = 0
            isDot = false
        }
        else {
            isOp = false
            isDot = false
        }
    }
    
    // 내부에서 계산을 하기위해 저장하는 함수
    func insertTempNumber() {
        if isOp {
            currentNumber = Double(visualData)!
            temp2 = currentNumber
        }
        else {
            currentNumber = Double(visualData)!
            temp1 = currentNumber
        }
    }
}
