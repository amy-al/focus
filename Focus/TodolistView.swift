//
//  TodolistView.swift
//  Focus
//
//  Created by Amy Li on 2023/09/18.
//

import Foundation
import SwiftUI

struct TodoItem: Identifiable, Equatable {
    var id = UUID()
    var text: String
    var isCompleted = false
}

struct TodolistView: View {
    @State private var newItemText = ""
    @State private var todos: [TodoItem] = []

    var body: some View {
        VStack {
            HStack {
                TextField("Add a new item", text: $newItemText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: addItem) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.blue)
                        .font(.title)
                }
            }
            .padding()

            List {
                ForEach(todos) { todo in
                    HStack {
                        Button(action: { toggleCompletion(for: todo) }) {
                            Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(todo.isCompleted ? .green : .blue)
                                .font(.title)
                        }
                        Text(todo.text)
                            .strikethrough(todo.isCompleted, color: .gray)
                            .onTapGesture {
                                toggleCompletion(for: todo)
                            }
                        Spacer()
                        if let index = todos.firstIndex(of: todo) {
                            Button(action: { removeItem(at: index) }) {
                                Image(systemName: "trash.circle.fill")
                                    .foregroundColor(.red)
                                    .font(.title)
                            }
                        }
                    }
                }
                .onMove(perform: moveItem)
                .onDelete(perform: deleteItem)
            }
        }
        .navigationBarTitle("Todo List")
        .navigationBarItems(trailing: EditButton())
    }

    func addItem() {
        if !newItemText.isEmpty {
            todos.append(TodoItem(text: newItemText))
            newItemText = ""
        }
    }

    func removeItem(at index: Int) {
        todos.remove(at: index)
    }

    func toggleCompletion(for todo: TodoItem) {
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[index].isCompleted.toggle()
        }
    }

    func moveItem(from source: IndexSet, to destination: Int) {
        todos.move(fromOffsets: source, toOffset: destination)
    }

    func deleteItem(at offsets: IndexSet) {
        todos.remove(atOffsets: offsets)
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TodolistView()
        }
    }
}

