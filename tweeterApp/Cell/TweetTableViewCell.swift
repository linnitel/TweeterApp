//
//  TweetTableViewCell.swift
//  tweeterApp
//
//  Created by Yuliya Martsenko on 12.02.2022.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    var nameLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    var dateLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        label.textAlignment = .right
        return label
    }()
    
    lazy var nameDateStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, dateLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .fill
        stack.distribution = .fill
        stack.layoutMargins = .init(top: 8, left: 8, bottom: 8, right: 8)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    var tweetLabel: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.isEditable = false
        return textView
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameDateStackView, tweetLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .fill
        stack.distribution = .fill
        stack.layoutMargins = .init(top: 8, left: 8, bottom: 8, right: 8)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layer.borderColor = CGColor(red: 0, green: 0, blue: 256, alpha: 100)
        stack.layer.borderWidth = 1.0
        return stack
    }()
    
    private func formatDate(from date: String?) -> String? {
        
        let format = DateFormatter()
        format.dateFormat = "EEE MMM dd HH:mm:ss zzz yyyy"
        guard let date = date,
              let convertedDate = format.date(from: date) else {
            return nil
        }
        format.dateFormat = "dd.MM.yyyy HH:mm"
        return format.string(from: convertedDate)
    }
    
    func setupCell(from model: TweetModel) {
        nameLabel.text = model.name
        tweetLabel.text = model.text
        dateLabel.text = formatDate(from: model.date)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupViews() {
        backgroundColor = .blue
        contentView.backgroundColor = .white
        selectionStyle = .none
        contentView.addSubview(stackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
       super.init(style: style, reuseIdentifier: "Tweet")
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }

}
