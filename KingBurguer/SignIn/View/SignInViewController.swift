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
        
        return ed
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        view.addSubview(email)
        
        
        email.frame = CGRect(x: 0, y: view.bounds.size.height / 2, width: view.bounds.size.width, height: 50)
    }
}
