//
//  SignUpViewModel.swift
//  KingBurguer
//
//  Created by Leandro Paranhos on 15/01/24.
//

import Foundation

protocol SignUpViewModeDelegate {
    func viewModelDidChange(state: SignUpState)
}

class SignUpViewModel {
    var name = "UserA"
    var email = "blahA@gmail.com"
    var password = "12345678"
    var document = "111.222.333.11"
    var birthday = "2020-10-19"
    
    var delegate: SignUpViewModeDelegate?
    var coordinator: SignUpCoordinator?
    
    var state: SignUpState = .none {
        //dispara o bloco quando a variável é alterada
        didSet {
            //notifica quem está utilizando esse delegate, com o valor atualizado
            delegate?.viewModelDidChange(state: state)
        }
    }
    
    
    func send() {
        state = .loading
        WebServiceAPI.shared.createUser(password: password, name: name, email: email, document: document, birthday: birthday)
    }
    
    func goToHome() {
        coordinator?.home()
    }
    
}
