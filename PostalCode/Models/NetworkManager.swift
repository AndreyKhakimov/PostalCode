//
//  NetworkManager.swift
//  PostalCode
//
//  Created by Andrey Khakimov on 28.11.2021.
//

import Foundation

class NetworkManager {
    
    var onCompletion: ((CurrentPlace) -> Void)?
    
    func fetchData(for zipCode: String) {
        let url = "https://api.zippopotam.us/us/\(zipCode)"
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            if let currentPlace = self.parseJSON(withData: data) {
                self.onCompletion?(currentPlace)
            }
            print(response)
        }.resume()
    }
    
    func parseJSON(withData data: Data) -> CurrentPlace? {
        do {
            let currentPlaceData = try JSONDecoder().decode(Place.self, from: data)
            guard let currentPlace = CurrentPlace(currentPlace: currentPlaceData) else {
                return nil
            }
            print(currentPlace)
            return currentPlace
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
    
}
