//
//  UserListFeature.swift
//  GithubClientApp
//
//  Created by Arman Morshed on 9/6/25.
//

import ComposableArchitecture

@Reducer
struct UserListFeature {
  @Dependency(\.networkClient) var networkClient

  @Reducer
  enum Path {
    case userDetails(UserDetailsFeature)
  }

  @ObservableState
  struct State {
    var showLoader = false
    var loginUser: User?
    var users: [User] = []
    let perPage: Int = 30
    var since: Int = 1
    var hasMoreData: Bool = true
    var path = StackState<Path.State>()
  }

  enum Action {
    case view(ViewAction)
    case `internal`(InternalAction)
    case path(StackActionOf<Path>)

    enum ViewAction {
      case onAppear
      case navigateToUserDetails(User)
    }

    enum InternalAction {
      case fetchLoginUserInfo
      case fetchGithubUsers
      case loginUserResponse(Result<User, any Error>)
      case fetchGithubUsersResponse(Result<[User], any Error>)
    }
  }

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .view(.onAppear):
        state.showLoader = true
        state.since = 1
        state.hasMoreData = true
        state.users = []

        return .send(.internal(.fetchLoginUserInfo)).concatenate(
          with: .send(.internal(.fetchGithubUsers)))

      case let .view(.navigateToUserDetails(user)):
        state.path.append(.userDetails(.init(user: user)))
        return .none

      case .internal(.fetchLoginUserInfo):
        return .run { send in
          await send(
            .internal(
              .loginUserResponse(
                Result {
                  try await networkClient.fetchLoginUser()
                })))
        }

      case .internal(.fetchGithubUsers):
        guard state.hasMoreData else {
          return .none
        }

        return .run { [state = state] send in
          await send(
            .internal(
              .fetchGithubUsersResponse(
                Result {
                  try await networkClient.fetchUsers(state.perPage, state.since)
                })))
        }

      case let .internal(.loginUserResponse(.success(user))):
        state.loginUser = user
        return .none

      case .internal(.loginUserResponse(.failure(_))):
        return .none

      case let .internal(.fetchGithubUsersResponse(.success(users))):
        state.showLoader = false

        if users.isEmpty {
          state.hasMoreData = false
          return .none
        }

        state.users += users
        state.since = users.last?.id ?? 1

        if users.count < state.perPage {
          state.hasMoreData = false
        }

        return .none

      case .internal(.fetchGithubUsersResponse(.failure(_))):
        state.showLoader = false
        return .none

      case let .path(action):
        switch action {
        default:
          return .none
        }
      }
    }
    .forEach(\.path, action: \.path)
  }
}
