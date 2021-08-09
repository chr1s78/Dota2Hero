//
//  UserRepository.swift
//  PlaygroundCollection
//
//  Created by 吕博 on 2021/7/29.
//

import Foundation

protocol HeroRepositoryProtocol {
 //   func fetchHero(id: Int, completion: @escaping (Result<Dota2Hero, Error>) -> Void)
    func fetchHeroState(id: Int, completion: @escaping (Result<Dota2HeroStat, Error>) -> Void)
}

/// 数据仓库
/// ```
/// 调用方 : ViewModel
/// 调用   : UserApiService
/// ````
final class HeroRepository: HeroRepositoryProtocol {

    /// 初始化数据服务
    private let apiService: NetWorkServiceProtocol
    init(apiService: NetWorkServiceProtocol = NetworkService()) {
        self.apiService = apiService
    }
    
    /// 获取英雄信息
//    func fetchHero(id: Int = 1, completion: @escaping (Result<Dota2Hero, Error>) -> Void) {
//        /// 调用数据服务获取数据
//        apiService.fetchDota2Hero(id: id, completion: completion)
//    }
    
    /// 获取英雄状态信息
    func fetchHeroState(id: Int, completion: @escaping (Result<Dota2HeroStat, Error>) -> Void) {
        /// 调用数据服务获取数据
        apiService.fetchDota2HeroState(id: id, completion: completion)
    }
    
}
