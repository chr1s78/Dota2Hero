//
//  ContentView.swift
//  Dota2Hero
//
//  Created by Chr1s on 2021/8/8.
//

import SwiftUI
import Lottie

struct ContentView: View {
    
    @EnvironmentObject var heroVM: HeroProfileViewModel
    @State var isChoose: Bool = false
    @State var chooseIndex: Int = 0
    
    var body: some View {
        ZStack {
            LottieView(filename: "magic")
                .background(
                    Image("homebackground")
                        .resizable()
                        .opacity(0.8)
                        .blur(radius: /*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                )
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false) {
                
                ScrollViewReader { proxy in
                    
                    if let data = heroVM.heroState {
                        
                        // 使用LazyVStack 在放大时会有显示问题
                        LazyVStack(alignment: .center, spacing: -60) {
                            
                            ForEach(data) { hero in
                                
                                SingleHeroView(chooseIndex: $chooseIndex, stateData: hero)
                                    .id(hero.id)
                                    .onTapGesture {
                                        withAnimation(.spring()) {
                                            self.chooseIndex = ( self.chooseIndex == hero.id ? 0 : hero.id )
                                            proxy.scrollTo(hero.id, anchor: .center)
                                            
                                        }
                                    }
                            }
                        }
                        .frame(width: 300)
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width/3)
            .offset(x: 30)
            .edgesIgnoringSafeArea(.all)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
