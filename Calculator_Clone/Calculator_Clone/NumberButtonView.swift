//
//  NumberButtonView.swift
//  Calculator_Clone
//
//  Created by rbwo on 2022/05/29.
//

import SwiftUI
// ±
struct NumberButtonView: View {
    var moreOp = ["AC", "±", "%"]
    
    var body: some View {
        VStack(spacing: 25){
            HStack{
                ForEach(moreOp, id: \.self) { i in
                    Button {
                        print("op2")
                    } label: {
                        CircleButtonView(circleColor: "Gray", contentText: "\(i)", contentColor: .black)
                    }
                }
            }
            
            HStack{
                ForEach(7..<10) { i in
                    Button {
                        print("hi")
                    } label: {
                        CircleButtonView(circleColor: "NumberColor", contentText: "\(i)", contentColor: .white)
                    }
                }
            }
            HStack{
                ForEach(4..<7) { i in
                    Button {
                        print("hi")
                    } label: {
                        CircleButtonView(circleColor: "NumberColor", contentText: "\(i)", contentColor: .white)
                    }
                }
            }
            HStack{
                ForEach(1..<4) { i in
                    Button {
                        print("hi")
                    } label: {
                        CircleButtonView(circleColor: "NumberColor", contentText: "\(i)", contentColor: .white)
                    }
                }
            }
            
            GeometryReader { geo in
                HStack{
                    Button {
                        print("0")
                    } label: {
                        ZeroButtonView()
                    }
                    .frame(width: geo.size.width * 0.66)
                    Button {
                        print(".")
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
    }
}
