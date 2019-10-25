//
//  pageView.swift
//  swiftuiDemo
//
//  Created by lee on 2019/10/25.
//  Copyright © 2019 lee. All rights reserved.
//

import SwiftUI

struct PageView<Page: View>: View {
    var viewControllers: [UIHostingController<Page>]
    @State var currentPage = 0
    @State var timer = Timer.publish (every: 5, on: .current, in: .common).autoconnect()
    init(_ views: [Page]) {
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            PageViewController(controllers: viewControllers, currentPage: $currentPage)
            PageControl(numberOfPages: viewControllers.count, currentPage: $currentPage)
                .padding(.trailing)
        }.onReceive(timer) { (date) in
            self.currentPage += 1
            if(self.currentPage > self.viewControllers.count - 1 ){
                self.currentPage = 0
            }
        }
    }
}


struct PageView_Preview: PreviewProvider {
    static var previews: some View {
        PageView(pages.map{FeatureCard(species: $0)}).aspectRatio(3/2, contentMode: .fit)
    }
}


let pages = [
    Species(image: Image("card"), name: "bob", description: "apple"),
    Species(image: Image("images"), name: "may", description: "apple"),
    Species(image: Image("card"), name: "jack", description: "apple")
]
