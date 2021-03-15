//
//  TodoItem.swift
//  Todo
//
//  Created by Triet M1 Macbook Pro on 15.3.2021.
//

import Foundation

struct TodoItem: Codable {
    let id: String
    let createdDate: Date
    var dueDate: Date
    var name: String
    var isDone: Bool

    init(id: String, createdDate: Date, dueDate: Date, name: String, isDone: Bool) {
        self.id = id
        self.createdDate = createdDate
        self.dueDate = dueDate
        self.name = name
        self.isDone = isDone
    }

    func toggleState() -> TodoItem {
        .init(
            id: id,
            createdDate: createdDate,
            dueDate: dueDate,
            name: name,
            isDone: !isDone
        )
    }

    @discardableResult
    func updateName(_ name: String) -> TodoItem {
        .init(
            id: id,
            createdDate: createdDate,
            dueDate: dueDate,
            name: name,
            isDone: isDone
        )
    }

    @discardableResult
    func updateDueDate(_ dueDate: Date) -> TodoItem {
        .init(
            id: id,
            createdDate: createdDate,
            dueDate: dueDate,
            name: name,
            isDone: isDone
        )
    }

    var isDue: Bool {
        Date() >= dueDate
    }
}
