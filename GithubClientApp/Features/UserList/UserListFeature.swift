//
//  UserListFeature.swift
//  GithubClientApp
//
//  Created by Arman Morshed on 9/6/25.
//

import ComposableArchitecture

@Reducer
struct UserListFeature {

  @ObservableState
  struct State {

  }

  enum Action {

  }

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      return .none
    }
  }
}
