import Foundation
import Combine

let publisher = [0, 1, 2, 3, 4].publisher

let publisher1 = (0...5).publisher

let publisher2 = Just(2)

let publisher3 = NotificationCenter.default.publisher(for: Notification.Name("MyNotification"), object: nil)

class MyObject {
    @Published var word = ""
}

//: [Next](@next)
