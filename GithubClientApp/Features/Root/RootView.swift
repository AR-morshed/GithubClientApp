//
//  RootView.swift
//  GithubClientApp
//
//  Created by Arman Morshed on 9/6/25.
//

import ComposableArchitecture
import SwiftUI

public struct RootView: View {
  let store: StoreOf<Root>

  public var body: some View {
    WithPerceptionTracking {
      switch store.scope(state: \.destination, action: \.destination).case {
      case let .splash(store):
        SplashView(store: store)

      case let .userList(store):
        UserListView(store: store)
      }
    }
  }
}
