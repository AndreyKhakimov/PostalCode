//
//  Place.swift
//  PostalCode
//
//  Created by Andrey Khakimov on 27.11.2021.
//

//// MARK: - Place
//struct Place: Decodable {
//    let postCode, country: String
//    let places: [PlaceElement]
//}
//
//// MARK: - PlaceElement
//struct PlaceElement: Decodable {
//    let placeName: String
//}

// MARK: - Place
struct Place: Codable {
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

//struct Place: Codable {
//    let country: String
//    let places: [PlaceElement]
//
//    enum CodingKeys: String, CodingKey {
//        case country
//        case places
//    }
//}
//
//// MARK: - PlaceElement
//struct PlaceElement: Codable {
//    let placeName: String
//
//    enum CodingKeys: String, CodingKey {
//        case placeName = "place name"
//    }
//}
