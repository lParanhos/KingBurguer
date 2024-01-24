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
    
    private let moreButton: UIButton = {
       let btn = UIButton()
        btn.setTitle("Resgatar Cupom", for: .normal)
        btn.layer.borderColor = UIColor.systemBackground.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 5
        btn.translatesAutoresizingMaskIntoConstraints = false
        //Permite adicionar paddings
        btn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        
        addGradient()
        
        addSubview(moreButton)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        let moreButtonConstraints = [
            moreButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -8),
            moreButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50)
        ]
        
        NSLayoutConstraint.activate(moreButtonConstraints)
    }
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor, //33%
            UIColor.clear.cgColor, //33%
            UIColor.black.cgColor //33%
        ]
        
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
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
