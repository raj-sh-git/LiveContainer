//
//  MultitaskManager.swift
//  LiveContainer
//
//  Created by s s on 2026/3/20.
//

enum MultitaskMode : Int {
    case virtualWindow = 0
    case nativeWindow = 1
}

@objc class MultitaskManager : NSObject {
    static private let lock = NSLock()
    static private var usingMultitaskContainers : [String] = []
    
    @objc class func registerMultitaskContainer(container: String) {
        lock.lock()
        defer { lock.unlock() }
        if !usingMultitaskContainers.contains(container) {
            usingMultitaskContainers.append(container)
        }
    }
    
    @objc class func unregisterMultitaskContainer(container: String) {
        lock.lock()
        defer { lock.unlock() }
        usingMultitaskContainers.removeAll(where: { c in
            return c == container
        })
    }
    
    @objc class func isUsing(container: String) -> Bool {
        lock.lock()
        defer { lock.unlock() }
        return usingMultitaskContainers.contains { c in
            return c == container
        }
    }
    
    @objc class func isMultitasking() -> Bool {
        lock.lock()
        defer { lock.unlock() }
        return !usingMultitaskContainers.isEmpty
    }
}
