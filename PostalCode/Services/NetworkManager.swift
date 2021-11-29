//
//  NetworkManager.swift
//  PostalCode
//
//  Created by Andrey Khakimov on 28.11.2021.
//

import Foundation

class NetworkManager {
    
    static let hostURL = "https://api.zippopotam.us"
    
    enum Endpoints {
        case zipCode(String)
        case coordinates(Double, Double)
        
        var url: URL {
            switch self {
            case .zipCode(let code):
                return URL(string: NetworkManager.hostURL + "/us/\(code)")!
                
            case .coordinates(let lat, let lng):
                return URL(string: NetworkManager.hostURL + "/us/coord?lat=\(lat)&lng=\(lng)")!
            }
        }
        
        var httpMethod: String {
            switch self {
            case .zipCode:
                return "GET"
                
            case .coordinates:
                return "POST"
            }
        }
    }
    
    func sendRequest<Response: Decodable>(endpoint: Endpoints, completion: @escaping (Response?) -> Void) {
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = endpoint.httpMethod
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self,
                  let data = data,
                  let response = response
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
            print(response)
        }.resume()
    }
    
    func parseJSON<Response: Decodable>(withData data: Data) -> Response? {
        do {
            let result = try JSONDecoder().decode(Response.self, from: data)
            print(result)
            return result
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
    
}
