//
//  pageView.swift
//  swiftuiDemo
//
//  Created by lee on 2019/10/25.
//  Copyright © 2019 lee. All rights reserved.
//

import SwiftUI
import Combine

struct PageView<Page: View>: View {
    
    var viewControllers: [UIHostingController<Page>]
    let timer = TimePublisher()
    @State var currentPage = 0
    
    
    init(_ views: [Page]) {
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            PageViewController(controllers: viewControllers, currentPage: $currentPage)
            PageControl(numberOfPages: viewControllers.count, currentPage: $currentPage)
                .padding(.trailing)
        }.onReceive(timer.currentTimePublisher) { (date) in
            if self.currentPage < self.viewControllers.count-1 {
                self.currentPage += 1
            } else {
                self.currentPage = 0
            }
        }
    }
}


class TimePublisher {
    let currentTimePublisher = Timer.TimerPublisher(interval: 5, runLoop: .main, mode: .default)
    let cancelable: AnyCancellable?
    init() {
        self.cancelable = currentTimePublisher.connect() as? AnyCancellable
    }
    deinit {
        self.cancelable?.cancel()
    }
}

struct PageView_Preview: PreviewProvider {
    static var previews: some View {
        PageView(pages.map{FeatureCard(species: $0)}).aspectRatio(3/2, contentMode: .fit)
    }
}


let pages = [
    Species(image: Image("card"), name: "bob", description: "77"),
    Species(image: Image("images"), name: "may", description: "88"),
    Species(image: Image("card"), name: "jack", description: "99")
]
