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
        
        return ed
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        view.addSubview(email)
        view.addSubview(password)
        
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
        
        //Problemas ao usar FRAME
        // 1. tem que fazer muita matematica
        //2. não tem autolayout
        //email.frame = CGRect(x: 0, y: view.bounds.size.height / 2, width: view.bounds.size.width, height: 50)
        //password.frame = CGRect(x: 0, y: (view.bounds.size.height / 2) + 50, width: view.bounds.size.width, height: 50)
    }
}
