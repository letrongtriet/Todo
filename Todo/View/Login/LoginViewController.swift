//
//  LoginViewController.swift
//  Todo
//
//  Created by Triet M1 Macbook Pro on 15.3.2021.
//

import Combine
import UIKit

class LoginViewController: UIViewController {
    // MARK: - Dependencies
    var viewModel: LoginViewModel

    // MARK: - Init
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 22)
        label.text = "Welcome to another TODO app"
        return label
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setImage(nil, for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .systemBlue
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 8
        return button
    }()

    private var bag = Set<AnyCancellable>()

    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        binding()
        viewModel.checkState()
    }

    // MARK: - Private methods
    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(titleLabel)
        view.addSubview(loginButton)

        setupConstraint()
    }

    private func setupConstraint() {
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
        }

        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-8)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(70)
            make.centerX.equalToSuperview()
        }
    }

    private func binding() {
        viewModel
            .$state
            .sink { [weak self] state in
                self?.updateUIState(state)
            }.store(in: &bag)
    }

    private func updateUIState(_ state: LoginViewModel.State) {
        titleLabel.text = state.title
        loginButton.setTitle(state.buttonTitle, for: .normal)
    }

    @objc
    private func loginButtonTapped() {
        loginButton.animate()
        viewModel.handleButtonTapped()
    }
}
