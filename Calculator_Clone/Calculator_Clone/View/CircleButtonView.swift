//
//  CircleButtonView.swift
//  Calculator_Clone
//
//  Created by rbwo on 2022/05/29.
//

import SwiftUI

struct CircleButtonView: View {
    // CGcolor로 전달 하는 방법도 알아보자
    var circleColor: String
    var contentText: String
    var contentColor: Color?
    
    var body: some View {
        ZStack{
            Circle()
                .fill(Color("\(circleColor)"))
            Text("\(contentText)")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(contentColor)
        }
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonView(circleColor: "OpColor", contentText: "X", contentColor: .white)
    }
}
