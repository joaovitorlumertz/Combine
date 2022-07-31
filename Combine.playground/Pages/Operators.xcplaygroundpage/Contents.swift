import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()
//: [Previous](@previous)

/*: Em Combine, chamamos os métodos que executam uma operação em valores provenientes de um Publisher de “operadores”.
Cada operador Combine retorna um Publisher.
 - Operators montam uma cadeia de republishers que processa elementos produzidos por publishers upstream.
 */

// Transforming:
example(of: "map") {
    let publisher = (1...3).publisher
    
    publisher
        .map { $0 * 2 }
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
}

example(of: "encadeando operadores") {
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
