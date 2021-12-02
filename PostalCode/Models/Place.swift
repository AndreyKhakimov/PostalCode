//
//  Place.swift
//  PostalCode
//
//  Created by Andrey Khakimov on 27.11.2021.
//

// MARK: - Place
struct Place: Decodable {
    let state: String
    let stateAbbreviation: String
    let city: String

    enum CodingKeys: String, CodingKey {
        case postCode = "post code"
        case country
        case countryAbbreviation = "country abbreviation"
        case places
    }
    
    enum ElementCodingKeys: String, CodingKey {
        case placeName = "place name"
        case longitude, state
        case stateAbbreviation = "state abbreviation"
        case latitude
    }
    
    init(placeInfo: [String : Any]) {
        let placeDictionary = placeInfo["places"] as? [Any]
        let currentPlaceElement = placeDictionary?.first as? [String : Any]
        self.state = currentPlaceElement?["state"] as? String ?? ""
        self.stateAbbreviation = currentPlaceElement?["state abbreviation"] as? String ?? ""
        self.city = currentPlaceElement?["place name"] as? String ?? ""
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var elements = try container.nestedUnkeyedContainer(forKey: .places)
        let firstElement = try elements.nestedContainer(keyedBy: ElementCodingKeys.self)
        let state = try firstElement.decode(String.self, forKey: .state)
        let stateAbbreviation = try firstElement.decode(String.self, forKey: .stateAbbreviation)
        let city = try firstElement.decode(String.self, forKey: .placeName)
        self.state = state
        self.stateAbbreviation = stateAbbreviation
        self.city = city
    }
    
}
