//
//  Item.swift
//  Todoey
//
//  Created by MacBook Pro on 9/13/19.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import Foundation

class Item: Codable {
//class Item : Encodable, Decodable
    var title  : String = ""
    var done: Bool = false
}
