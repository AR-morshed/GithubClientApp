//
//  UserDetailsFeature.swift
//  GithubClientApp
//
//  Created by Arman Morshed on 11/6/25.
//

import ComposableArchitecture
import Foundation

@Reducer
struct UserDetailsFeature {
  @Dependency(\.networkClient) var networkClient
  @Dependency(\.openURL) var openURL

  @Reducer
  enum Destination {
    case webView(WebViewFeature)
  }

  @ObservableState
  struct State {
    var showLoader = false
    let user: User
    var repos: [Repo] = []
    let perPage: Int = 30
    var page: Int = 1
    var hasMoreData: Bool = true
    @Presents var destination: Destination.State?

    init(user: User) {
      self.user = user
    }
  }

  enum Action {
    case view(ViewAction)
    case `internal`(InternalAction)

    @CasePathable
    enum ViewAction {
      case onAppear
      case destination(PresentationAction<Destination.Action>)
      case loadWebviewFor(repo: Repo)
      case closeButtonTapped
      case openInSafariTapped(URL)
    }

    enum InternalAction {
      case fetchRepos
      case fetchReposResponse(Result<[Repo], any Error>)
    }
  }

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .view(.onAppear):
        state.showLoader = true
        state.page = 1
        state.hasMoreData = true
        state.repos = []

        return .send(.internal(.fetchRepos))

      case .view(.destination):
        return .none

      case let .view(.loadWebviewFor(repo: repo)):
        if let repoURL = repo.url, let url = URL(string: repoURL) {
          state.destination = .webView(
            .init(title: "Repository summary", url: url))
        }
        return .none

      case let .view(.openInSafariTapped(url)):
        return .run { _ in await openURL(url) }

      case .view(.closeButtonTapped):
        state.destination = nil
        return .none

      case .internal(.fetchRepos):
        guard state.hasMoreData else {
          return .none
        }

        return .run { [state = state] send in
          await send(
            .internal(
              .fetchReposResponse(
                Result {
                  try await networkClient.fetchRepoList(
                    state.user.login, state.page, state.perPage)
                })))
        }

      case let .internal(.fetchReposResponse(.success(repos))):
        state.showLoader = false

        if repos.isEmpty {
          state.hasMoreData = false
          return .none
        }

        state.repos += repos
        state.page += 1

        if repos.count < state.perPage {
          state.hasMoreData = false
        }

        return .none

      case .internal(.fetchReposResponse(.failure(_))):
        state.showLoader = false
        return .none
      }
    }
    .ifLet(\.$destination, action: \.view.destination)
  }
}
