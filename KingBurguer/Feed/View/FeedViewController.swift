//
//  FeedViewController.swift
//  KingBurguer
//
//  Created by Leandro Paranhos on 18/01/24.
//

import UIKit

class FeedViewController: UIViewController {
    
    let sections = ["Mais Vendidos", "Vegano", "Bovinos", "Sobremesas"]
    
    //1. registrar uma classe que seja UITableViewCell
    //2. definir o datasource (viewcontroller)
    //3. numberOfRowsInSection | cellForRowAt
    
    private let homeFeedTable: UITableView={
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.identifier)
        tv.backgroundColor = .systemBackground
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(homeFeedTable)
        let headerView = HighlightView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 300))
        headerView.backgroundColor = .orange
        homeFeedTable.tableHeaderView = headerView
        
        
        //precisamos do delegate para modificar propriedades da table
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configureNavBar()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    private func configureNavBar() {
        //Precisamos que o container seja um navigation controller
        navigationItem.title = "Produto"
        //recurso de "animação" do title da navbar
        navigationController?.navigationBar.prefersLargeTitles = false
        
        var image = UIImage(named: "icon")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "power"), style: .done, target: self, action: #selector(testDidTap)),
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil)
        ]
        //muda as cores dos icones da navigation bar
        navigationController?.navigationBar.tintColor = UIColor.red
    }
    
    @objc func testDidTap(_ sender: UIBarButtonItem){
        print("Clicou")
    }
}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    //Numero de linhas na seção
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    /* func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        //Só usamos a variavel quando conseguimos usar o valor opcional
        guard let header = view as? UITableViewHeaderFooterView else {return}
        
        //Nesse exato momento eu tenho o UITableViewHeaderFooterView efetivamente
        header.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 120, height: header.bounds.height)
        header.textLabel?.textColor = .label
    } */
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 40))
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: tableView.bounds.width, height: 40))
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .label
        label.text = sections[section].uppercased()
        
        view.addSubview(label)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //pegamos a celula que criamos e utilizamos
        //o iPhone reutiliza celulas para salvar a memoria
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier, for: indexPath) as! FeedTableViewCell
        //Como o dequeue sempre retorna a classe pai UIViewCell precisamos fazer esse
        // cast para o tipo dela se torne o tipo da classe que criamos
        //usamos o as! quando sabemos que o tipo que criamos tem compatibilidade
        
        
        cell.textLabel?.text = "Olá mundo \(indexPath.section) \(indexPath.row)"
        
        return cell
    }
    
    
}
