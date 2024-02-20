//
//  TextField.swift
//  KingBurguer
//
//  Created by Leandro Paranhos on 15/02/24.
//

import UIKit

class TextField: UIView {
    
    lazy var ed: UITextField = {
        let ed = UITextField()
        ed.borderStyle = .roundedRect
        ed.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        //Necessário desabilitar sempre, para utilizar o auto layout
        ed.translatesAutoresizingMaskIntoConstraints = false
        return ed
    }()
    
    let errorLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .red
        lb.translatesAutoresizingMaskIntoConstraints = false
        
        return lb
    }()
    
    var placeholder: String? {
        willSet{
            ed.placeholder = newValue
        }
    }
    
    var keyboardType: UIKeyboardType = .default {
        willSet {
            if newValue == .emailAddress {
                ed.autocapitalizationType = .none
            }
                
            ed.keyboardType = newValue
        }
    }
    
    var secureTextEntry: Bool = false {
        willSet{
            ed.isSecureTextEntry = newValue
            // remove a auto gestão de senha da apple
            ed.textContentType = .oneTimeCode
        }
    }
    
    var delegate: UITextFieldDelegate? {
        willSet {
            ed.delegate = newValue
        }
    }
    
    override var tag: Int {
        willSet{
            super.tag = newValue
            ed.tag = newValue
        }
    }
    
    var text: String {
        get {
            return ed.text!
        }
    }
    
    var returnKeyType: UIReturnKeyType = .next {
        willSet {
            ed.returnKeyType = newValue
        }
    }
    //Uma variável função, que não recebe parametros e o retorno é do tipo boleano
    var failure: (() -> Bool)?
    
    var error: String?
    
    var heightContraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(ed)
        addSubview(errorLabel)
        
        let edConstraints = [
            ed.leadingAnchor.constraint(equalTo: leadingAnchor),
            ed.trailingAnchor.constraint(equalTo: trailingAnchor),
            ed.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        let errorLabelConstraints = [
            errorLabel.leadingAnchor.constraint(equalTo: ed.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: ed.trailingAnchor),
            errorLabel.topAnchor.constraint(equalTo: ed.bottomAnchor)
        ]
        
        heightContraint = heightAnchor.constraint(equalToConstant: 50.0)
        heightContraint.isActive = true
        
        NSLayoutConstraint.activate(edConstraints)
        NSLayoutConstraint.activate(errorLabelConstraints)
    }
    
    func gainFocus() {
        ed.becomeFirstResponder()
    }
    
    @objc func textFieldDidChanged(_ textField: UITextField){
        guard let fn = failure else { return }
        
        if let error = error {
            if fn() {
                errorLabel.text = error
                heightContraint.constant = 70
            } else {
                errorLabel.text = ""
                heightContraint.constant = 50
            }
        }
        //Força uma atualização das subviews caso seja necessário
        layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
