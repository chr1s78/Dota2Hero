//
//  UserApiService.swift
//  PlaygroundCollection
//
//  Created by 吕博 on 2021/7/29.
//

import Foundation
import Alamofire
import Combine

/// 数据服务协议
protocol NetWorkServiceProtocol {
    // 获取Dota2 Hero
  //  func fetchDota2Hero(id: Int, completion: @escaping (Result<Dota2Hero, Error>) -> Void)
    // 获取Dota2 HeroStat
    func fetchDota2HeroState(id: Int, completion: @escaping (Result<Dota2HeroStat, Error>) -> Void)
}

/// 数据服务
/// ```
/// 调用网络请求获取数据
/// ```
final class NetworkService: NetWorkServiceProtocol {
  
    private var cancellable: Cancellable? = nil
    
    /// 获取Dota2英雄信息
    /// ```
    /// - https://api.opendota.com/api/heroes
    /// ```
//    func fetchDota2Hero(id: Int, completion: @escaping (Result<Dota2Hero, Error>) -> Void) {
//        cancellable =
//            AF.request("https://api.opendota.com/api/heroes", method: .get)
//            .validate(statusCode: 200..<300)
//            .publishDecodable(type: Dota2Hero.self)
//            .sink(receiveCompletion: { (completion) in
//                switch completion {
//                case .finished:
//                    #if DEBUG
//                    print("sink finished")
//                    #endif
//                case .failure(let error):
//                    #if DEBUG
//                    print("sink failure: " + error.localizedDescription)
//                    #endif
//                }
//            }, receiveValue: { (response) in
//                switch response.result {
//                case .success(let data):
//                    completion(.success(data))
//                case .failure(let error):
//                    #if DEBUG
//                        print(error.localizedDescription)
//                        print(String(describing: error))
//                    #endif
//                    completion(.failure(error))
//                }
//            })
//    }
    
    /// 获取Dota2英雄状态信息
    /// ```
    /// - https://api.opendota.com/api/heroStats
    /// ```
    func fetchDota2HeroState(id: Int, completion: @escaping (Result<Dota2HeroStat, Error>) -> Void) {
        cancellable =
            AF.request("https://api.opendota.com/api/heroStats", method: .get)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: Dota2HeroStat.self)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    #if DEBUG
                    print("sink finished")
                    #endif
                case .failure(let error):
                    #if DEBUG
                    print("sink failure: " + error.localizedDescription)
                    #endif
                }
            }, receiveValue: { (response) in
                switch response.result {
                case .success(let data):
                //    print(data)
                    completion(.success(data))
                case .failure(let error):
                    #if DEBUG
                        print(error.localizedDescription)
                        print(String(describing: error))
                    #endif
                    completion(.failure(error))
                }
            })
    }
    
}

extension NetworkService {
    
}
