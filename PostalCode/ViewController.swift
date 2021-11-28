//
//  ViewController.swift
//  PostalCode
//
//  Created by Andrey Khakimov on 27.11.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var zipCodeTextfield: UITextField!
    
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let placeVC = segue.destination as? PlaceViewController else { return }
        placeVC.networkManager = networkManager
    }
    
    @IBAction func findPlaceButtonPressed(_ sender: Any) {
        networkManager.fetchData(for: zipCodeTextfield.text ?? "10005")
    }
    
}

