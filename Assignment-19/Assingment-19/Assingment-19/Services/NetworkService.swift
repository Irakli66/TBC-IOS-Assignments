//
//  NetworkService.swift
//  Assingment-19
//
//  Created by irakli kharshiladze on 30.10.24.
//

import Foundation

final class NetworkService {
    func fetchData<T: Decodable>(urlString: String, completion: @escaping ((T?, Error?) -> Void)) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            if let error {
                print(error)
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Wrong Response"]))
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                completion(nil, NSError())
                return
            }
            
            guard let data else { return }
            
            do {
                let responseData = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(responseData, nil)
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
