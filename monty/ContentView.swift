//
//  ContentView.swift
//  monty
//
//  Created by Farouq Alsalih on 10/17/22.
//

import SwiftUI

struct ContentView: View {
    
    
    
    var body: some View {
        
        GeometryReader{ geo in
            ZStack{
//                Color(.black).edgesIgnoringSafeArea(.all)
                
                LazyVGrid(columns: [GridItem(.fixed(geo.size.width/5)),GridItem(.fixed(geo.size.width/5)),GridItem(.fixed(geo.size.width/5))]){
                    
                    ForEach(model.cards) { card in
                        CardView(card: $model.cards[card.id])
                            .aspectRatio(1, contentMode: .fit)
                            .cornerRadius(8)
                            .clipShape(Rectangle())
                            .onTapGesture {
                                if !card.faceUp {
                                    model.toggleFaceUp(card.id)
                                }
                            }
                            .animation(card.hidden ? nil : .easeIn(duration: 0.25), value: card.faceUp)
                    }
                }
            }
            
        }
        
        
//        GeometryReader { geo in
//            ZStack {
//                VStack {
//                    VStack { GameView(model: model) }
//                }
//                WinView(gameOver: model.gameOver, height: geo.size.height)
//            }
//        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
