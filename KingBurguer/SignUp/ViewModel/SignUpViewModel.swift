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
    var name = ""
    var email = ""
    var password = ""
    var document = ""
    var birthday = ""
    
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
        
        // String -> Date
        let dtString = DateFormatter()
        dtString.locale = Locale(identifier: "en_US_POSIX")
        dtString.dateFormat = "dd/MM/yyyy"
        
        let date = dtString.date(from: birthday) ?? Date()
        
        //Date -> string
        let dtDate = DateFormatter()
        dtDate.locale = Locale(identifier: "en_US_POSIX")
        dtDate.dateFormat = "yyyy-MM-dd"
        let birthdayFormated = dtDate.string(from: date)
        
        let documentFormated = document.digits
        
        let request = SignUpRequest(name: name, email: email, password: password, document: documentFormated, birthday: birthdayFormated)
        
        WebServiceAPI.shared.createUser(request: request)
    }
    
    func goToHome() {
        coordinator?.home()
    }
    
}
