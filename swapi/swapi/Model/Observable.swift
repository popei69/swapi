//
//  Observable.swift
//  swapi
//
//  Created by Benoit Pasquier on 20/2/20.
//  Copyright © 2020 Benoit Pasquier. All rights reserved.
//

import Foundation

protocol Identifiable {
    var id: String { get }
}

class Observable<T> {
    
    var value: T {
        didSet { notify() }
    }
    
    typealias CompletionHandler = (T) -> ()
    private var observers = [String: CompletionHandler]()
    
    init(_ value: T) {
        self.value = value
    }
    
    /// subscribe to observable, completion will be executed for any new values
    public func subscribe(_ observer: Identifiable, completion: @escaping CompletionHandler) {
        guard observers[observer.id] == nil else {
            return
        }
        observers[observer.id] = completion
    }
    
    /// "replay" subscribe as well and replay the latest value for the new observer
    public func replay(_ observer: Identifiable, completion: @escaping CompletionHandler) {
        self.subscribe(observer, completion: completion)
        self.notify(observer)
    }
    
    private func notify() {
        observers.forEach { $0.value(value) }
    }
    
    private func notify(_ observer: Identifiable) {
        observers[observer.id]?(value)
    }
}
