//
//  NumberButtonView.swift
//  Calculator_Clone
//
//  Created by rbwo on 2022/05/29.
//

import SwiftUI

struct NumberButtonView: View {
    @EnvironmentObject var numberData : NumberModel
    
    var moreOp = ["AC", "±", "%"]
    
    var body: some View {
        VStack(spacing: 25){
            HStack{
                ForEach(moreOp, id: \.self) { i in
                    Button {
                        i == "AC" ? numberData.deleteButton() : numberData.letterInsert(i)
                        
//                        i == "AC" ? numberData.deleteButton() : i == "±" ? numberData.plusMinusButton() : numberData.dividedHundred()
                        
                    } label: {
                        CircleButtonView(circleColor: "Gray", contentText: "\(i)", contentColor: .black)
                    }
                }
            }
            
            HStack{
                ForEach(7..<10) { i in
                    Button {
                        numberData.letterInsert("\(i)")
                    } label: {
                        CircleButtonView(circleColor: "NumberColor", contentText: "\(i)", contentColor: .white)
                    }
                }
            }
            HStack{
                ForEach(4..<7) { i in
                    Button {
                        numberData.letterInsert("\(i)")
                    } label: {
                        CircleButtonView(circleColor: "NumberColor", contentText: "\(i)", contentColor: .white)
                    }
                }
            }
            HStack{
                ForEach(1..<4) { i in
                    Button {
                        numberData.letterInsert("\(i)")
                    } label: {
                        CircleButtonView(circleColor: "NumberColor", contentText: "\(i)", contentColor: .white)
                    }
                }
            }
            
            GeometryReader { geo in
                HStack{
                    Button {
                        numberData.letterInsert("0")
                    } label: {
                        ZeroButtonView()
                    }
                    .frame(width: geo.size.width * 0.66)
                    Button {
                        numberData.letterInsert(".")
                    } label: {
                        CircleButtonView(circleColor: "NumberColor", contentText: ".", contentColor: .white)
                    }
                        
                }
            }
            
        }
    }
}



struct NumberButtonView_Previews: PreviewProvider {
    static var previews: some View {
        NumberButtonView()
            .environmentObject(NumberModel())
    }
}
