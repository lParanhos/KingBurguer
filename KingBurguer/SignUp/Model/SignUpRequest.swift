//
//  SignUpRequest.swift
//  KingBurguer
//
//  Created by Leandro Paranhos on 04/03/24.
//

import Foundation

struct SignUpRequest: Encodable {
    var name: String
    var email: String
    var password: String
    var document: String
    var birthday: String
    
    //utilizamos esse padrão para fazer um "de para" entre as propridades dentro do nosso app, para o que é esperado no servidor
    enum CodingKeys: String, CodingKey {
        case name = "name" // exemplo de alteração de nome da "chave"
        case email
        case password
        case document
        case birthday
    }
}
