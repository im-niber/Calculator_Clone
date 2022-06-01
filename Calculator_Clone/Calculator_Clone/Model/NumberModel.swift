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
    
    // 내부에서 계산할 때 사용하는 좌항 우항 숫자
    var temp1: Double?
    var temp2: Double?
    
    // AC, C 버튼 on/off
    @Published var isCbuttonAcitve: Bool = false
    // 연산기능을 실행했는지 체크
    var isOp: Bool = false
    
    // 연산자 버튼 체크
    var activeOpButton: Bool = false
    
    var isOps : [String : Bool] = ["+" : false, "-" : false, "×" : false, "÷" : false, "=" : false]
    
    // 소수점 관련 중복입력 방지, 0. 소수점 뒤 숫자가 없어도 입력 가능하게 하는 조건 체크
    var isDot: Bool = false
    var isLastDot = false
    var isDeleteDot: Bool = false
    
    // 퍼센트 연산이 있는지 확인
    var isPercent: Bool = false
    
    // 999,999,999 는 1e9로 표시되는 것을 방지하기 위함 아래도 마찬가지
    let billionNumber = 1000000000.0
    let minNumber = 0.00000001
    
    // 숫자는 총 9개만 입력이 가능하므로 밑의 카운트로 체크
    var insertNumCount = 0
    
    // 숫자 버튼 기능, 소수점 기호, 퍼센트 기호 포함 !
    func letterInsert(_ input: String) {
        if input == "0" {
            if !isDeleteDot && !isPercent {
                if visualData != "0" && insertNumCount < 9 {
                    visualData += input
                    insertNumCount += 1
                }
                else if visualData.contains(".") && Double(visualData)! == 0 && insertNumCount < 9 {
                    visualData += input
                    insertNumCount += 1
                }
            }
            else {
                deleteButton()
                isCbuttonAcitve = true
            }
            isLastDot = false
        }
        else if input == "%"{
            if visualData != "0"{
                if currentNumber == 0 {
                    deleteButton()
                } else {
                    visualData = String(Double(visualData)! / 100)
                }
                
                isPercent = true
            }
        }
        else if input == "." {
            if isDeleteDot || isPercent {
                deleteButton()
                visualData += "."
                insertNumCount += 1
                
                isDot = true
                isCbuttonAcitve = true
                isDeleteDot = false
                isLastDot = true
                isPercent = false
                
            } else if insertNumCount < 9 && !visualData.contains(".") {
                if insertNumCount == 0 {
                    insertNumCount += 1
                }
                visualData += "."
                
                isLastDot = true
                isDot = true
                isCbuttonAcitve = true
            }
        }
        else if input == "±" {
            if visualData[visualData.startIndex] == "-" {
                visualData.removeFirst()
                visualData.insert("+", at: visualData.startIndex)
            } else{
                if visualData[visualData.startIndex] == "+" {
                    visualData.removeFirst()
                }
                visualData.insert("-", at: visualData.startIndex)
            }
        }
        
        else {
            if visualData == "0" && insertNumCount < 9 && !isPercent{
                visualData = ""
                visualData += input
                insertNumCount += 1
                isCbuttonAcitve = true
                activeOpButton = false
                if isOp == true {
                    
                        
                }
                // isOp = false
            }
            else if !isDeleteDot && !isPercent {
                if visualData.contains(".") && insertNumCount < 9{
                    visualData += input
                    insertNumCount += 1
                }
                else if insertNumCount < 9 {
                    visualData += input
                    insertNumCount += 1
                }
            }
            else if isDeleteDot || isPercent {
                deleteButton()
                visualData += input
                insertNumCount += 1
                isCbuttonAcitve = true
                isPercent = false
            }
            isLastDot = false
            
        }
        
        insertTempNumber()
//
//        print(visualData)
//        print(currentNumber)
//        print(insertNumCount)
    }
    
    // 너무 크거나 작은 숫자 변환
    // 숫자 문자형으로 변환
    func changeNumber(_ num: Double?) -> String {
        if Double(visualData)! == 0 {
            if visualData.count > 2 && visualData.count < 11 && !(visualData[visualData.startIndex] == "+") {
                return visualData
            }
        }
        if visualData[visualData.index(before: visualData.endIndex)] == "." {
            isLastDot = true
        }

        // 소수점 입력 취소 방지
//        if isDot {
//            let checkDotZero = String(num!)
//            if visualData[visualData.index(before: visualData.endIndex)] == "." {
//                isLastDot = true
//            }
//        }
        
        guard let temp = num else {
            return "0"
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        formatter.positiveFormat = "0.###E0"
        formatter.exponentSymbol = "e"
        
        if let scientificFormatted = formatter.string(for: temp) {
            let eSeperator = scientificFormatted.components(separatedBy: "e")
            let checkScientific = eSeperator[eSeperator.index(before: eSeperator.endIndex)]
            let doubleCheckScientific = Double(checkScientific)!
            
            if checkScientific == "0" {
                return decimalNumber(temp)
            } else if (doubleCheckScientific < 0 && doubleCheckScientific > -9) || temp == minNumber {
                return decimalNumber(temp)
            } else if doubleCheckScientific > 0 && temp < billionNumber {
                return decimalNumber(temp)
            } else {
                if isLastDot {
                    deleteButton()
                    isDot = true
                    visualData += "."
                    isLastDot = false
                    return "0."
                } else {
                    isDeleteDot = true
                    return scientificFormatted
                }
            }
        }
        
        return "오류"
    }
    
    func decimalNumber(_ temp: Double) -> String {
        let formatter2 = NumberFormatter()
        formatter2.numberStyle = .decimal
        formatter2.maximumFractionDigits = 8
        let result = formatter2.string(for: temp) ?? "0"
        
        if visualData.contains(".") {
            let pointSeperator = visualData.components(separatedBy: ".")
            let pointBackNumbers = pointSeperator[pointSeperator.index(before: pointSeperator.endIndex)]
            
            if result.contains(".") {
                let resultPointSeperator = result.components(separatedBy: ".")
                let resultBackNumbers = resultPointSeperator[resultPointSeperator.index(before: resultPointSeperator.endIndex)]
                
                print(pointBackNumbers)
                print(resultBackNumbers)
                
                // 숫자는 총 9개 작성 가능하니, 소수점 앞과 뒤를 구분해서
                // 앞의 숫자 몇개 사용한지 체크해서 적당한 값을 넣어주는 조건문
                if pointBackNumbers != resultBackNumbers {
                    let checkedNumberCount = resultPointSeperator[resultPointSeperator.startIndex].count
                    if pointBackNumbers.contains("e") {
                        return result
                    }
                    return resultPointSeperator[resultPointSeperator.startIndex] + "." + pointBackNumbers.prefix(insertNumCount - checkedNumberCount)
                }
                
            } else {
                if isLastDot {
                    isLastDot = false
                    return result + "."
                } else {
                    return result + "." + pointBackNumbers
                }
            }
            
        }
        return result
    }
    
    // 현재 숫자입력된 내용을 지우는 함수
    // 관련된 체크 변수들도 다 초기화
    func deleteButton() {
        if activeOpButton == true && currentNumber == 0.0 {
            activeOpButton = false
        }
        else if isCbuttonAcitve {
            temp2 = nil
            currentNumber = 0.0
            insertNumCount = 0
            visualData = "0"
            isDot = false
            isDeleteDot = false
            activeOpButton.toggle()
            isCbuttonAcitve = false
        }
        else {
            temp1 = nil
            currentNumber = 0.0
            insertNumCount = 0
            visualData = "0"
            isDot = false
            isDeleteDot = false
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
    
    // 연산 기호 함수, e.g. 1 + 1 입력 후, 다시 + 를 입력하면 2가 되고, 다시 두번째 숫자를 받을 준비하는 기능
    // 버튼 색도 조건에 맞게 변하는 기능이 있는 함수
    func opButtonActive(_ input: String) {
        switch input {
        case "+":
            if let isActive = isOps["+"], let _ = temp2 {
                if isActive == true {
                    doAnswer("+")
                }
            } else if isOp == false {
                isOps["+"] = true
                insertTempNumber()
                isOp = true
                activeOpButton = true
            }
        case "-":
            print("hi")
        case "×":
            print("hi")
        case "÷":
            print("hi")
        case "=":
            for (key, value) in isOps {
                if value == true {
                    doAnswer(key)
                    break
                }
            }
        default:
            print("오류")
        }
    }
    
    // 계산과, 할당, temp2 초기화 함수
    func calc(_ input: String, l: Double, r: Double) {
        switch input {
        case "+":
            currentNumber = l + r
            temp1 = currentNumber
            temp2 = nil
        case "-":
            currentNumber = l - r
            temp1 = currentNumber
            temp2 = nil
        case "×":
            currentNumber = l * r
            temp1 = currentNumber
            temp2 = nil
        case "÷":
            if temp2 != 0 {
                currentNumber = l / r
                temp1 = currentNumber
                temp2 = nil
            } else {
                print("오류")
            }
        default:
            print("오류")
        }
    }
    
    // 답을 내는 함수
    func doAnswer(_ input: String) {
        if let _ = temp2 {
            print("nonOptional temp2")
        } else {
            temp2 = currentNumber
        }
        
        if let isActive = isOps[input] {
            if isActive {
                calc(input, l: temp1!, r: temp2!)
            }
        }
    }
}
