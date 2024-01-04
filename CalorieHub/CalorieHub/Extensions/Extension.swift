//
//  Extension.swift
//  CalorieHub
//
//  Created by Kein Li on 12/31/23.
//

import Foundation

// Mark : Workaround for textfield binding to optional type
extension Optional where Wrapped == String {
    var _bound: String? {
        get {
            return self
        }
        set {
            self = newValue
        }
    }
    public var bound: String {
        get {
            return _bound ?? ""
        }
        set {
            _bound = newValue.isEmpty ? nil : newValue
        }
    }
}


extension String : Identifiable {
    public var id: String {self}
}
