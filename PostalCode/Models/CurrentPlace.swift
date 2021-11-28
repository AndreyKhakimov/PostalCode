//
//  CurrentPlace.swift
//  PostalCode
//
//  Created by Andrey Khakimov on 28.11.2021.
//

import Foundation

struct CurrentPlace {
    let state: String
    let stateAbbreviation: String
    let city: String
    
    init?(currentPlace: PlaceData) {
        state = currentPlace.places.first!.state
        stateAbbreviation = currentPlace.places.first!.stateAbbreviation
        city = currentPlace.places.first!.placeName
    }
}
