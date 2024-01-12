//
//  SignInState.swift
//  KingBurguer
//
//  Created by Leandro Paranhos on 12/01/24.
//

import Foundation

enum SignInState {
    case none
    case loading
    case goToHome
    case error(String)
}
