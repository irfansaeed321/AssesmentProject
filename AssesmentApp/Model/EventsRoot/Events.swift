//
//  Events.swift
//  AssesmentApp
//
//  Created by Irfan Saeed on 26/10/2022.
//

import Foundation

struct Events : Codable {

    let artiste : String?
    let city : String?
    let date : String?
    let distanceFromValue : Float?
    let id : Int?
    let price : Int?
    let venueName : String?


    enum CodingKeys: String, CodingKey {
        case artiste = "artiste"
        case city = "city"
        case date = "date"
        case distanceFromValue = "distanceFromValue"
        case id = "id"
        case price = "price"
        case venueName = "venueName"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        artiste = try values.decodeIfPresent(String.self, forKey: .artiste)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        distanceFromValue = try values.decodeIfPresent(Float.self, forKey: .distanceFromValue)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        venueName = try values.decodeIfPresent(String.self, forKey: .venueName)
    }
}
