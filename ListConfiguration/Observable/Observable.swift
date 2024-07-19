//
//  Observable.swift
//  ListConfiguration
//
//  Created by 전준영 on 7/20/24.
//

import Foundation

class Observable<T> {
    
    var closure: ((T) -> Void)?
    
    var value: T {
        didSet{
            closure?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(closure: @escaping (T) -> Void) {
        self.closure = closure
        closure(value)
    }
}
