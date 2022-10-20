//
//  ContentView.swift
//  monty
//
//  Created by Farouq Alsalih on 10/17/22.
//

import SwiftUI

struct CardFrontView : View {
    let width : CGFloat
    let height : CGFloat
    let image:String
    
    @Binding var degree : Double

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.blue)
                .frame(width: width, height: height)
                .shadow(color: .gray, radius: 2, x: 0, y: 0)

            Image(image)
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(.red)

        }.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

struct CardBack : View {
    let width : CGFloat
    let height : CGFloat
    @Binding var degree : Double

    var body: some View {
        ZStack {
//            RoundedRectangle(cornerRadius: 20)
//                .fill(.blue.opacity(0.2))
//                .frame(width: width, height: height)
//                .shadow(color: .gray, radius: 2, x: 0, y: 0)

            Image("card back red")
                .resizable()
                .frame(width: width, height: height)
                .foregroundColor(.blue.opacity(0.7))

        }.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))

    }
}

struct ContentView: View {
    @StateObject private var cards = Game()
    @State var arr = [(back: 0.0, front: -90.0), (back: 0.0, front: -90.0), (back: 0.0, front: -90.0)]
//    @State var isFlipped = false
    @State var flipped:[Bool] = [false, false, false]
    @State var win:Bool = false

    let durationAndDelay : CGFloat = 0.3
    
    func flipCard (a : Int) {
            flipped[a] = !flipped[a]
            if flipped[a] {
                withAnimation(.linear(duration: durationAndDelay)) {
                    arr[a].0 = 90
                }
                withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                    arr[a].1 = 0
                }
            } else {
                withAnimation(.linear(duration: durationAndDelay)) {
                    arr[a].1 = -90
                }
                withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                    arr[a].0 = 0
                }
            }
        }
    
    func flipCards(){
        for i in 0...2 {
            if(flipped[i]){
                withAnimation(.linear(duration: durationAndDelay)) {
                    arr[i].1 = -90
                }
                withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                    arr[i].0 = 0
                }
                
            }
        }
    }
    
    var body: some View {
        
        GeometryReader{ geo in
            VStack{
                LazyVGrid(columns: [GridItem(.fixed(geo.size.width/4)),GridItem(.fixed(geo.size.width/4)),GridItem(.fixed(geo.size.width/4))]){
                    
                    ZStack{
                        CardFrontView(width: geo.size.width/4, height: geo.size.height/1.4, image: cards.cards[0].image,
                                      degree: $arr[0].1)
                        CardBack(width: geo.size.width/4, height: geo.size.height/1.4, degree: $arr[0].0)
                    }.onTapGesture {
                        if(!cards.win){
                            cards.toggle(0)
//                            win = cards.win
                            flipCard(a: 0)
                        }
                    }
                    
                    ZStack{
                        CardFrontView(width: geo.size.width/4, height: geo.size.height/1.4,
                            image: cards.cards[1].image,
                            degree: $arr[1].1)
                        CardBack(width: geo.size.width/4, height: geo.size.height/1.4, degree: $arr[1].0)
                    }.onTapGesture {
                        if(!cards.win){
                            cards.toggle(1)
                            win = cards.win
                            flipCard(a: 1)
                        }
                    }
                    
                    ZStack{
                        CardFrontView(width: geo.size.width/4, height: geo.size.height/1.4,
                                      image: cards.cards[2].image,degree: $arr[2].1)
                        CardBack(width: geo.size.width/4, height: geo.size.height/1.4, degree: $arr[2].0)
                    }.onTapGesture {
                        if(!cards.win){
                            cards.toggle(2)
                            win = cards.win
                            flipCard(a: 2)
                        }
                    }
                    
                }.padding()
                
                ZStack {
                    Color(.orange)
                    
                    HStack {
                        VStack {
                            HStack{
                                Text("Player Score")
                                    .font(.body)
                                Text("")
                            }
                            Text("")
                        }
                        .foregroundColor(.white)
                        .padding()
                        
                        Spacer()
                        
                        Button("Play Again") {
                            flipCards()
                            cards.newGame()
                            win = false
                        }
                        .padding()

                    }
                }
            }
            WinView(gameOver: win, height: geo.size.height)
        }
        
        
    }
}

struct WinView: View {
    
    var gameOver: Bool
    var height: CGFloat
    
    var body: some View {
        Text("You Won!")
            .font(.custom("Times", size: 98))
            .foregroundColor(.black)
            .background(.brown)
            .padding()
            .offset(y: gameOver ? 0.0 : -height)
            .animation(.interpolatingSpring(stiffness: 200, damping: 12), value: gameOver)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
