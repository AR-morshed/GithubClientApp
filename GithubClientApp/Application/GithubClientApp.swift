//
//  GithubClientApp.swift
//  GithubClientApp
//
//  Created by Arman Morshed on 9/6/25.
//

import ComposableArchitecture
import SwiftUI

@main
struct GithubClientApp: App {
  let store = Store(initialState: Root.State()) {
    Root()
  }

  var body: some Scene {
    WindowGroup {
      RootView(store: store)
    }
  }
}
