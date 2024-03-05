//
//  SignInViewController.swift
//  KingBurguer
//
//  Created by Tiago Aguiar on 17/11/22.
//

import Foundation
import UIKit

enum SignInForm: Int {
    case email    = 0x1
    case password = 0x2
}

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
    
    // 1. definicao de layout
    lazy var email: TextField = {
        let ed = TextField()
        ed.placeholder = "Entre com seu e-mail"
        ed.returnKeyType = .next
        ed.error = "E-mail invalido"
        ed.keyboardType = .emailAddress
        ed.bitmask = SignInForm.email.rawValue
        
        // Forma "tradicional" de prog. funcional
        // ed.failure = validation
        
        // Forma enxuta/encurtada de prog. funcional
        ed.failure = {
            return !ed.text.isEmail()
        }
        ed.delegate = self
        return ed
    }()
    
    // Forma "tradicional" de prog. funcional
//    func validation() -> Bool {
//        return email.text.count <= 3
//    }
    
    
    lazy var password: TextField = {
        let ed = TextField()
        ed.placeholder = "Entre com sua senha"
        ed.returnKeyType = .done
        ed.error = "Senha deve ter no minimo 8 caracteres"
        ed.secureTextEntry = true
        ed.bitmask = SignInForm.password.rawValue
        ed.failure = {
            return ed.text.count <= 8
        }
        ed.delegate = self
        return ed
    }()
    
    lazy var send: LoadingButton = {
        let btn = LoadingButton()
        btn.title = "Entrar"
        btn.backgroundColor = .red
        btn.enable(false)
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
    
    var viewModel: SignInViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    var bitmaskResult: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: explicar o que e o super e o ciclo das viewControllers
        
        // quando for enum podemos omitir o nome da enum, ou seja, podemos apenas atribuir o valor
        // direto que ele vai entender
        view.backgroundColor = .systemBackground
        
        navigationItem.title = "Login"
        
        
        
        container.addSubview(email)
        container.addSubview(password)
        container.addSubview(send)
        container.addSubview(register)
        
        scroll.addSubview(container)
        view.addSubview(scroll)
        
        let scrollContraints = [
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.topAnchor.constraint(equalTo: view.topAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        
        let heightConstraint = container.heightAnchor.constraint(equalTo: view.heightAnchor)
        heightConstraint.priority = .defaultLow
        heightConstraint.isActive = true
        
        let containerCosntraints = [
            container.widthAnchor.constraint(equalTo: view.widthAnchor),
            container.topAnchor.constraint(equalTo: scroll.topAnchor),
            container.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            
            container.heightAnchor.constraint(equalToConstant: 490)
        ]

        
        let emailConstraints = [
            // 1. as coordenadas da esquerda (leading)
            email.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            // 2. as coordenadas da direita (trailing)
            email.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            // 3. as coordenadas do centro Y
            email.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: -150.0),
        ]
        
        let passwordConstraints = [
            password.leadingAnchor.constraint(equalTo: email.leadingAnchor),
            password.trailingAnchor.constraint(equalTo: email.trailingAnchor),
            password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 10.0),
        ]
        
        let sendConstraints = [
            send.leadingAnchor.constraint(equalTo: email.leadingAnchor),
            send.trailingAnchor.constraint(equalTo: email.trailingAnchor),
//            send.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20.0),
            send.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 10.0),
            send.heightAnchor.constraint(equalToConstant: 50.0),
        ]
        
        let registerConstraints = [
            register.leadingAnchor.constraint(equalTo: email.leadingAnchor),
            register.trailingAnchor.constraint(equalTo: email.trailingAnchor),
            register.topAnchor.constraint(equalTo: send.bottomAnchor, constant: 15.0),
            register.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        NSLayoutConstraint.activate(emailConstraints)
        NSLayoutConstraint.activate(passwordConstraints)
        NSLayoutConstraint.activate(sendConstraints)
        NSLayoutConstraint.activate(registerConstraints)
        
        NSLayoutConstraint.activate(scrollContraints)
        NSLayoutConstraint.activate(containerCosntraints)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onKeyboardNotification),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onKeyboardNotification),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
    }
    
    @objc func onKeyboardNotification(_ notification: Notification) {
        let visible = notification.name == UIResponder.keyboardWillShowNotification
        
        let keyboardFrame = visible
            ? UIResponder.keyboardFrameEndUserInfoKey
            : UIResponder.keyboardFrameBeginUserInfoKey
        
        if let keyboardSize = (notification.userInfo?[keyboardFrame] as? NSValue)?.cgRectValue {
            onKeyboardChanged(visible, height: keyboardSize.height)
        }
        
    }
    
    func onKeyboardChanged(_ visible: Bool, height: CGFloat) {
        if (!visible) {
            scroll.contentInset = .zero
            scroll.scrollIndicatorInsets = .zero
        } else {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: height, right: 0.0)
            scroll.contentInset = contentInsets
            scroll.scrollIndicatorInsets = contentInsets
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(_ view: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    // 2. eventos de touch
    @objc func sendDidTap(_ sender: UIButton) {
        viewModel?.send()
    }
    
    @objc func registerDidTap(_ sender: UIButton) {
        viewModel?.goToSignUp()
    }

}

extension SignInViewController: TextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField.returnKeyType == .done) {
            view.endEditing(true)
        } else {
            password.gainFocus()
        }
        return false
    }
    func textFieldDidChanged(isValid: Bool, bitmask: Int, text: String) {
        if isValid {
            //OR bit a bit
            self.bitmaskResult = self.bitmaskResult | bitmask
        } else {
            // NOT e AND bit a bit
            self.bitmaskResult = self.bitmaskResult & ~bitmask
        }
        
        // e-mail E password precisam ser validos!!!
        self.send.enable((SignInForm.email.rawValue & self.bitmaskResult != 0)
                         && (SignInForm.password.rawValue & self.bitmaskResult != 0))
    }
}

// 3. observers
extension SignInViewController: SignInViewModelDelegate {
    func viewModelDidChanged(state: SignInState) {
        switch(state) {
            case .none:
                break
            case .loading:
                send.startLoading(true)
                break
            case .goToHome:
                // navegar para a tela princial
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
