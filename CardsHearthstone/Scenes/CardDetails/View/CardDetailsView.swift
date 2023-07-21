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
        imageView.layer.cornerRadius = ViewMetrics.CardImage.cornerRadius
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var infosTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            CardDetailsTableViewCell.self,
            forCellReuseIdentifier: CardDetailsTableViewCell.cellIdentifier
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var card: CardDetailsModels.Card.ViewModel?
    
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
            infosTableView.topAnchor.constraint(equalTo: cardImageView.bottomAnchor, constant: ViewMetrics.TableView.top),
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

extension CardDetailsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ViewMetrics.TableView.heightForRowAt
    }
}

extension CardDetailsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewMetrics.TableView.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CardDetailsTableViewCell.cellIdentifier,
            for: indexPath
        ) as? CardDetailsTableViewCell else {
            return UITableViewCell()
        }
        
        let infoCardString = createInfoCardString(from: indexPath.row)
        cell.configureCell(info: infoCardString)

        return cell
    }
    
    private func createInfoCardString(from index: Int) -> String {
        switch index {
        case 0:
            return "Nome: " + (card?.name ?? Texts.noInformation)
        case 1:
            return "Flavor: " + (card?.flavor ?? Texts.noInformation)
        case 2:
            return "Descrição: " + (card?.text ?? Texts.noInformation)
        case 3:
            return "Set: " + (card?.cardSet ?? Texts.noInformation)
        case 4:
            return "Tipo: " + (card?.type ?? Texts.noInformation)
        case 5:
            return "Facção: " + (card?.faction ?? Texts.noInformation)
        case 6:
            return "Radidade: " + (card?.rarity ?? Texts.noInformation)
        case 7:
            return card?.attack != nil ? "Ataque: \(card?.attack ?? 0)" : "Ataque: " + Texts.noInformation
        case 8:
            return card?.cost != nil ? "Custo: \(card?.cost ?? 0)" : "Custo: " + Texts.noInformation
        case 9:
            return card?.health != nil ? "Saúde: \(card?.health ?? 0)" : "Saúde: " + Texts.noInformation
        default:
            return ""
        }
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
    
    private struct ViewMetrics {
        enum TableView {
            static let heightForRowAt: CGFloat = 40.0
            static let numberOfRowsInSection: Int = 10
            
            static let top: CGFloat = 10.0
        }
        
        enum CardImage {
            static let cornerRadius: CGFloat = 16.0
        }
    }
}
