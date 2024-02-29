//
//  WebServiceAPI.swift
//  KingBurguer
//
//  Created by Leandro Paranhos on 29/02/24.
//

import Foundation

//Padrão SINGLETON
class WebServiceAPI {
    // Inicia a clase
    static let shared = WebServiceAPI()
    
    func createUser() {
        let endpoint = "https://hades.tiagoaguiar.co/kingburguer"
        guard let url = URL(string: endpoint) else {
            print("ERROR: URL \(endpoint) malformed!")
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            print("Response is \(String(describing: response))")
            print("--------------------------------\n\n")
            
            if let error = error {
                print("Error: to call \(endpoint)")
                print(error)
                return
            }
            
            guard let data = data else {
                print("No data found \(endpoint)")
                return
            }
            
            if let d = String(data: data, encoding: .utf8) {
                print("Data is \(d)")
                return
            }
            
        }
        
        task.resume()
    }
}
