//
//  ViewController.swift
//  PostalCode
//
//  Created by Andrey Khakimov on 27.11.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var zipCodeTextfield: UITextField!
    
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let placeVC = segue.destination as? PlaceViewController else { return }
        placeVC.networkManager = networkManager
    }
    
    @IBAction func findPlaceButtonPressed(_ sender: Any?) {
        guard let inputZipCode = zipCodeTextfield.text, !inputZipCode.isEmpty else {
            showAlert(with: "Text field is empty", and: "Plese, enter US Zip code")
            return
        }
        
        guard let zipCode = Int(inputZipCode), zipCode > 209 && zipCode < 99951 else {
            showAlert(with: "This is not a Zip code", and: "Plese, enter US Zip code")
            return
        }
        networkManager.fetchData(for: zipCodeTextfield.text ?? "10005")
    }
    
}

extension MainViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        findPlaceButtonPressed(nil)
        performSegue(withIdentifier: "showPlace", sender: nil)
        return true
    }
    
}

extension MainViewController {
    private func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
