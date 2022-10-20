//
//  Cards.swift
//  monty
//
//  Created by Farouq Alsalih on 10/17/22.
//

import Foundation

class Card: ObservableObject{
    var cards:[card] = [card(id: 0, image: "x", ace: false), card(id: 1, image: "x", ace: false), card(id: 2, image: "ace", ace: true)]
    
}

class Game :ObservableObject {
    @Published var player = 0
    @Published var house = 0
    @Published var win: Bool
    var cards:[card]
    
    init(){
        let obj = Card()
        win = false
        cards = obj.cards
        newGame()
    }
    
    func newGame(){
        
        cards.shuffle()
        
    }
    
    func toggle(_ id: Int) {
        if cards[id].ace == false {
            house += 3
            win = false
        } else {
            player+=3
            win = true
        }
        
    }
    
    
}

struct card : Identifiable{
    var id = 0
    var image : String
    var ace:Bool
}
