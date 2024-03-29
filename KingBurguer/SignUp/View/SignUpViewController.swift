//
//  SignUpViewController.swift
//  KingBurguer
//
//  Created by Leandro Paranhos on 12/01/24.
//

import Foundation
import UIKit

enum SignUpForm: Int {
    case name = 0x1
    case email = 0x2
    case password = 0x4
    case document = 0x8
    case birthday = 0x10
}

class SignUpViewController: UIViewController {
    
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
    
    
    lazy var name: TextField = {
        let ed = TextField()
        ed.placeholder = "Entre com seu nome"
        ed.returnKeyType = .next
        ed.tag = 1
        ed.delegate = self
        ed.error = "Nome deve ter no minimo 3 caracteres"
        ed.bitmask = SignUpForm.name.rawValue
        ed.failure = {
            return ed.text.count < 3
        }
        return ed
    }()
    
    lazy var email: TextField = {
        let ed = TextField()
        ed.placeholder = "Entre com seu email"
        ed.tag = 2
        ed.returnKeyType = .next
        ed.delegate = self
        ed.error = "E-mail inválido"
        ed.bitmask = SignUpForm.email.rawValue
        ed.keyboardType = .emailAddress
        ed.failure = {
            return !ed.text.isEmail()
        }
        return ed
    }()
    
    lazy var password: TextField = {
        let ed = TextField()
        ed.placeholder = "Entre com sua senha"
        ed.tag = 3
        ed.returnKeyType = .next
        ed.delegate = self
        ed.error = "Senha deve ter no minimo 8 caracteres"
        ed.bitmask = SignUpForm.password.rawValue
        ed.secureTextEntry = true
        ed.failure = {
            return ed.text.count < 8
        }
        return ed
    }()
    
    lazy var document: TextField = {
        let ed = TextField()
        ed.placeholder = "Entre com seu CPF"
        ed.tag = 4
        ed.returnKeyType = .next
        ed.maskField = Mask(mask: "###.###.###-##")
        ed.delegate = self
        ed.error = "CPF deve ter no minimo 11 digitos"
        ed.bitmask = SignUpForm.document.rawValue
        ed.keyboardType = .numberPad
        ed.failure = {
            return ed.text.count != 14
        }
        return ed
    }()
    
    lazy var birthday: TextField = {
        let ed = TextField()
        ed.placeholder = "Entre com sua data de nascimento"
        ed.tag = 5
        ed.returnKeyType = .done
        ed.delegate = self
        ed.error = "Data de nascimento deve ser dd/MM/yyyy"
        ed.maskField = Mask(mask: "##/##/####")
        ed.bitmask = SignUpForm.birthday.rawValue
        ed.failure = {
            let invalidCount = ed.text.count != 10
            
            let dt = DateFormatter()
            dt.locale = Locale(identifier: "en_US_POSIX")
            dt.dateFormat = "dd/MM/yyyy"
            
            let date = dt.date(from: ed.text)
            let invalidDate = date == nil
            
            return invalidDate || invalidCount
        }
        return ed
    }()
    
    
    lazy var send: LoadingButton = {
        let btn = LoadingButton()
        btn.title = "Entrar"
        btn.titleColor = .white
        btn.enable(false)
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(sendDidTap))
        return btn
    }()
    
    var viewModel : SignUpViewModel? {
        didSet {
            //Delega as informações para a classe atual
            viewModel?.delegate = self
        }
    }
    
    var bitmaskResult: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        
        container.addSubview(name)
        container.addSubview(email)
        container.addSubview(password)
        container.addSubview(document)
        container.addSubview(birthday)
        container.addSubview(send)
        scroll.addSubview(container)
        view.addSubview(scroll)
        
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
        
        
        let nameConstraints = [
            name.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            name.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            name.topAnchor.constraint(equalTo: container.topAnchor, constant: 70.0)
        ]
        
        let emailConstraints = [
            email.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            email.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10)
        ]
        
        let passwordConstraints = [
            password.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            password.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 10)
        ]
        
        let documentConstraints = [
            document.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            document.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            document.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 10)
        ]
        
        let birthdayConstraints = [
            birthday.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            birthday.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            birthday.topAnchor.constraint(equalTo: document.bottomAnchor, constant: 10)
        ]
        
        let sendConstraints = [
            send.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            send.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            send.topAnchor.constraint(equalTo: birthday.bottomAnchor, constant: 10),
            send.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        NSLayoutConstraint.activate(nameConstraints)
        NSLayoutConstraint.activate(emailConstraints)
        NSLayoutConstraint.activate(passwordConstraints)
        NSLayoutConstraint.activate(birthdayConstraints)
        NSLayoutConstraint.activate(documentConstraints)
        NSLayoutConstraint.activate(sendConstraints)
        NSLayoutConstraint.activate(scrollContraints)
        NSLayoutConstraint.activate(containerCosntraints)
        
        
        //Observador de teclado
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)

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
        if(!visible) {
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
    
    @objc func dismissKeyboard(_ view: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    @objc func sendDidTap(_ sender: UIButton) {
        viewModel?.send()
    }
}

extension SignUpViewController: SignUpViewModeDelegate {
    func viewModelDidChange(state: SignUpState) {
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

extension SignUpViewController: TextFieldDelegate {
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField.returnKeyType == .done) {
            view.endEditing(true)
            return false
        }
        
        let nextTag = textField.tag + 1
        let component = container.findViewByTag(tag: nextTag) as? TextField
        
        if component != nil {
            component?.gainFocus()
        } else {
            view.endEditing(true)
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
        self.send.enable(
            (SignUpForm.name.rawValue & self.bitmaskResult != 0) &&
            (SignUpForm.email.rawValue & self.bitmaskResult != 0) &&
            (SignUpForm.password.rawValue & self.bitmaskResult != 0) &&
            (SignUpForm.document.rawValue & self.bitmaskResult != 0) &&
            (SignUpForm.birthday.rawValue & self.bitmaskResult != 0)
        )
        
        if bitmask == SignUpForm.name.rawValue {
            viewModel?.name = text
        } else if bitmask == SignUpForm.email.rawValue {
            viewModel?.email = text
        } else if bitmask == SignUpForm.password.rawValue {
            viewModel?.password = text
        } else if bitmask == SignUpForm.birthday.rawValue {
            viewModel?.birthday = text
        } else if bitmask == SignUpForm.document.rawValue {
            viewModel?.document = text
        }
    }
}

extension UIView {
    func findViewByTag(tag: Int) -> UIView? {
        for subview in subviews {
            if subview.tag == tag{
                return subview
            }
        }
        return nil
    }
}
