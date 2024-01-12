//
//  SignInCoordinator.swift
//  KingBurguer
//
//  Created by Leandro Paranhos on 12/01/24.
//
import UIKit
import Foundation

class SignInCoordinator {
    
    private let window: UIWindow?
    private let navigationController: UINavigationController
    
    init(window: UIWindow?) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        //Passa a viewmodel para a controller
        let viewModel  = SignInViewModel()
        viewModel.coordinator = self
        
        let signInVC = SignInViewController()
        signInVC.viewModel = viewModel
        
        //configura a NC
        // = a rootViewController
        navigationController.pushViewController(signInVC, animated: true)
        
        //precisamos colocar o navigation controller como nosso root
        window?.rootViewController = navigationController
        //se não colocar, não renderiza a tela
        window?.makeKeyAndVisible()
    }
    
    func signUp() {
        let signUpCoordinator = SignUpCoordinator(navigationController: navigationController)
        signUpCoordinator.start()
    }
}
