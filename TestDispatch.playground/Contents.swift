import Foundation

class ThreadSafe {
    let privateQueue = DispatchQueue(label: "label")
    let privateQueue = DispatchQueue(label: "label", attributes: .concurrent)
    
    var variable = "" {
        get {
            privateQueue.async(flags: .barrier) {
                variable
            }
        } set  {
            privateQueue.sync {
                variable = newValue
            }
        }
    }
}

let sef = Semaphore(value
