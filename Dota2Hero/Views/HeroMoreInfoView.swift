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
   
    var body: some View {
        ZStack {
            BlurBackgroundView()
           
            if let data = heroVM.heroState {
                VStack {
                    ZStack {
                        WebImage(url: URL(string: "https://steamcdn-a.akamaihd.net" + data[chooseIndex-1].img))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width)
                        
                        DismissButton()
                    }
                    
                    ScrollView {
                        DurationChartView()
                        
                        ZStack {
                            
                            Color.black.opacity(0.4)
                                .frame(width: UIScreen.main.bounds.width - 30)
                                .cornerRadius(12)
                                .padding(.top, 20)
                            
                            VStack {
                                Group {
                                    PickWinLineChartView(index: 1, pick: data[chooseIndex-1].the1_Pick, win: data[chooseIndex-1].the1_Win)
                                    .padding(.top, 30)
                                    PickWinLineChartView(index: 2, pick: data[chooseIndex-1].the2_Pick, win: data[chooseIndex-1].the2_Win)
                                        .padding(.top, 5)
                                    PickWinLineChartView(index: 3, pick: data[chooseIndex-1].the3_Pick, win: data[chooseIndex-1].the3_Win)
                                        .padding(.top, 5)
                                    PickWinLineChartView(index: 4, pick: data[chooseIndex-1].the4_Pick, win: data[chooseIndex-1].the4_Win)
                                        .padding(.top, 5)
                                    PickWinLineChartView(index: 5, pick: data[chooseIndex-1].the5_Pick, win: data[chooseIndex-1].the5_Win)
                                        .padding(.top, 5)
                                    PickWinLineChartView(index: 6, pick: data[chooseIndex-1].the6_Pick, win: data[chooseIndex-1].the6_Win)
                                        .padding(.top, 5)
                                    PickWinLineChartView(index: 7, pick: data[chooseIndex-1].the7_Pick, win: data[chooseIndex-1].the7_Win)
                                        .padding(.top, 5)
                                    PickWinLineChartView(index: 8, pick: data[chooseIndex-1].the8_Pick, win: data[chooseIndex-1].the8_Win)
                                        .padding(.top, 5)
                                        .padding(.bottom, 10)
                                }
                            }
                        }

                        Spacer()
                    }
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
    
    var limit: DataPoint?
    var points: [DataPoint]?
    init() {
        let highIntensity = Legend(color: .yellow, label: ">60min")
        let buildFitness = Legend(color: .blue, label: "30-60min")
        let fatBurning = Legend(color: .green, label: "<30min")

        points = [
            .init(value: 70, label: "1", legend: fatBurning),
            .init(value: 90, label: "2", legend: fatBurning),
            .init(value: 91, label: "3", legend: fatBurning),
            .init(value: 92, label: "4", legend: fatBurning),
            .init(value: 130, label: "5", legend: fatBurning),
            .init(value: 124, label: "6", legend: fatBurning),
            .init(value: 135, label: "7", legend: fatBurning),
            .init(value: 133, label: "8", legend: fatBurning),
            .init(value: 136, label: "9", legend: fatBurning),
            .init(value: 138, label: "10", legend: fatBurning),
            .init(value: 150, label: "11", legend: buildFitness),
            .init(value: 151, label: "12", legend: buildFitness),
            .init(value: 150, label: "13", legend: buildFitness),
            .init(value: 136, label: "14", legend: buildFitness),
            .init(value: 135, label: "15", legend: buildFitness),
            .init(value: 130, label: "16", legend: buildFitness),
            .init(value: 130, label: "17", legend: buildFitness),
            .init(value: 150, label: "18", legend: buildFitness),
            .init(value: 151, label: "19", legend: buildFitness),
            .init(value: 150, label: "20", legend: buildFitness),
            .init(value: 160, label: "21", legend: highIntensity),
            .init(value: 159, label: "22", legend: highIntensity),
            .init(value: 161, label: "23", legend: highIntensity),
            .init(value: 158, label: "24", legend: highIntensity),
        ]
    }
    
    var body: some View {
        BarChartView(dataPoints: points!)//, limit: limit!)
            .frame(width: UIScreen.main.bounds.width - 20, height: 270)
            .font(.system(size: 12, weight: .thin))
            .offset(y: 30)
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
            .offset(y: 110)
            .padding()
    }
}
struct BlurBackgroundView: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9960784314, green: 0.8823529412, blue: 0.2509803922, alpha: 1)), Color(#colorLiteral(red: 0.9803921569, green: 0.4392156863, blue: 0.6039215686, alpha: 1))]),
            startPoint: .top,
            endPoint: .bottom)
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
