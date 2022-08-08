//
//  ArrayHelper.swift
//  Countries
//
//  Created by Emre Sarı on 8.08.2022.
//

import Foundation

class ArrayHelper {
    private init() { }
    static let sharedInstance = ArrayHelper()
    var collection = [String]()
    var collectionCode = [String]()
}
