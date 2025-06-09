//
//  Root.swift
//  GithubClientApp
//
//  Created by Arman Morshed on 9/6/25.
//

import ComposableArchitecture

@Reducer
struct Root {

  @Reducer
  enum Destination {
    case splash(SplashFeature)
    case userList(UserListFeature)
  }

  @ObservableState
  struct State {
    var destination: Destination.State = .splash(.init())
  }

  enum Action {
    case destination(Destination.Action)
  }

  var body: some ReducerOf<Self> {
    Scope(state: \.destination, action: \.destination) {
      Destination.body
    }

    Reduce { state, action in
      switch action {
      case .destination(.splash(.delegate(.dismissSplash))):
        state.destination = .userList(.init())
        return .none
          
      default:
        return .none
      }
    }
  }
}
