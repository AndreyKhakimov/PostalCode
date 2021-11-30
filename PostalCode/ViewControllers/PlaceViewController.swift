//
//  PlaceViewController.swift
//  PostalCode
//
//  Created by Andrey Khakimov on 27.11.2021.
//

import UIKit

class PlaceViewController: UIViewController {
    
    @IBOutlet var stateLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    let networkManager = NetworkManager()
    var zipCode: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        networkManager.sendRequest(endpoint: .zipCode(zipCode)) { [weak self] (placeData: Place?) in
            guard let self = self, let placeData = placeData else { return }
            self.updateUIWith(place: placeData)
        }
    }
    
    private func updateUIWith(place: Place) {
        DispatchQueue.main.async {
            self.stateLabel.text = "State: \(place.state)\n\n\nState abbreviation: \(place.stateAbbreviation)"
            self.cityLabel.text = "City: \(place.city)"
            self.activityIndicator.stopAnimating()
        }
    }
    
}

