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
        WebServiceAPI.shared.createUser()
    }
    
    func goToHome() {
        coordinator?.home()
    }
    
}
