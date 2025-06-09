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
        Color.white

        //        Image.splashBackgroundLogo
        //          .resizable()
      }
      .onAppear {
        store.send(.onAppear, animation: .linear)
      }
      .ignoresSafeArea()
      .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
  }
}
