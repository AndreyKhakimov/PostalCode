//
//  Place.swift
//  PostalCode
//
//  Created by Andrey Khakimov on 27.11.2021.
//

// MARK: - Place
struct PlaceData: Codable {
    let postCode, country, countryAbbreviation: String
    let places: [PlaceElement]

    enum CodingKeys: String, CodingKey {
        case postCode = "post code"
        case country
        case countryAbbreviation = "country abbreviation"
        case places
    }
}

// MARK: - PlaceElement
struct PlaceElement: Codable {
    let placeName, longitude, state, stateAbbreviation: String
    let latitude: String

    enum CodingKeys: String, CodingKey {
        case placeName = "place name"
        case longitude, state
        case stateAbbreviation = "state abbreviation"
        case latitude
    }
}

