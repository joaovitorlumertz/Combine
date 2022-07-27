//: [Previous](@previous)

import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

// Filtering:
example(of: "filter") {
    let publisher = [0, 1, 2, 3, 4, 5, 6].publisher
    
    publisher
        .filter { $0 % 2 == 0 }
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
}

example(of: "first(where:)") {
    let publisher = [100, 200, 300, 400, 500].publisher
    
    publisher
        .first { $0 > 300 }
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
}

example(of: "last(where:)") {
    let publisher = [100, 200, 300, 400, 500].publisher
    
    publisher
        .last { $0 > 300 }
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
}

example(of: "last(where:) #2") {
    let subject = PassthroughSubject<Int, Never>()
    
    subject
        .last { $0 > 300 }
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
    
    subject.send(100)
    subject.send(200)
    subject.send(300)
    subject.send(400)
    subject.send(500)
    subject.send(completion: .finished)
}

// Combining:
example(of: "prepend(Output...)") {
    let publisher = [3, 4].publisher
    
    publisher
        .prepend(1, 2)
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
}

example(of: "merge(with:)") {
    let publisher1 = PassthroughSubject<Int, Never>()
    let publisher2 = PassthroughSubject<Int, Never>()
    
    publisher1
        .merge(with: publisher2)
        .sink(
            receiveCompletion: { _ in print("Completed") },
            receiveValue: { print($0) }
        )
        .store(in: &subscriptions)
    
    publisher1.send(1)
    publisher1.send(2)
    publisher2.send(3)
    publisher1.send(4)
    publisher2.send(5)
    
    publisher1.send(completion: .finished)
    publisher2.send(completion: .finished)
}

// Sequence:
example(of: "min") {
    let publisher = [1, 2, 3].publisher
    
    publisher
        .min()
        .sink(receiveValue: { print("min: \($0)") })
        .store(in: &subscriptions)
}

example(of: "max") {
    let publisher = [1, 2, 3].publisher
    
    publisher
        .max()
        .sink(receiveValue: { print("max: \($0)") })
        .store(in: &subscriptions)
}

example(of: "chaining") {
    let publisher1 = [1, 1, 2, 2, 3, 3].publisher
    let publisher2 = [4, 4, 5, 5, 6, 6].publisher
    
    let formatter = NumberFormatter()
    formatter.numberStyle = .spellOut
    
    publisher1
        .merge(with: publisher2)
        .removeDuplicates()
        .map { formatter.string(for: NSNumber(integerLiteral: $0)) ?? "" }
        .sink { print($0) }
        .store(in: &subscriptions)
}
