//
//  TodoItemTableViewCell.swift
//  Todo
//
//  Created by Triet M1 Macbook Pro on 15.3.2021.
//

import Combine
import SnapKit
import UIKit

class TodoItemTableViewCell: UITableViewCell {
    // MARK: - Private properties
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 17)
        label.text = "Name"
        return label
    }()

    private lazy var dueDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .gray
        label.font = .systemFont(ofSize: 15)
        label.text = "In 4 days"
        return label
    }()

    private lazy var checkImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 12.5
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "UnCheck")
        return imageView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        stackView.backgroundColor = .clear

        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(dueDateLabel)

        return stackView
    }()

    // MARK: - Lifecycles
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    // MARK: - Public methods
    func updateUI(_ item: TodoItem) {
        nameLabel.text = item.name
        dueDateLabel.text = item.isDone ? "Done!" : item.dueDate.displayString
        checkImage.image = item.isDone ? UIImage(named: "Check") : UIImage(named: "UnCheck")
        contentView.alpha = item.isDone ? 0.5 : 1
        dueDateLabel.textColor = item.isDue ? .red : .gray
    }

    // MARK: - Private methods
    private func setupView() {
        backgroundColor = .white
        contentView.backgroundColor = .white

        contentView.addSubview(checkImage)
        contentView.addSubview(stackView)

        setConstraints()
    }

    private func setConstraints() {
        checkImage.snp.makeConstraints { make in
            make.size.equalTo(25)
            make.leading.top.equalToSuperview().offset(8)
        }

        stackView.snp.makeConstraints { make in
            make.leading.equalTo(checkImage.snp.trailing).offset(8)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}
