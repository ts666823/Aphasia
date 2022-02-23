//
//  Stack.swift
//  Aphasia
//
//  Created by 唐烁 on 2022/2/19.
//

import Foundation

struct Stack<A> {
    fileprivate var array: [[A]] = []
    
    // 1
    mutating func push(_ element: [A]) {
        // 2
        array.append(element)
    }
    
    // 1
    mutating func pop() -> [A]? {
        // 2
        return array.popLast()
    }
    
    mutating func isEmpty() -> Bool {
        // 2
        return array.isEmpty
    }
    
    func peek() -> [A]? {
        return array.last
    }
}

