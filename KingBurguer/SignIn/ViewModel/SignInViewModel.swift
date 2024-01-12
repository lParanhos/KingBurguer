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
    func viewModelDidChange(viewMode: SignInViewModel)
}

class SignInViewModel {
    
    var delegate: SignInViewModeDelegate?
    
    var state: Bool = false {
        //dispara o bloco quando a variável é alterada
        didSet {
            delegate?.viewModelDidChange(viewMode: self)
        }
    }
    
    
    func send() {
        state = true
    }
}
