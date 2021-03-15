//
//  TodoViewController.swift
//  Todo
//
//  Created by Triet M1 Macbook Pro on 15.3.2021.
//

import Combine
import SnapKit
import UIKit

class TodoViewController: UIViewController {
    // MARK: - Dependencies
    var viewModel: TodoViewModel

    // MARK: - Init
    init(viewModel: TodoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = UIView()
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(TodoItemTableViewCell.self, forCellReuseIdentifier: "TodoItemTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    private var items = [TodoItem]() {
        didSet {
            tableView.reloadDataAnimated()
        }
    }
    private var bag = Set<AnyCancellable>()

    private var datePicker = UIDatePicker()
    private let toolBar = UIToolbar()

    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        binding()
        viewModel.getItemList()
    }

    // MARK: - Private methods
    private func setupUI() {
        title = "TODO"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        view.backgroundColor = .white
        view.addSubview(tableView)
        setupConstraint()
    }

    private func setupConstraint() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func binding() {
        viewModel.$items.sink { [weak self] items in
            self?.items = items
        }.store(in: &bag)
    }

    private func deleteItem(at indexPath: IndexPath) {
        viewModel.deleteItem(at: indexPath)
    }

    @objc
    private func addButtonTapped() {
        addItem()
    }

    private func addItem(_ indexPath: IndexPath? = nil) {
        let alertController = UIAlertController(
            title: indexPath != nil ? "Edit Item" : "Add New Item",
            message: nil,
            preferredStyle: .alert
        )

        let addAction = UIAlertAction(
            title: indexPath != nil ? "Edit" : "Add",
            style: .default
        ) { [weak self] _ in
            let name = alertController.textFields![0].text
            let dueDateString = alertController.textFields![1].text

            guard let name = name,
                  let dueDateString = dueDateString,
                  !name.isEmpty,
                  !dueDateString.isEmpty
            else { return }

            let dueDate = dueDateString.date
            let newItem = TodoItem(
                id: UUID().uuidString,
                createdDate: Date(),
                dueDate: dueDate,
                name: name,
                isDone: false
            )
            if let indexPath = indexPath {
                self?.viewModel.updateItem(at: indexPath, with: name, and: dueDate)
            } else {
                self?.viewModel.addItem(newItem)
            }
        }

        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel
        )

        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        alertController.preferredAction = addAction

        alertController.addTextField { [weak self] textField in
            textField.placeholder = "Name"
            textField.autocorrectionType = .no
            textField.keyboardType = .namePhonePad
            if let indexPath = indexPath,
               let item = self?.items[indexPath.row] {
                textField.text = item.name
            }
        }

        alertController.addTextField { [weak self] textField in
            textField.placeholder = "Number of days"
            textField.autocorrectionType = .no
            textField.keyboardType = .numberPad
            if let indexPath = indexPath,
               let item = self?.items[indexPath.row] {
                textField.text = "\(Calendar.current.numberOfDaysBetween(Date(), and: item.dueDate))"
            }
        }

        present(alertController, animated: true)
    }
}

extension TodoViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TodoItemTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.selectionStyle = .none
        cell.updateUI(items[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard !items[indexPath.row].isDone else { return nil }

        let action = UIContextualAction(
            style: .normal,
            title: "Mark as done"
        ) { [weak self] _, _, completion in
            self?.viewModel.updateItemState(at: indexPath)
            completion(true)
        }
        action.backgroundColor = .blue

        let swipeAction = UISwipeActionsConfiguration(actions: [action])
        return swipeAction
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(
            style: .normal,
            title: "Delete"
        ) { [weak self] _, _, completion in
            self?.deleteItem(at: indexPath)
            completion(true)
        }
        deleteAction.backgroundColor = .red

        let editAction = UIContextualAction(
            style: .normal,
            title: "Edit"
        ) { [weak self] _, _, completion in
            self?.addItem(indexPath)
            completion(true)
        }
        editAction.backgroundColor = .black

        let actions = [
            deleteAction,
            items[indexPath.row].isDone ? nil : editAction
        ].compactMap({$0})
        let swipeAction = UISwipeActionsConfiguration(actions: actions)
        return swipeAction
    }
}
