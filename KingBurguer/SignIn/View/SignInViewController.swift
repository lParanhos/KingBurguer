//
//  SignInViewController.swift
//  KingBurguer
//
//  Created by Leandro Paranhos on 10/01/24.
//

import Foundation
import UIKit

class SignInViewController: UIViewController {
    
    let email: UITextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        view.addSubview(email)
        
        email.backgroundColor = .blue
        email.placeholder = "Entre com seu e-mail"
        email.frame = CGRect(x: 0, y: view.bounds.size.height / 2, width: view.bounds.size.width, height: 50)
    }
}
