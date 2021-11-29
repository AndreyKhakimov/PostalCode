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
    
    var networkManager: NetworkManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
//        networkManager.onCompletion  = { currentPlace in
//            self.updateUIWith(place: currentPlace)
//        }
    }
    
    private func updateUIWith(place: PlaceData) {
        DispatchQueue.main.async {
            self.stateLabel.text = "State: \(place.state)\n\n\nState abbreviation: \(place.stateAbbreviation)"
            self.cityLabel.text = "City: \(place.city)"
            self.activityIndicator.stopAnimating()
        }
    }
    
}

