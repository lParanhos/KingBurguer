//
//  LoadingButton.swift
//  KingBurguer
//
//  Created by Leandro Paranhos on 17/01/24.
//

import Foundation
import UIKit

class LoadingButton: UIView {
    
    lazy var button: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let progress: UIActivityIndicatorView = {
        let p = UIActivityIndicatorView()
        p.translatesAutoresizingMaskIntoConstraints = false
        return p
    }()
    
    var title: String? {
        //Executa antes de atribuir
        willSet {
            //newValue é o valor padrão que chega para o componente
            button.setTitle(newValue, for: .normal)
        }
    }
    
    var titleColor: UIColor? {
        willSet {
            button.setTitleColor(newValue, for: .normal)
        }
    }
    
    //Usamos override pois na classe UIView já esxiste a propriedade background color
    override var backgroundColor: UIColor? {
        willSet {
            button.backgroundColor = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    //quando trabalhamos com storyboar ele utiliza essa função
    // para criar, ela é obrigatória
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //DESCRIBE BUG
    func enable(_ isEnabled: Bool) {
        button.isEnabled = isEnabled
        if isEnabled {
            alpha = 1
        } else {
            alpha = 0.5
        }
    }
    
    func addTarget(_ target: Any?, action: Selector) {
        /* Self é a classe que vai conter a função que será disparada
         action: é a função a ser disparada, com o selector expomos nossa função para o objective-c
         for: evento em que deve ser disparado
         */
        button.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func startLoading(_ loading: Bool) {
        button.isEnabled = !loading
        
        if loading {
            button.setTitle("", for: .normal)
            progress.startAnimating()
            alpha = 0.5
            
        } else {
            button.setTitle(title, for: .normal)
            progress.stopAnimating()
            alpha = 1.0
        }
    }
    
    private func setupViews() {
        backgroundColor = .yellow
        addSubview(button)
        addSubview(progress)
        
        let buttonContraints = [
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        let progressContraints = [
            progress.leadingAnchor.constraint(equalTo: leadingAnchor),
            progress.trailingAnchor.constraint(equalTo: trailingAnchor),
            progress.topAnchor.constraint(equalTo: topAnchor ),
            progress.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(buttonContraints)
        NSLayoutConstraint.activate(progressContraints)
    }
}
