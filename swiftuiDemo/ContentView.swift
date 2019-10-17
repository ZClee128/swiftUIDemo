//
//  ContentView.swift
//  swiftuiDemo
//
//  Created by lee on 2019/10/8.
//  Copyright © 2019 lee. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct ContentView: View {
    @State private var name: String = "Tim"
    @State var show = false
    @State var viewState = CGSize.zero
    @available(iOS 13.0.0, *)
    var body: some View {
        ZStack{
            titleView()
                .blur(radius: show ? 20 : 0)
            
            bottomView()
                .blur(radius: show ? 20 : 0)
            
            subCard(text: "three")
                .frame(width: 340, height: 220)
                .background(Color.blue)
                .cornerRadius(30)
                .offset(x: 0, y: -70)
                .scaleEffect(0.85)
                .rotationEffect(Angle(degrees: show ? 20 : 0))
                .offset(x: show ? viewState.width+60 : 0, y: show ? viewState.height - 200 : 0)
                .animation(.spring())
            subCard()
                .frame(width: 340, height: 220)
                .background(show ? Color("mainColor") : Color.red)
                .cornerRadius(30)
                .offset(x: 0, y: -40)
                .scaleEffect(0.90)
                .rotationEffect(Angle(degrees: show ? 10 : 0))
                .offset(x: show ? viewState.width+20 : 0, y: show ? viewState.height - 100 : 0)
                .animation(.spring())
            
            
            mainCard()
                .offset(x: viewState.width, y: viewState.height)
                .rotationEffect(Angle(degrees: show ? 30 : 0))
                .onTapGesture {
                    self.show.toggle()
            }
            .gesture(
                //                手势改变拖动变化
                DragGesture()
                    .onChanged({ (value) in
                        self.viewState = value.translation
                        self.show = true
                    })
                    .onEnded({ (value) in
                        self.viewState = CGSize.zero
                        self.show = false
                    })
            )
                .animation(.easeIn)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @available(iOS 13.0.0, *)
    static var previews: some View {
        ContentView()
    }
}



struct mainCard: View {
    @available(iOS 13.0.0, *)
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("nihao")
                Spacer()
                Image(systemName: "pencil")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color.white)
            }
            .padding(.all)
            Image("card")
                .resizable()
        }
        .frame(width: 340.0, height: 220.0)
        .background(Color.yellow)
        .cornerRadius(30)
    }
}

struct subCard: View {
    var text = "two"
    @available(iOS 13.0.0, *)
    var body: some View {
        VStack{
            Text(text)
        }
    }
}

struct titleView: View {
    @available(iOS 13.0.0, *)
    var body: some View {
        VStack{
            Text("标题")
            Image("images")
            Spacer()
        }
        .padding(.top)
    }
}

struct bottomView: View {
    @available(iOS 13.0.0, *)
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 60, height: 6)
                .cornerRadius(3)
                .opacity(0.1)
            Text("slkdjlsjdfjksjdlfkjksjkfjskljfkljsdkljkfjslkjdkljskljklfjdslkjkfjskjljflksjkjflksjlfjlsj")
                .multilineTextAlignment(.leading)
                .lineLimit(10)
            Spacer()
        }
        .padding()
        .frame(minWidth: 0 , maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(20)
        .offset(x: 0, y: 600)
        .shadow(radius: 20)
    }
}
