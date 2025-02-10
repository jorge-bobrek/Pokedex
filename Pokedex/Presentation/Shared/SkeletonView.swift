//
//  SkeletonView.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 5/10/24.
//

import SwiftUI

struct SkeletonView: View {
    @State var showAnimation = false
    var cellFrame: (width: CGFloat, heigth: CGFloat) = (UIScreen.main.bounds.size.width*0.45, UIScreen.main.bounds.size.width*0.75)
    var cornerRadius: CGFloat = 10
    var borderColor: Color = .clear

    var body: some View {
        VStack {
            ZStack {
                Color.primary.opacity(0.1)
                    .frame(height: self.cellFrame.heigth)
                    .cornerRadius(self.cornerRadius)
                Color.secondary.opacity(0.1).cornerRadius(self.cornerRadius).mask(
                        Rectangle()
                            .fill(
                                LinearGradient(gradient: .init(colors: [.clear, .white, .clear]), startPoint: .top, endPoint: .bottom)
                            )
                            .rotationEffect(.init(degrees: 90))
                            .offset(x: self.showAnimation ? self.cellFrame.width*1.3 : -self.cellFrame.width*1.3)
                            .frame(width: (self.cellFrame.heigth))
                    )
            }.onAppear {
                withAnimation(Animation.default.speed(0.15).delay(0).repeatForever(autoreverses: false)) {
                    self.showAnimation.toggle()
                }
            }.frame(width: self.cellFrame.width, height: self.cellFrame.heigth)
        }
    }
}

struct SkeletonView_Previews: PreviewProvider {
    static var previews: some View {
        SkeletonView()
    }
}
