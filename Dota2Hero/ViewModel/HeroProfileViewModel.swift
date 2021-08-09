//
//  UserProfileViewModel.swift
//  PlaygroundCollection
//
//  Created by 吕博 on 2021/7/29.
//

import Foundation
import Combine

// View Model
// 通过数据仓库获取数据
final class HeroProfileViewModel: ObservableObject {
    
    @Published var username = ""
  //  @Published var hero: Dota2Hero?
    @Published var heroState: Dota2HeroStat?
    
    @Published var heroComplete: Bool = false
    @Published var heroStateComplete: Bool = false
    
    @Published var dataReceiveComplete: Bool = false
    
    var cancellable = Set<AnyCancellable>()
    
    /// 初始化数据仓库
    private let repository: HeroRepositoryProtocol
    init(repository: HeroRepositoryProtocol = HeroRepository()) {
        self.repository = repository
    }
    
//    var heroDataPublisher: AnyPublisher<Bool, Never> {
//        Publishers.CombineLatest($heroComplete, $heroStateComplete)
//            .map {
//                print("[hero] heroComplete: " + $0.description)
//                print("[hero] heroStateComplete: " + $1.description)
//                return $0 && $1
//            }
//            .eraseToAnyPublisher()
//    }
    
    func onAppear(completion: @escaping (Bool) -> Void) {
        repository.fetchHeroState(id: 1) { result in
            switch result {
            case .success(let data):
                self.heroState = data.map { $0 }
                self.heroStateComplete = true
                completion(true)
            case .failure(let error):
                print("ViewModel error: " + error.localizedDescription)
                completion(false)
            }
        }
    }
}
