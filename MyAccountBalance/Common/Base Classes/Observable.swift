//
//  Observable.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/22.
//

import Foundation

@propertyWrapper
class Observable<T> {
    var projectedValue: Observable<T> { self }
    var wrappedValue: T { didSet { fire() } }
    private var events: [String: (T) -> Void] = [:]
    private var childs: [Any] = []
    
    init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        events = [:]
    }
    
    func fire() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            for event in self.events {
                event.value(self.wrappedValue)
            }
        }
    }
    
    func addObserver(id: String, event: @escaping (T) -> Void) {
        events[id] = event
    }
    
    func addObserverWithOldValue(id: String, event: @escaping (T) -> Void) {
        events[id] = event
        event(wrappedValue)
    }
    
    func removeObserver(id: String) {
        events[id] = nil
    }
    
    func removeAllObservers() {
        events.removeAll()
    }
    
    func transform<X>(_ transform: @escaping (T) -> X) -> Observable<X> {
        let child = TransformObservable(parent: self, transform: transform)
        childs.append(child)
        return child
    }
}

class TransformObservable<FROM, TO>: Observable<TO> {
    weak var parentObservable: Observable<FROM>?
    var transform: (FROM) -> TO
    
    init(parent: Observable<FROM>, transform: @escaping (FROM) -> TO) {
        parentObservable = parent
        self.transform = transform
        
        super.init(wrappedValue: transform(parent.wrappedValue))
        let id = Unmanaged.passUnretained(self).toOpaque()
        parentObservable?.addObserver(id: "CHILD\(id)", event: { [weak self] value in
            guard let self = self else { return }
            self.wrappedValue = self.transform(value)
        })
    }
}

