//
//  ContentView.swift
//  Calculator_Clone
//
//  Created by rbwo on 2022/05/29.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var numberData : NumberModel
    
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
                .overlay {
                    GeometryReader{ geo in
                        VStack(alignment: .trailing){
                            Spacer()
                            Text(numberData.changeNumber(numberData.currentNumber))
                                .foregroundColor(.white)
                                .fontWeight(.light)
                                .modifier(FittingFontSizeModifier())
                            
                            HStack{
                                NumberButtonView()
                                    .frame(width: geo.size.width * 0.73, height: geo.size.height * 0.65)
                                
                                
                                OpButtonView()
                                    .frame(width: geo.size.width * 0.244, height: geo.size.height * 0.655)
                            }
                        }
                }
            }
        }
    }
}


struct FittingFontSizeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 100))
            .minimumScaleFactor(0.4)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(NumberModel())
    }
}
