//
//  SplashFeature.swift
//  GithubClientApp
//
//  Created by Arman Morshed on 9/6/25.
//

import ComposableArchitecture

@Reducer
struct SplashFeature {
  @Dependency(\.mainQueue) var queue

  @ObservableState
  struct State {}

  enum Action {
    case onAppear
    case delegate(DelegateAction)

    enum DelegateAction {
      case dismissSplash
    }
  }

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        return .run { send in
          try await queue.sleep(for: .milliseconds(2000))
          await send(.delegate(.dismissSplash))
        }

      case .delegate:
        return .none
      }
    }
  }
}
