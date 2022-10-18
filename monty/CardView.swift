//
//  CardView.swift
//  monty
//
//  Created by Farouq Alsalih on 10/17/22.
//

import SwiftUI

struct CardView: View {
    @Binding var card: Card

    
    var body: some View {
        ZStack {
            Color("CardBackground")
            
            Text(card.emoji)
                .font(.custom("Helvetica Neue", fixedSize: 56))
                .opacity(card.faceUp ? 1 : 0)
            
            Text(card.backside)
                .font(.custom("Helvetica Neue", fixedSize: 56))
                .opacity(card.faceUp ? 0 : 1)

        }
        .opacity(card.hidden ? 0 : 1)
        .rotation3DEffect(Angle(degrees: card.faceUp ? 180 : 0), axis: (x: 0, y: 1, z: 0))    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
