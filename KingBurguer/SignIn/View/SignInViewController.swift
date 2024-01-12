//
//  SignInViewController.swift
//  KingBurguer
//
//  Created by Leandro Paranhos on 10/01/24.
//

import Foundation
import UIKit

class SignInViewController: UIViewController {
    
    //Declara e inicializa a variavel
    let email: UITextField = {
        let ed = UITextField()
        ed.backgroundColor = .blue
        ed.placeholder = "Entre com seu e-mail"
        //Necessário desabilitar sempre, para utilizar o auto layout
        ed.translatesAutoresizingMaskIntoConstraints = false
        
        return ed
    }()
    
    let password: UITextField = {
        let ed = UITextField()
        ed.backgroundColor = .red
        ed.placeholder = "Entre com sua senha"
        ed.translatesAutoresizingMaskIntoConstraints = false
        
        return ed
    }()
    //Lazy var inicializa o objeto quando invocamos ele
    //Precisamos usar a lazy, pois ao passar o self (SignViewController) a mesma ainda não foi criada
    // Antes o send era criado e depois e a ViewController, com a lazy é o inverso
    lazy var send: UIButton = {
        let btn = UIButton()
        btn.setTitle("Entrar", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .yellow
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        // Self é a classe que vai conter a função que será disparada
        // action: é a função a ser disparada, com o selector expomos nossa função para o objective-c
        // for: evento em que deve ser disparado
        btn.addTarget(self, action: #selector(sendDidTap), for: .touchUpInside)
        
        return btn
    }()
    
    var viewModel : SignInViewModel? {
        didSet {
            //Delega as informações para a classe atual
            viewModel?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        view.addSubview(email)
        view.addSubview(password)
        view.addSubview(send)
        
        let emailConstraints = [
            // 1. coordenadas da esquerda
            email.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            // 2. coordenadas da direita
            email.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // 3. coordenadas do centro Y
            email.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            // 4. tamanho fixo
            email.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        NSLayoutConstraint.activate(emailConstraints)
        
        let passwordConstraints = [
            password.leadingAnchor.constraint(equalTo: email.leadingAnchor),
            password.trailingAnchor.constraint(equalTo: email.trailingAnchor),
            password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 10),
            password.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        NSLayoutConstraint.activate(passwordConstraints)
        
        let sendConstraints = [
            send.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            send.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            send.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 10.0),
            send.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        NSLayoutConstraint.activate(sendConstraints)
        

    }
    // estrutura padrão da função
    //ao passar o _ não precisamos passar o nome da variável
    @objc func sendDidTap(_ sender: UIButton) {
        viewModel?.send()
    }
}

//Maneira para separar os observadores da classe
// Com essa estratégia deixamos a controller apenas com responsabilidades de layout
// e eventos de touch
extension SignInViewController: SignInViewModeDelegate {
    //observador
     func viewModelDidChange(state: SignInState) {
      switch(state) {
        case .none:
            break
         case .loading:
             break
         case .goToHome:
             break
         case .error(let msg):
             let alert = UIAlertController(title: "Titulo", message: msg, preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "Ok", style: .default))
             self.present(alert, animated: true)
             break
         }
    }
}
