//
//  CardListView.swift
//  CardsHearthstone
//
//  Created by Lucas Santana Brito on 20/07/23.
//

import UIKit

protocol CardListViewDelegate: AnyObject {
    func cardItemDidSelect(_ card: CardListModels.Cards.ViewModel)
}

class CardListView: UIView {
    private lazy var cardsCollectionView: UICollectionView = {
        let layoutFlow = UICollectionViewFlowLayout()
        layoutFlow.scrollDirection = .vertical
        layoutFlow.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layoutFlow
        )
        collectionView.register(
            CardListCollectionViewCell.self,
            forCellWithReuseIdentifier: CardListCollectionViewCell.identifier
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var list: [CardListModels.Cards.ViewModel] = [] {
        didSet {
            cardsCollectionView.reloadData()
        }
    }
    
    weak var delegate: CardListViewDelegate?
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CardListView: ConfigurationView {
    func setupSubViews() {
        addSubview(cardsCollectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cardsCollectionView.topAnchor.constraint(equalTo: topAnchor),
            cardsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configureViews() {
        cardsCollectionView.dataSource = self
        cardsCollectionView.delegate = self
        cardsCollectionView.backgroundColor = .black
    }
}

extension CardListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (bounds.size.width / 2.3), height: bounds.size.height / 3.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let card = list[safe: indexPath.row] else { return }
        delegate?.cardItemDidSelect(card)
    }
}

extension CardListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CardListCollectionViewCell.identifier,
            for: indexPath
        ) as? CardListCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let card = list[safe: indexPath.row] else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(with: card)
        
        return cell
    }
}
