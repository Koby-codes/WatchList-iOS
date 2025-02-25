//
//  Item.swift
//  Watchlist App v2.0
//
//  Created by Jad Kobrosly on 22/02/2025.
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
