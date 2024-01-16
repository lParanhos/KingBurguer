//
//  SignUpCoordinator.swift
//  KingBurguer
//
//  Created by Leandro Paranhos on 12/01/24.
//

import Foundation
import UIKit

class SignUpCoordinator {
    private let navigationController: UINavigationController
    
    var parentCoordinator: SignInCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = SignUpViewModel()
        viewModel.coordinator = self
        
        let signUpVC = SignUpViewController()
        signUpVC.viewModel = viewModel
        
        navigationController.pushViewController(signUpVC, animated: true)
    }
    
    func home() {
        //reaproveita a logica para navegar para a home
        parentCoordinator?.home()
    }
}
