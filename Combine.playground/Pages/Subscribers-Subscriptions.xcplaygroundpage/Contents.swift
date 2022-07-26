import Foundation
//: [Previous](@previous)

example(of: "sink") {
    let publisher = [0, 1, 2, 3, 4].publisher

    let subscription = publisher
        .sink(
            receiveCompletion: { completion in
                print("Completion: \(completion)")
            },
            receiveValue: { value in
                print("Value: \(value)")
            }
        )

}

example(of: "assign") {
    class MyClass {
        var anInt: Int = 0 {
            didSet {
                print("anInt was set to: \(anInt)", terminator: "; ")
            }
        }
    }

    let myObject = MyClass()
    let myRange = (0...2)
    let subscription = myRange.publisher.assign(to: \.anInt, on: myObject)
}
//: [Next](@next)
