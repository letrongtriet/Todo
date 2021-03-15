//
//  StorageService.swift
//  Todo
//
//  Created by Triet M1 Macbook Pro on 15.3.2021.
//

import Foundation

class StorageService {
    // MARK: - Private properties
    private let userDefault = UserDefaults.standard

    // MARK: - Public methods
    func addOrUpdateTodoList(_ items: [TodoItem]) {
        if let encoded = try? JSONEncoder().encode(items) {
            userDefault.set(encoded, forKey: AppPantry.StorageKey.todoList)
        }
    }

    func getTodoList() -> [TodoItem] {
        if let data = userDefault.object(forKey: AppPantry.StorageKey.todoList) as? Data,
           let todoList = try? JSONDecoder().decode([TodoItem].self, from: data) {
            return todoList
        }
        return []
    }
}
