//
//  Listview.swift
//  swiftuiDemo
//
//  Created by zclee on 2019/10/22.
//  Copyright © 2019 lee. All rights reserved.
//

import SwiftUI

struct Listview: View {
    var data = ListData
    var body: some View {
        NavigationView {
            List(data){item in
                NavigationLink(destination: Text(item.title)) {
                    Image(item.image)
                        .resizable()
                        .frame(width: 50, height: 50)
                    VStack {
                        Text(item.title)
                        Text(item.subTitle)
                    }
                }
                .padding()
            }
            .navigationBarTitle("List")
        }
    }
}

struct Listview_Previews: PreviewProvider {
    static var previews: some View {
        Listview()
    }
}


struct ListModel: Identifiable {
    var id = UUID()
    var title: String
    var image: String
    var subTitle: String
}

let ListData = [
    ListModel(title: "1", image: "images", subTitle: "a"),
    ListModel(title: "2", image: "images", subTitle: "b"),
    ListModel(title: "3", image: "images", subTitle: "c"),
    ListModel(title: "4", image: "images", subTitle: "d"),
    ListModel(title: "5", image: "images", subTitle: "e"),
]
