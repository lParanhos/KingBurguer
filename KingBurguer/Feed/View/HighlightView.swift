//
//  HighlightView.swift
//  KingBurguer
//
//  Created by Leandro Paranhos on 23/01/24.
//

import UIKit

class HighlightView: UIView {
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode   = .scaleAspectFill
        iv.image = UIImage(named: "highlight")
        iv.clipsToBounds = true
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //se adequa ao tamanho na tela pai
        imageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
