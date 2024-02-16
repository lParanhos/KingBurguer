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
    
    var returnKeyType: UIReturnKeyType = .next {
        willSet {
            ed.returnKeyType = newValue
        }
    }
    
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
    
    @objc func textFieldDidChanged(_ textField: UITextField){
        if let text = textField.text {
            if text.count <= 3 {
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
