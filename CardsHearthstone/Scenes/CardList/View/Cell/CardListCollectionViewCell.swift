//
//  CardListCollectionViewCell.swift
//  CardsHearthstone
//
//  Created by Lucas Santana Brito on 20/07/23.
//

import UIKit

class CardListCollectionViewCell: UICollectionViewCell {
    static let identifier = "CardListCollectionViewCell"
    
    private lazy var cardImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 16.0
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var cardNameLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cardImageView.image = nil
        cardNameLabel.text = ""
    }
    
    func configureCell(with card: CardListModels.Cards.ViewModel) {
        cardNameLabel.text = card.name ?? "-------"
        cardImageView.downloadImage(fromURL: card.imageURL)
    }
}

extension CardListCollectionViewCell: ConfigurationView {
    func setupSubViews() {
        contentView.addSubview(cardNameLabel)
        contentView.addSubview(cardImageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cardNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cardNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2.0)
        ])
        
        NSLayoutConstraint.activate([
            cardImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardImageView.bottomAnchor.constraint(equalTo: cardNameLabel.topAnchor, constant: -10.0)
        ])
    }
    
    func configureViews() {
        cardImageView.backgroundColor = .gray.withAlphaComponent(0.5)
    }
}
