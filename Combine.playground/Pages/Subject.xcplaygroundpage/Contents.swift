import Foundation
import Combine

//: [Previous](@previous)

example(of: "Subject #PassthroughSubject") {
    let subject = PassthroughSubject<String, Never>()

    let subscription = subject
        .sink(
            receiveCompletion: { print("Completion: \($0)") },
            receiveValue: { print("Value: \($0)") }
        )

    subject.send("Hello")
    subject.send("World")
    subject.send(completion: .finished)
    subject.send("!")
}


example(of: "Subject #CurrentValueSubject") {
    let subject = CurrentValueSubject<Int, Never>(0)

    let subscription = subject
        .sink(receiveValue: { print($0) })

    subject.send(1)
    subject.send(2)

    print("current value \(subject.value)")

    subject.value = 3

    print("current value \(subject.value)")
}

//: [Next](@next)
