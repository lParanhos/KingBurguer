//
//  HomeViewController.swift
//  KingBurguer
//
//  Created by Leandro Paranhos on 16/01/24.
//

import Foundation
import UIKit

class HomeViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        // padrão para conseguir adicionar na tabbar
        let feedVC = UINavigationController(rootViewController: FeedViewController())
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        let couponVC = UINavigationController(rootViewController: CouponViewController())
        
        //Adiciona um titulo logo abaixo do icone
        feedVC.title = "Inicio"
        couponVC.title = "Cupons"
        profileVC.title = "Perfil"
        
        //muda a cor do item selecionado para vermelho
        tabBar.tintColor = .red
        
        // Adciona os icones de cada view na tabbar
        // esses icones são default do sistema só usar o symbols explorer
        feedVC.tabBarItem.image = UIImage(systemName: "house")
        couponVC.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        profileVC.tabBarItem.image = UIImage(systemName: "person.circle")
        
        setViewControllers([feedVC, couponVC, profileVC], animated: true)
    }
}
