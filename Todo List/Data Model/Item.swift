//
//  Item.swift
//  Todo List
//
//  Created by liroy yarimi on 30.5.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import Foundation

class Item : Codable {// Encodable, Decodable{ //for save and load
    
    var title : String = ""
    var done : Bool = false
}
