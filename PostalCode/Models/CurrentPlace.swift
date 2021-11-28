//
//  CurrentPlace.swift
//  PostalCode
//
//  Created by Andrey Khakimov on 28.11.2021.
//

import Foundation

struct CurrentPlace {
    let state: String
    let city: String
    
    init?(currentPlace: Place) {
        state = currentPlace.places.first!.state
        city = currentPlace.places.first!.placeName
    }
}
