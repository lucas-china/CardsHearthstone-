//
//  CardDetailsModels.swift
//  CardsHearthstone
//
//  Created by Lucas Santana Brito on 21/07/23.
//

import Foundation

enum CardDetailsModels {
    enum Card {
        struct Request {}
        struct Response: Decodable {
            let cardId:String
            let name:String?
            let text:String?
            let flavor:String?
            let attack:Int?
            let cost:Int?
            let elite:Bool?
            let faction:String?
            let health:Int?
            let rarity:String?
            let set:String?
            let type:String?
            
        }
        struct ViewModel {
            let id: String
            let name: String?
            let text: String?
            let flavor: String?
            let attack: Int?
            let cost: Int?
            let elite: Bool?
            let faction: String?
            let health: Int?
            let rarity: String?
            let cardSet: String?
            let type: String?
            
            var imageURl: String {
                "https://art.hearthstonejson.com/v1/render/latest/ptBR/512x/\(id).png"
            }
        }
    }
}
