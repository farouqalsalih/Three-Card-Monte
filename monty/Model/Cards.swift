//
//  Cards.swift
//  monty
//
//  Created by Farouq Alsalih on 10/17/22.
//

import Foundation

class Card: ObservableObject{
    var cards:[card] = [card(image: "x", ace: false), card(image: "x", ace: false), card(image: "ace", ace: true)]
    
}

class Game {
    
}

struct card : Identifiable{
    var id = 0
    var image : String
    var ace:Bool
}
