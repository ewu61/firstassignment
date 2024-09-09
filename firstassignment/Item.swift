//
//  Item.swift
//  firstassignment
//
//  Created by Eric Wu on 9/8/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
