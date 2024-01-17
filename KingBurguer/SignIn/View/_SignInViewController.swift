//
//  SignInViewController.swift
//  KingBurguer
//
//  Created by Tiago Aguiar on 17/11/22.
//

import Foundation
import UIKit

class _SignInViewController: UIViewController {
    
    let scroll: UIScrollView = {
        let sc = UIScrollView()
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    let container: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var send: UIButton = {
        let btn = UIButton()
        btn.setTitle("Entrar", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .yellow
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        navigationItem.title = "Login"
        
        var texts: [UITextField] = []
        for i in 0..<30 {
            let t = UITextField()
            t.placeholder = "ola \(i)"
            t.borderStyle = .roundedRect
            t.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(t)
            texts.append(t)
        }
        
        container.addSubview(send)
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
        ]
        
        for i in 0..<texts.count {
            if i == 0 {
                NSLayoutConstraint.activate([
                    texts[i].leadingAnchor.constraint(equalTo: container.leadingAnchor),
                    texts[i].trailingAnchor.constraint(equalTo: container.trailingAnchor),
                    texts[i].heightAnchor.constraint(equalToConstant: 50.0),
                    texts[i].topAnchor.constraint(equalTo: container.topAnchor, constant: 10.0),
                ])
            } else {
                NSLayoutConstraint.activate([
                    texts[i].leadingAnchor.constraint(equalTo: container.leadingAnchor),
                    texts[i].trailingAnchor.constraint(equalTo: container.trailingAnchor),
                    texts[i].heightAnchor.constraint(equalToConstant: 50.0),
                    texts[i].topAnchor.constraint(equalTo: texts[i-1].bottomAnchor, constant: 10.0),
                ])
            }
        }
        
        let sendConstraints = [
            send.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            send.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            send.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20.0),
            send.topAnchor.constraint(greaterThanOrEqualTo: texts.last!.bottomAnchor, constant: 10.0),
            send.heightAnchor.constraint(equalToConstant: 50.0),
        ]
        

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
    
    @objc func dismissKeyboard(_ view: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}

extension _SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField.returnKeyType == .done) {
            view.endEditing(true)
        }
        
        return false
    }
}
