//
//  WebServiceAPI.swift
//  KingBurguer
//
//  Created by Leandro Paranhos on 29/02/24.
//

import Foundation

//Padrão SINGLETON
class WebServiceAPI {
    
    static let apiKey = ""
    
    // Inicia a clase
    static let shared = WebServiceAPI()
    
    func createUser(request: SignUpRequest) {
        do {
            //converte o dictionary para json
            //let jsonRequest = try JSONSerialization.data(withJSONObject: json)
            let jsonRequest = try JSONEncoder().encode(request)
            let endpoint = "https://hades.tiagoaguiar.co/kingburguer/users"
            guard let url = URL(string: endpoint) else {
                print("ERROR: URL \(endpoint) malformed!")
                return
            }
            
            //configura minha request
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "accept")
            request.setValue(WebServiceAPI.apiKey, forHTTPHeaderField: "x-secret-key")
            request.httpBody = jsonRequest
            
            
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
        } catch {
            print(error)
            return
        }
    }
}
