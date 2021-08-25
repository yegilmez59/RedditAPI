//
//  RedditCell.swift
//  BrianKeithChallenge
//
//  Created by Yagmur Egilmez on 8/23/21.
//

import UIKit

class FeedCell: UITableViewCell {
    
    static let identifier = "FeedCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy private var feedImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy private var numCommentsLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy private var scoreLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    func configureCell(title: String?, score: String?, numComments: String?, imageData: Data?) {
        
        setUpUI(imageData: imageData)
        
        titleLabel.text = title
        numCommentsLabel.text = "Comments: \(numComments ?? "")"
        scoreLabel.text = "Score: \(score ?? "")"
        
        feedImageView.image = nil
        if let data = imageData {
            feedImageView.image = UIImage(data: data)
        }
    }
    
    private func setUpUI(imageData: Data? = nil) {
        let vStackView = UIStackView(frame: .zero)
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.axis = .vertical
        vStackView.distribution = .fill
        vStackView.alignment = .leading
        
        vStackView.addArrangedSubview(titleLabel)
        if let _ = imageData {
            vStackView.addArrangedSubview(feedImageView)
        }
        vStackView.addArrangedSubview(numCommentsLabel)
        vStackView.addArrangedSubview(scoreLabel)
        
        contentView.addSubview(vStackView)
        
        vStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0).isActive = true
        vStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0).isActive = true
        vStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0).isActive = true
        vStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0).isActive = true
    }
}
