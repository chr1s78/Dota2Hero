//
//  HeroMoreInfoView.swift
//  Dota2Hero
//
//  Created by Chr1s on 2021/8/9.
//

import SwiftUI

struct HeroMoreInfoView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color.orange.edgesIgnoringSafeArea(.all)
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .gesture(
            DragGesture().onChanged { value in
            //    presentationMode.wrappedValue.dismiss()
            }
            .onEnded { value in
                withAnimation(.spring()) {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        )
    }
}

struct HeroMoreInfoView_Previews: PreviewProvider {
    static var previews: some View {
        HeroMoreInfoView()
    }
}
