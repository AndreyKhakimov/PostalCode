//
//  NetworkManager.swift
//  PostalCode
//
//  Created by Andrey Khakimov on 28.11.2021.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let hostURL = "https://api.zippopotam.us"
    
    enum Endpoints {
        case zipCode(String)
        
        var url: URL {
            switch self {
                
            case .zipCode(let code):
                return URL(string: NetworkManager.hostURL + "/us/\(code)")!
            }
        }
        var httpMethod: String {
            switch self {
                
            case .zipCode(_):
                return "GET"
            }
        }
    }
    
    func sendRequest<Response: Decodable>(endpoint: Endpoints, completion: @escaping (Response?) -> Void) {
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = endpoint.httpMethod
        
        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let self = self,
                  let data = data
                   else {
                print(error?.localizedDescription ?? "No error description")
                completion(nil)
                return
            }
            if let currentPlace: Response = self.parseJSON(withData: data) {
                completion(currentPlace)
            } else {
                completion(nil)
            }
        }.resume()
    }
    
    func sendRequestAF(endpoint: Endpoints, completion: @escaping(Place?) -> Void) {
        AF.request(endpoint.url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    guard let placeInfo = value as? [String : Any] else { return }
                    let place = Place.getPlace(from: placeInfo)
                    completion(place)
                    print(place)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func parseJSON<Response: Decodable>(withData data: Data) -> Response? {
        do {
            let result = try JSONDecoder().decode(Response.self, from: data)
//            print(result)
            return result
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
    
}
