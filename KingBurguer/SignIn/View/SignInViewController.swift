//
//  SignInViewController.swift
//  KingBurguer
//
//  Created by Leandro Paranhos on 10/01/24.
//

import Foundation
import UIKit


class SignInViewController: UIViewController {
    
    let scroll: UIScrollView = {
        let sc = UIScrollView()
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    let container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    //Declara e inicializa a variavel
    lazy var email: TextField = {
        let ed = TextField()
        ed.placeholder = "Entre com seu e-mail"
        ed.returnKeyType = .next
        ed.error = "E-mail inválido"
        //Forma tradicional
        //ed.failure = validation
        //Forma encurtada
        ed.failure = {
            return !ed.text.isEmail()
        }
        //delega os eventos para essa viewController
        ed.delegate = self
        ed.keyboardType = .emailAddress
        ed.bitMask = 1
        return ed
    }()
    
    //Forma tradicional
//    func validation() -> Bool {
//        return email.text.count <= 3
//    }
    
    lazy var password: TextField = {
        let ed = TextField()
        ed.placeholder = "Entre com sua senha"
        ed.returnKeyType = .done
        ed.secureTextEntry = true
        ed.error = "Senha deve ter no minimo 8 caracteres"
        ed.failure = {
            return ed.text.count < 8
        }
        ed.delegate = self
        ed.bitMask = 2
        return ed
    }()
    //Lazy var inicializa o objeto quando invocamos ele
    //Precisamos usar a lazy, pois ao passar o self (SignViewController) a mesma ainda não foi criada
    // Antes o send era criado e depois e a ViewController, com a lazy é o inverso
    lazy var send: LoadingButton = {
        let btn = LoadingButton()
        btn.title = "Entrar"
        btn.titleColor = .white
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(sendDidTap))
        return btn
    }()
    
    lazy var register: UIButton = {
        let btn = UIButton()
        btn.setTitle("Criar Conta", for: .normal)
        btn.setTitleColor(.label, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(registerDidTap), for: .touchUpInside)
        
        return btn
    }()
    
    var viewModel : SignInViewModel? {
        didSet {
            //Delega as informações para a classe atual
            viewModel?.delegate = self
        }
    }
    
    var bitmaskResult = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        container.addSubview(email)
        container.addSubview(password)
        container.addSubview(send)
        container.addSubview(register)
        
        scroll.addSubview(container)
        view.addSubview(scroll)
        
        navigationItem.title = "Login"
        
        let scrollContraints = [
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.topAnchor.constraint(equalTo: view.topAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        
        let containerCosntraints = [
            container.widthAnchor.constraint(equalTo: view.widthAnchor),
            container.topAnchor.constraint(equalTo: scroll.topAnchor),
            container.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            container.heightAnchor.constraint(equalToConstant: 490)
        ]
        
        let emailConstraints = [
            // 1. coordenadas da esquerda
            email.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            // 2. coordenadas da direita
            email.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            // 3. coordenadas do centro Y
            email.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: -150.0)
        ]
        
        
        let passwordConstraints = [
            password.leadingAnchor.constraint(equalTo: email.leadingAnchor),
            password.trailingAnchor.constraint(equalTo: email.trailingAnchor),
            password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 10),
        ]
        
        
        let sendConstraints = [
            send.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            send.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            send.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 10.0),
            send.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        let registerConstraints = [
            register.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            register.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            register.topAnchor.constraint(equalTo: send.bottomAnchor, constant: 10.0),
            register.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        NSLayoutConstraint.activate(scrollContraints)
        NSLayoutConstraint.activate(containerCosntraints)
        NSLayoutConstraint.activate(emailConstraints)
        NSLayoutConstraint.activate(passwordConstraints)
        NSLayoutConstraint.activate(sendConstraints)
        NSLayoutConstraint.activate(registerConstraints)

    }
    
    //Quando a view apareceu
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        //Escuta evento de touch
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(_ view: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    // estrutura padrão da função
    //ao passar o _ não precisamos passar o nome da variável
    @objc func sendDidTap(_ sender: UIButton) {
        viewModel?.send()
    }
    
    @objc func registerDidTap(_ sender: UIButton) {
        viewModel?.goToSignUp()
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
            send.startLoading(true)
            break
        case .goToHome:
            viewModel?.goToHome()
            break
        case .error(let msg):
            let alert = UIAlertController(title: "Titulo", message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true)
            break
        }
    }
}

extension SignInViewController: TextFieldDelegate {
    func textFieldDidChanged(isValid: Bool, bitmask: Int) {
        print("")
        if isValid  {
            // OR bit a bit
            self.bitmaskResult = self.bitmaskResult | bitmask
            print(self.bitmaskResult)
        }
        
        if (1 & self.bitmaskResult != 0)
            && (2 & self.bitmaskResult != 0) {
            print("Botão ativado")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField.returnKeyType == .done){
            view.endEditing(true)
            return false
        } else {
            password.gainFocus()
        }
        
        return false
    }
}
