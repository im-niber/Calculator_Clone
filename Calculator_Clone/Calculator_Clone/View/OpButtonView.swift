//
//  OpButtonView.swift
//  Calculator_Clone
//
//  Created by rbwo on 2022/05/29.
//

import SwiftUI

struct OpButtonView: View {
    @EnvironmentObject var numberData : NumberModel
    
    let opString = ["÷","×","-","+","="]
    
    var body: some View {
        VStack(spacing: 25){
            ForEach(opString, id: \.self) { i in
                Button {
                   // i == "=" ? numberData.doAnswer() : numberData.calc(i)
                    numberData.opButtonActive(i)
                } label: {
                    numberData.activeOpButton && numberData.isOps[i]! && i !=
                    "=" ? CircleButtonView(circleColor: "White", contentText: i, contentColor: .orange) : CircleButtonView(circleColor: "OpColor", contentText: i, contentColor: .white)

                }
            }
        }
    }
}

struct OpButtonView_Previews: PreviewProvider {
    static var previews: some View {
        OpButtonView()
            .environmentObject(NumberModel())
    }
}
