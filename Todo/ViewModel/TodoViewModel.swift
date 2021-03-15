//
//  TodoViewModel.swift
//  Todo
//
//  Created by Triet M1 Macbook Pro on 15.3.2021.
//

import UIKit

class TodoViewModel {
    @Published public private(set) var items: [TodoItem] {
        didSet {
            storageService.addOrUpdateTodoList(items)
        }
    }

    // MARK: - Private properties
    private let storageService: StorageService

    // MARK: - Init
    init(
        storageService: StorageService
    ) {
        self.storageService = storageService
        self.items = []
    }

    // MARK: - Public methods
    func getItemList() {
        let currentItems = storageService.getTodoList()
        items = currentItems
    }

    func addItem(_ item: TodoItem) {
        var newItems = items
        newItems.append(item)
        items = newItems
    }

    func deleteItem(at indexPath: IndexPath) {
        var newItems = items
        newItems.remove(at: indexPath.row)
        items = newItems
    }

    func updateItemState(at indexPath: IndexPath) {
        var newItems = items
        let newItem = items[indexPath.row].toggleState()
        newItems.remove(at: indexPath.row)
        newItems.append(newItem)
        items = newItems
    }

    func updateItem(at indexPath: IndexPath, with name: String, and dueDate: Date) {
        var newItems = items
        let newItem = items[indexPath.row].updateName(name).updateDueDate(dueDate)
        newItems.remove(at: indexPath.row)
        newItems.append(newItem)
        items = newItems
    }
}
