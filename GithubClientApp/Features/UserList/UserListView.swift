//
//  UserListView.swift
//  GithubClientApp
//
//  Created by Arman Morshed on 9/6/25.
//

import ComposableArchitecture
import SwiftUI

struct UserListView: View {
  @Perception.Bindable var store: StoreOf<UserListFeature>

  var body: some View {
    WithPerceptionTracking {
      NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
        ZStack {
          VStack(alignment: .leading, spacing: 16) {
            if let user = store.loginUser {
              TopUserInfoView(user: user)
            }

            if store.showLoader {
              ProgressView()
                .padding()
            } else {
              Text(!store.users.isEmpty ? "Developers" : "")
                .font(.headline)
                .padding(.horizontal)

              List {
                ForEach(store.users, id: \.id) { user in
                  userRow(user: user)
                }
                .listRowBackground(
                  RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(Color.gray.opacity(0.2))
                    .padding(
                      EdgeInsets(top: 2, leading: 8, bottom: 2, trailing: 8))
                )
                .listRowSeparator(.hidden)
              }
              .listStyle(.plain)
              .scrollIndicators(.hidden)
            }
          }

          if store.users.isEmpty && !store.showLoader {
            ErrorView(
              title: "No Users Found",
              message:
                "Looks like we couldn’t find any users. Please check your internet or try again.",
              retryAction: {
                store.send(.view(.onAppear))
              }
            )
          }
        }
        .onAppear {
          store.send(.view(.onAppear))
        }
      } destination: { store in
        switch store.case {
        case let .userDetails(store):
          UserDetailsView(store: store)
        }
      }
    }
  }

  @ViewBuilder
  private func userRow(user: User) -> some View {
    WithPerceptionTracking {
      Button {
        store.send(.view(.navigateToUserDetails(user)))
      } label: {
        UserListRow(
          user: user,
          isLast: user == store.users.last,
          onAppear: {
            store.send(.internal(.fetchGithubUsers))
          }
        )
        .frame(height: 40)
      }
    }
  }
}

#Preview {
  let store = Store(initialState: UserListFeature.State()) {
    UserListFeature()
  }
  UserListView(store: store)
}
