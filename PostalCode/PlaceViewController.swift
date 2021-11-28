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
    
    var networkManager: NetworkManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.onCompletion  = { currentPlace in
            self.updateUIWith(place: currentPlace)
        }
    }
    
    func updateUIWith(place: CurrentPlace) {
        DispatchQueue.main.async {
            self.stateLabel.text = "State: \(place.state)"
            self.cityLabel.text = "City: \(place.city)"
        }
    }
    
}

