//
//  HeroMoreInfoView.swift
//  Dota2Hero
//
//  Created by Chr1s on 2021/8/9.
//

import SwiftUI
import SDWebImageSwiftUI
import SwiftUICharts

struct HeroMoreInfoView: View {
    
    @EnvironmentObject var heroVM: HeroProfileViewModel
    @Binding var showDetail: Bool
    @Binding var chooseIndex: Int
    
    /// 0810
    let imageNamespace: Namespace.ID
   
    var body: some View {
        ZStack {
            BlurBackgroundView()
           
            if let data = heroVM.heroState {
                ZStack {
                    VStack {
                        WebImage(url: URL(string: "https://steamcdn-a.akamaihd.net" + data[chooseIndex-1].img))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width)
                        
                        DurationChartView()
                            .padding(.top, 20)
                        
                        Spacer()
                    }
                    .edgesIgnoringSafeArea(.all)
                    
                    DismissButton()
                        .offset(y: -200)
                }
                .edgesIgnoringSafeArea(.all)
            }
            
        }
        .gesture(
            DragGesture().onChanged { value in
            
            }
            .onEnded { value in
                withAnimation(.spring()) {
                    self.showDetail.toggle()
                }
            }
        )
    }
}

struct PickWinLineChartView: View {
    
    var index: Int
    var pick: Int
    var win: Int
    var width: CGFloat {
        let value = 220.0 * CGFloat(win) / CGFloat(pick)
        print(value)
        print("win: \(win) , pick: \(pick)")
        return value
    }
    
    var body: some View {
        HStack {
            Text("\(index)选胜利/总场")
                .font(.footnote)
                .fontWeight(.thin)
            
            Spacer()
            
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 220, height: 5)
                    .foregroundColor(.gray)
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: width, height: 5)
                    .foregroundColor(.purple)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 40)
    }
}

struct DurationChartView: View {
    
    let chartStyle = ChartStyle(backgroundColor: Color.black, accentColor: Colors.OrangeStart, secondGradientColor: Colors.OrangeEnd,  textColor: Color.white, legendTextColor: Color.white, dropShadowColor: Color.clear )
    
    var body: some View {
        
        VStack {
            
            HStack {
                BarChartView(data: ChartData(points: [8,23,54,32,12,37,7,23,43]), title: "Pick", style: Styles.barChartStyleNeonBlueLight)
                BarChartView(data: ChartData(points: [8,23,54,32,12,37,7,23,43]), title: "Ban", style: Styles.barChartStyleNeonBlueDark)
            }
            
            HStack {
                BarChartView(data: ChartData(points: [8,23,54,32,12,37,7,23,43]), title: "Pick", style: Styles.barChartMidnightGreenDark)
                BarChartView(data: ChartData(points: [8,23,54,32,12,37,7,23,43]), title: "Ban", style: Styles.barChartStyleOrangeLight)
            }
            
        }
        .padding(.horizontal, 20)
    }
}

extension HeroMoreInfoView {
    
    func DismissButton() -> some View {
        HStack {
            Spacer()
            Button(action: {
                withAnimation(.spring()) {
                    self.showDetail.toggle()
                }
            }, label: {
                Image(systemName: "arrow.down.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .background(
                        Circle()
                            .foregroundColor(.orange)
                    )
                    .foregroundColor(.yellow)
                    .shadow(color: .gray, radius: 1, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 1)
            })
        }
        .padding()
    
    }
}
struct BlurBackgroundView: View {
    var body: some View {
//        LinearGradient(
//            gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9960784314, green: 0.8823529412, blue: 0.2509803922, alpha: 1)), Color(#colorLiteral(red: 0.9803921569, green: 0.4392156863, blue: 0.6039215686, alpha: 1))]),
//            startPoint: .top,
//            endPoint: .bottom)
//            .edgesIgnoringSafeArea(.all)
        LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3880284131, green: 0.4124510288, blue: 0.437040776, alpha: 1)), Color(#colorLiteral(red: 0.1382656693, green: 0.1513108313, blue: 0.153875649, alpha: 1))]), startPoint: .bottomTrailing, endPoint: .topLeading)
            .edgesIgnoringSafeArea(.all)

        GeometryReader { proxy in
            
            let size = proxy.size
            
            Circle()
                .fill(Color.purple)
                .padding(50)
                .blur(radius: 150)
                .offset(x: -size.width / 1.8, y: -size.height / 5)
            
            Circle()
                .fill(Color.blue)
                .padding(50)
                .blur(radius: 150)
                .offset(x: size.width / 1.8, y: -size.height / 2)
            
            Circle()
                .fill(Color.blue)
                .padding(50)
                .blur(radius: 120)
                .offset(x: size.width / 1.8, y: size.height / 2)
        }
    }
}
