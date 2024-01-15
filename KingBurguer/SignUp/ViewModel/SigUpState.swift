//
//  SigUpState.swift
//  KingBurguer
//
//  Created by Leandro Paranhos on 15/01/24.
//

import Foundation

enum SignUpState {
    case none
    case loading
    case goToHome
    case error(String)
}
