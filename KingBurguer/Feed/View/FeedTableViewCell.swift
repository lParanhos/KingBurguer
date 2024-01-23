//
//  FeedTableViewCell.swift
//  KingBurguer
//
//  Created by Leandro Paranhos on 23/01/24.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    //variável da classe
    static let identifier = "FeedTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .systemGreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
