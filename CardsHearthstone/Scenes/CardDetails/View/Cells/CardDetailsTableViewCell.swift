//
//  CardDetailsTableViewCell.swift
//  CardsHearthstone
//
//  Created by Lucas Santana Brito on 21/07/23.
//

import UIKit

final class CardDetailsTableViewCell: UITableViewCell {
    // MARK: - Static Propertie
    static let cellIdentifier: String = Texts.cellIdentifier
    
    // MARK: - UI Properties
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .natural
        label.textColor = .white
        label.font = .systemFont(ofSize: ViewMetrics.TitleLabel.fontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        infoLabel.text = ""
    }
    
    func configureCell(info: String) {
        infoLabel.text = info
    }
}

// MARK: - ConfigurationView
extension CardDetailsTableViewCell: ConfigurationView {
    func setupSubViews() {
        contentView.addSubview(infoLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            infoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ViewMetrics.TitleLabel.leading),
            infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            infoLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configureViews() {
        backgroundColor = .black
        selectionStyle = .none
    }
}

extension CardDetailsTableViewCell {
    // MARK: - Texts
    private enum Texts {
        static let cellIdentifier: String = "CardDetailsTableViewCell"
    }
    
    // MARK: - ViewMetrics
    private struct ViewMetrics {
        enum TitleLabel {
            static let fontSize: CGFloat = 18.0
            
            static let leading: CGFloat = 8.0
        }
    }
}
