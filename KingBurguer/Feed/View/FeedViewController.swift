//
//  FeedViewController.swift
//  KingBurguer
//
//  Created by Leandro Paranhos on 18/01/24.
//

import UIKit

class FeedViewController: UIViewController {
    
    //1. registrar uma classe que seja UITableViewCell
    //2. definir o datasource (viewcontroller)
    //3. numberOfRowsInSection | cellForRowAt
    
    private let homeFeedTable: UITableView={
        let tv = UITableView()
        tv.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.identifier)
        tv.backgroundColor = .cyan
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(homeFeedTable)
        
        homeFeedTable.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
}

extension FeedViewController: UITableViewDataSource {
    //Numero de linhas
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //pegamos a celula que criamos e utilizamos
        //o iPhone reutiliza celulas para salvar a memoria
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier, for: indexPath) as! FeedTableViewCell
        //Como o dequeue sempre retorna a classe pai UIViewCell precisamos fazer esse
        // cast para o tipo dela se torne o tipo da classe que criamos
        //usamos o as! quando sabemos que o tipo que criamos tem compatibilidade
        
        
        cell.textLabel?.text = "Olá mundo \(indexPath.row)"
        
        return cell
    }
    
    
}
