//
//  OpButtonView.swift
//  Calculator_Clone
//
//  Created by rbwo on 2022/05/29.
//

import SwiftUI

struct OpButtonView: View {
    var opString = ["÷","×","-","+","="]
    
    var body: some View {
        VStack(spacing: 25){
            ForEach(opString, id: \.self) { i in
                Button {
                    print("op")
                } label: {
                    CircleButtonView(circleColor: "OpColor", contentText: "\(i)", contentColor: .white)
                }
            }
        }
    }
}

struct OpButtonView_Previews: PreviewProvider {
    static var previews: some View {
        OpButtonView()
    }
}
