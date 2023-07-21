//
//  CardDetailsView.swift
//  CardsHearthstone
//
//  Created by Lucas Santana Brito on 21/07/23.
//

import UIKit

protocol CardDetailsViewDelegate: AnyObject {
    func updateView(card: CardDetailsModels.Card.ViewModel)
}

class CardDetailsView: UIView {
    private lazy var cardImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 16.0
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var infosTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var card: CardDetailsModels.Card.ViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CardDetailsView: ConfigurationView {
    func setupSubViews() {
        addSubview(cardImageView)
        addSubview(infosTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cardImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            cardImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            infosTableView.topAnchor.constraint(equalTo: cardImageView.bottomAnchor, constant: 10.0),
            infosTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            infosTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            infosTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureViews() {
        backgroundColor = .black
        infosTableView.backgroundColor = .black
    }
}

extension CardDetailsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Nome: " + (card?.name ?? Texts.noInformation)
        case 1:
            cell.textLabel?.text = "Flavor: " + (card?.flavor ?? Texts.noInformation)
        case 2:
            cell.textLabel?.text = "Descrição: " + (card?.text ?? Texts.noInformation)
        case 3:
            cell.textLabel?.text = "Set: " + (card?.cardSet ?? Texts.noInformation)
        case 4:
            cell.textLabel?.text = "Tipo: " + (card?.type ?? Texts.noInformation)
        case 5:
            cell.textLabel?.text = "Facção: " + (card?.faction ?? Texts.noInformation)
        case 6:
            cell.textLabel?.text = "Radidade: " + (card?.rarity ?? Texts.noInformation)
        case 7:
            cell.textLabel?.text = card?.attack != nil ? "Ataque: \(card?.attack ?? 0)" : "Ataque: ******"
        case 8:
            cell.textLabel?.text = card?.cost != nil ? "Custo: \(card?.cost ?? 0)" : "Custo: ******"
        case 9:
            cell.textLabel?.text = card?.health != nil ? "Saúde: \(card?.health ?? 0)" : "Saúde: ******"
        default:
            break
        }
        
        return cell
    }
}

extension CardDetailsView: CardDetailsViewDelegate {
    func updateView(card: CardDetailsModels.Card.ViewModel) {
        cardImageView.downloadImage(fromURL: card.imageURl)
        self.card = card
        infosTableView.reloadData()
    }
}

extension CardDetailsView {
    private enum Texts {
        static let noInformation: String = "Sem informação"
    }
}
