//
//  User.swift
//  PlaygroundCollection
//
//  Created by 吕博 on 2021/7/29.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let dota2Hero = try? newJSONDecoder().decode(Dota2Hero.self, from: jsonData)


//// MARK: - Dota2HeroElement
//struct Dota2HeroElement: Codable {
//    let id: Int
//    let name, localizedName: String
//    let primaryAttr: PrimaryAttr
//    let attackType: AttackType
//    let roles: [Role]
//    let legs: Int
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case localizedName = "localized_name"
//        case primaryAttr = "primary_attr"
//        case attackType = "attack_type"
//        case roles, legs
//    }
//}
//
//enum AttackType: String, Codable {
//    case melee = "Melee"
//    case ranged = "Ranged"
//}
//
//enum PrimaryAttr: String, Codable {
//    case agi = "agi"
//    case int = "int"
//    case str = "str"
//}
//
//enum Role: String, Codable {
//    case carry = "Carry"
//    case disabler = "Disabler"
//    case durable = "Durable"
//    case escape = "Escape"
//    case initiator = "Initiator"
//    case jungler = "Jungler"
//    case nuker = "Nuker"
//    case pusher = "Pusher"
//    case support = "Support"
//}
//
//typealias Dota2Hero = [Dota2HeroElement]
