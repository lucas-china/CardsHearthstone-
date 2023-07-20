//
//  CardListModels.swift
//  CardsHearthstone
//
//  Created by Lucas Santana Brito on 20/07/23.
//

import Foundation

enum CardListModels {
    enum Cards {
        struct Request {}
        struct Response: Decodable {
            let id:String
            let name:String?
            let text:String?
            let flavor:String?
            let artist:String?
            let attack:Int?
            let cardClass:String?
            let collectible:Bool?
            let cost:Int?
            let elite:Bool?
            let faction:String?
            let health:Int?
            let rarity:String?
            let set:String?
            let type:String?
            let mechanics: [String]?
        }
        struct ViewModel {
            let id:String
            let name:String?
        }
    }
}
