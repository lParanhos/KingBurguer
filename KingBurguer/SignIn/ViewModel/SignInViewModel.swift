//
//  SignInViewModel.swift
//  KingBurguer
//
//  Created by Leandro Paranhos on 12/01/24.
//

import Foundation

//Uma forma de declarar uma assinatura, para que sempre que precisar notificar,
// chamar essa assinatura, notifica quem a está utilizando

protocol SignInViewModeDelegate {
    func viewModelDidChange(state: SignInState)
}

class SignInViewModel {
    
    var delegate: SignInViewModeDelegate?
    var coordinator: SignInCoordinator?
    
    var state: SignInState = .none {
        //dispara o bloco quando a variável é alterada
        didSet {
            //notifica quem está utilizando esse delegate, com o valor atualizado
            delegate?.viewModelDidChange(state: state)
        }
    }
    
    func send() {
        state = .loading
        
        //Timer de 2 segundos
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.state = .goToHome
        }
    }
    
    func goToSignUp() {
        coordinator?.signUp()
    }
    
    func goToHome() {
        coordinator?.home()
    }
}

