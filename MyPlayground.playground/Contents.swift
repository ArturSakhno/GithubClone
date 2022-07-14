import UIKit

class A {
    var b = 0
    func closureFunc(completion: @escaping () -> ()) {
        completion()
    }
    
    func simpleFunc() {
        closureFunc {
            self.b = 1
        }
    }
}










