//
//  ZeroButtonView.swift
//  Calculator_Clone
//
//  Created by rbwo on 2022/05/29.
//

import SwiftUI

struct ZeroButtonView: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 80)
                .fill(Color("NumberColor"))
            HStack{
                Text("0")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                
                Spacer()
            }
           
        }
    }
}

struct ZeroButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ZeroButtonView()
    }
}
