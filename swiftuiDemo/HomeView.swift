//
//  HomeView.swift
//  swiftuiDemo
//
//  Created by lee on 2019/10/25.
//  Copyright © 2019 lee. All rights reserved.
//

import SwiftUI


let statusBarHeight = UIApplication.shared.statusBarFrame.height
let screen = UIScreen.main.bounds

struct HomeView: View {
    @State var show = false
    @State var showSettings = false
    @State var showProfile = false
    var body: some View {
        ZStack {
            
            ContentView()
                .frame(minWidth: 0, maxWidth: 712)
                .cornerRadius(30)
                .shadow(radius: 20)
                .animation(.spring())
                .offset(y: showProfile ? statusBarHeight + 40 : UIScreen.main.bounds.height)
            
            MenuButton(show: $show)
                .offset(x: -40, y: showProfile ? statusBarHeight : 80)
                .animation(.spring())
            
            MenuRight(show: $showProfile)
                .animation(.spring())
                .offset(x: -16, y: showProfile ? statusBarHeight : 88)
            menuView(show: $show, showSettings: $showSettings)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct MenuRow: View {
    
    var image = "creditcard"
    var text = "My Account"
    
    var body: some View {
        HStack {
            Image(systemName: image)
                .imageScale(.large)
                .foregroundColor(Color.red)
                .frame(width: 32, height: 32)
            
            Text(text)
                .font(.headline)
                .foregroundColor(Color.black)
            
            Spacer()
        }
    }
}

struct Menu: Identifiable {
   var id = UUID()
   var title: String
   var icon: String
}

let menuData = [
   Menu(title: "My Account", icon: "person.crop.circle"),
   Menu(title: "Settings", icon: "gear"),
   Menu(title: "Billing", icon: "creditcard"),
   Menu(title: "Team", icon: "person.2"),
   Menu(title: "Sign out", icon: "arrow.uturn.down")
]

struct menuView: View {
    var menu = menuData
    @Binding var show : Bool
    @Binding var showSettings :Bool
    var body: some View {
        HStack {
            VStack {
                ForEach(menu) { item in
                    if item.title == "Settings" {
                        Button(action: { self.showSettings.toggle() }) {
                            MenuRow(image: item.icon, text: item.title)
                            //                          .sheet(isPresented: self.$showSettings) { Settings() }
                        }
                    } else {
                        MenuRow(image: item.icon, text: item.title)
                    }
                }
                Spacer()
            }
            .padding(.top, 20)
            .padding(30)
            .frame(minWidth: 0, maxWidth: 360)
            .background(Color.white)
            .cornerRadius(30)
            .padding(.trailing, 60)
            .shadow(radius: 20)
            .rotation3DEffect(Angle(degrees: show ? 0 : 60), axis: (x: 0, y: 10.0, z: 0))
            .animation(.default)
            .offset(x: show ? 0 : -UIScreen.main.bounds.width)
            .onTapGesture {
                self.show.toggle()
            }
            Spacer()
        }
        .padding(.top, statusBarHeight)
    }
}

struct MenuButton: View {
   @Binding var show: Bool

   var body: some View {
    ZStack(alignment: .topLeading) {
         Button(action: { self.show.toggle() }) {
            HStack {
               Spacer()

               Image(systemName: "list.dash")
                  .foregroundColor(.primary)
            }
            .padding(.trailing, 18)
            .frame(width: 90, height: 60)
            .background(Color.white)
            .cornerRadius(30)
            .shadow(color: Color.gray, radius: 20, x: 0, y: 5)
         }
         Spacer()
      }
   }
}

struct CircleButton: View {

   var icon = "person.crop.circle"

   var body: some View {
      return HStack {
         Image(systemName: icon)
            .foregroundColor(.primary)
      }
      .frame(width: 44, height: 44)
      .background(Color.white)
      .cornerRadius(30)
      .shadow(color: Color.gray, radius: 20, x: 0, y: 5)
   }
}


struct MenuRight: View {

   @Binding var show: Bool
   @State var showUpdate = false

   var body: some View {
        ZStack(alignment: .topTrailing) {
         HStack {
            Button(action: { self.show.toggle() }) {
               CircleButton(icon: "person.crop.circle")
            }
            Button(action: { self.showUpdate.toggle() }) {
               CircleButton(icon: "bell")
                  .sheet(isPresented: self.$showUpdate) { Listview() }
            }
         }
         Spacer()
      }
   }
}
