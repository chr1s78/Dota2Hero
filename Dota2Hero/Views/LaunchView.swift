//
//  LaunchView.swift
//  Dota2Hero
//
//  Created by Chr1s on 2021/8/8.
//

import SwiftUI
import Combine

struct LaunchView: View {
    
    /// 加载中的提示信息
    @State private var loadingText: [String] = "正在从OpenDota.com获取数据".map { String($0) }
    /// 加载中提示信息当前显示的字符序号
    @State var textShowIndex: Int = 0
    /// 提示信息循环显示次数，达到5次时表示网络超时
    @State var textLoop: Int = 0
    /// 网络异常时的错误信息
    @State var errorInfo: String = ""
    /// 是否显示重新请求按钮标志
    @State var requestAgain: Bool = false
    /// 是否显示主视图标志
    @State private var showMainView = false
    /// LaunchView的图标初始角度
    @State var angle:Double = 0
    
    @StateObject var heroVM = HeroProfileViewModel()
    @State var timer = Timer.publish(every: 0.1, on: .main, in: .common)
    @State var cancellable: Cancellable?
    
    var body: some View {
        Group {
            if showMainView || heroVM.dataReceiveComplete {
                ContentView().environmentObject(heroVM)
            } else {
                ZStack {
                    
                    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3880284131, green: 0.4124510288, blue: 0.437040776, alpha: 1)), Color(#colorLiteral(red: 0.1382656693, green: 0.1513108313, blue: 0.153875649, alpha: 1))]), startPoint: .bottomTrailing, endPoint: .topLeading)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(spacing: 50.0) {
                        Spacer()
                        Image("dota2")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .rotation3DEffect(.degrees(angle), axis: (x: 0, y: 1, z: 1))
                        
                        showMessage()
                        Spacer()
                        RequestView()
                    }
                }
            }
        }
        .onAppear { reload() }
        .onReceive(timer, perform: timerHandler())
    }
}

// MARK: View Extension
extension LaunchView {
    
    // 提示信息显示
    func showMessage() -> some View {
        Group {
            if errorInfo == "" {
                HStack(spacing: 0.0) {
                    ForEach(loadingText.indices) { i in
                        Text(loadingText[i])
                            .font(.title2)
                            .foregroundColor(.red)
                            .fontWeight(.bold)
                            .shadow(color: .black, radius: 1, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 1.0)
                            .offset(y: textShowIndex == i ? -5 : 0)
                    }
                }
            } else {
                HStack {
                    Image(systemName: "exclamationmark.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(.red)
                    Text(errorInfo)
                        .font(.title2)
                        .foregroundColor(.red)
                        .fontWeight(.bold)
                        .shadow(color: .black, radius: 1, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 1.0)
                }
            }
        }
    }
    
    // 重新请求按钮
    func RequestView() -> some View {
        Button(action: {
            requestAgain = false
            reload()
        }, label: {
            VStack {
                Image(systemName: "arrow.clockwise.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.6), radius: 1, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 1.0)
                
                Text("重新请求")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
        })
        .opacity(requestAgain ? 1.0 : 0.0)
    }
    
}

// MARK: Function Extension
extension LaunchView {
    // 重新请求方法
    func reload() {
        
        errorInfo = ""
        textLoop = 0
        angle = 0
        textShowIndex = 0
        
        timer = Timer.publish(every: 0.1, on: .main, in: .common)
        cancellable = timer.connect()
        
        heroVM.onAppear { result in
            requestAgain = !result
            if result {
                errorInfo = ""
                
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    withAnimation(.spring(response: 3.0, dampingFraction: 0.5, blendDuration: 0.2)) {
                        showMainView = true
                    }
                }
            } else {
                errorInfo = "数据获取失败，请检查网络连接"
                requestAgain = true
            }
        }

    }
    
    // 计时器处理方法
    func timerHandler() -> (Timer.TimerPublisher.Output) -> Void {
        return { _ in
        //    print("timer")
            withAnimation(.linear(duration: 5)) {
                angle += 10
            }

            if textShowIndex == loadingText.count - 1 {
                textLoop += 1
                textShowIndex = 0

                if textLoop == 2 {
                    cancellable?.cancel()
                    errorInfo = "数据获取超时，请检查网络连接"
                    requestAgain = true
                    withAnimation() {
                        angle = 360
                    }
                }
            } else {
                textShowIndex += 1
            }
        }
    }
    
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}

