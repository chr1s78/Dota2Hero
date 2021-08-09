//
//  SingleHeroView.swift
//  Dota2Hero
//
//  Created by Chr1s on 2021/8/9.
//

import SwiftUI
import SDWebImageSwiftUI

struct SingleHeroView: View {

    @Binding var chooseIndex: Int
    @Binding var showDetail: Bool
    @State var isPresented: Bool = false
    
    let namespace: Namespace.ID
    var stateData: Dota2HeroStatElement?
    
    var body: some View {
        
        if let data = stateData {
            
            VStack(spacing: 0) {
                
                /// hero image row
                WebImage(url: URL(string: "https://steamcdn-a.akamaihd.net" + data.img))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    
                /// hero info row
                if chooseIndex == data.id {
                    heroInfoView(data: data)
                }
                Spacer()
            }
           // .matchedGeometryEffect(id: "image", in: namespace)
            .frame(width: width,
                   height: height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(
                chooseIndex == data.id ?
                    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9960784314, green: 0.8823529412, blue: 0.2509803922, alpha: 1)), Color(#colorLiteral(red: 0.9803921569, green: 0.4392156863, blue: 0.6039215686, alpha: 1))]), startPoint: .bottomTrailing, endPoint: .topLeading)
                    : LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3880284131, green: 0.4124510288, blue: 0.437040776, alpha: 0)), Color(#colorLiteral(red: 0.3880284131, green: 0.4124510288, blue: 0.437040776, alpha: 0))]), startPoint: .bottomTrailing, endPoint: .topLeading)
            )
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .fixedSize(horizontal: false, vertical: true)
            .scaleEffect(0.9)
            .rotation3DEffect(
                Angle(degrees: degress),
                axis: (x: 1.0, y: -1.0, z: 0),
                anchor: .center,
                perspective: 1
            )
            .shadow(color: Color.black.opacity(0.8), radius: 2, x: 0, y: 1)
            .animation(.easeOut)
        }
    }
}


extension SingleHeroView {
     var width: CGFloat {
        guard let data = stateData else { return 0 }
        if chooseIndex == data.id {
            return 320
        } else {
            return 240
        }
    }
    
    var height: CGFloat {
        guard let data = stateData else { return 0 }
        if chooseIndex == data.id {
            return 560
        } else {
            return 140
        }
    }
    
    var degress: Double {
        guard let data = stateData else { return 0 }
        if chooseIndex == data.id {
            return -10
        } else {
            return 40
        }
    }
}

extension SingleHeroView {
    
    func heroInfoView(data: Dota2HeroStatElement) -> some View {
        
        VStack {
         
            heroInfoHeaderView(data: data)
            
            heroInfoBodyView(data: data)

        }
        .frame(maxWidth: .infinity)
    }
    
    func heroInfoHeaderView(data: Dota2HeroStatElement) -> some View {
        VStack(alignment: .center, spacing: 1) {
            HStack {
                Spacer()
                VStack(spacing: 1) {
                    Image("Strength_attribute")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                    Text("\(data.baseStr)" + "+" + "\(data.strGain)")
                        .font(.custom("Georgia", size: 14)).bold()
                        .foregroundColor(.white)
                }
                Spacer()
                VStack(spacing: 1) {
                    Image("Agility_attribute")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                    Text("\(data.baseAgi)" + "+" + "\(data.agiGain)")
                        .font(.custom("Georgia", size: 14)).bold()
                        .foregroundColor(.white)
                }
                Spacer()
                VStack(spacing: 1) {
                    Image("Intelligence_attribute")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                    Text("\(data.baseInt)" + "+" + "\(data.intGain)")
                        .font(.custom("Georgia", size: 14)).bold()
                        .foregroundColor(.white)
                }
                Spacer()
            }
            .padding(5)
            .background(
                attributeBackgroundView(type: data.primaryAttr)
            )
        }
    }
    
    func heroInfoBodyView(data: Dota2HeroStatElement) -> some View {
        VStack(alignment: .center, spacing: 1) {
            HStack(alignment: .center) {
                Text(data.localizedName)
                    .font(.title).bold()
                Text(data.attackType.rawValue)
                    .font(.subheadline)
                    .fontWeight(.thin)
                Text("\(data.attackRange)")
                    .font(.subheadline)
                    .fontWeight(.thin)
            }
            .padding(.horizontal, 10)
            HStack {
                ForEach(data.roles.indices) { i in
                    Text(data.roles[i].rawValue)
                        .font(.subheadline)
                        .fontWeight(.thin)
                }
            }
            .padding(.horizontal, 10)
            
            Divider().padding(10)
            let columns: [GridItem] = [
                GridItem(.flexible(), spacing: 0),
                GridItem(.flexible(), spacing: 0),
            ]
 
            LazyVGrid(columns: columns, spacing: 0) {
                
                Group {
                    Text("攻击频率")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.clear)
                    Text(String(format: "%.2f", data.attackRate))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.clear)
                    Text("弹道速度")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.gray.opacity(0.3))
                    Text("\(data.projectileSpeed)")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.gray.opacity(0.3))
                    
                    Text("初始HP")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.clear)
                    Text("\(data.baseHealth)")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.clear)
                    Text("HP成长率")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.gray.opacity(0.3))
                    Text(String(format: "%.2f", data.baseHealthRegen ?? 0))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.gray.opacity(0.3))
                    
                    Text("初始MP")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.clear)
                    Text("\(data.baseMana)")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.clear)
                }
                
                Group {
                    Text("MP成长率")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.gray.opacity(0.3))
                    Text(String(format: "%.2f", data.baseManaRegen ))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.gray.opacity(0.3))
                    Text("基础护甲")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.clear)
                    Text(String(format: "%.2f", data.baseArmor ))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.clear)
                    Text("最小攻击间隔")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.gray.opacity(0.3))
                    Text("\(data.baseAttackMin)")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.gray.opacity(0.3))
                    Text("最大攻击间隔")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.clear)
                    Text("\(data.baseAttackMax)")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.clear)
                    Text("移动速度")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.gray.opacity(0.3))
                    Text("\(data.moveSpeed)")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.gray.opacity(0.3))
                }

            }
            .font(.custom("Georgia", size: 12))
     
            Spacer()
            Button {
                withAnimation(.spring()) {
                    self.showDetail.toggle()
                }
            } label: {
                HStack {
                    Text("More Infomation ")
                    Image(systemName: "chevron.right.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                }
                .foregroundColor(.white)
            }
            .padding(.bottom, 10)
        }
        .frame(maxWidth: .infinity)
    }
}

struct attributeBackgroundView: View {
    var type: PrimaryAttr
    var body: some View {
        switch type {
        case .str:
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)), Color(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 0.4861057692))]), startPoint: .top, endPoint: .bottom)
        case .agi:
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 0.5103846154))]), startPoint: .top, endPoint: .bottom)
        case .int:
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)), Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))]), startPoint: .top, endPoint: .bottom)
        }
    }
}

//struct SingleHeroView_Previews: PreviewProvider {
//    static var previews: some View {
//        SingleHeroView(chooseIndex: .constant(1))
//    }
//}
