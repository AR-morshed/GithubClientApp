//
//  SplashView.swift
//  GithubClientApp
//
//  Created by Arman Morshed on 9/6/25.
//

import ComposableArchitecture
import SwiftUI

struct SplashView: View {
  let store: StoreOf<SplashFeature>

  var body: some View {
    WithPerceptionTracking {
      ZStack {
        Color.black
          .opacity(0.5)

        Image.github
          .resizable()
          .frame(width: 124, height: 124, alignment: .center)
      }
      .onAppear {
        store.send(.onAppear, animation: .linear)
      }
      .ignoresSafeArea()
      .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
  }
}
