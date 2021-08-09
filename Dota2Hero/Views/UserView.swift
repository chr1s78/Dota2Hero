//
//  UserVIew.swift
//  PlaygroundCollection
//
//  Created by 吕博 on 2021/7/29.
//

import SwiftUI

/// 视图
struct UserView: View {
   
    @StateObject private var viewModel = HeroProfileViewModel()

    var body: some View {
        Text("!")
    }
}

struct UserVIew_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
