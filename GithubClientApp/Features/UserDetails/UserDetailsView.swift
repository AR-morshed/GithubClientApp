//
//  UserDetailsView.swift
//  GithubClientApp
//
//  Created by Arman Morshed on 11/6/25.
//

import ComposableArchitecture
import SwiftUI

struct UserDetailsView: View {
  @Perception.Bindable var store: StoreOf<UserDetailsFeature>

  var body: some View {
    WithPerceptionTracking {
      ScrollView {
        VStack(alignment: .leading, spacing: 16) {

          HStack(alignment: .center, spacing: 16) {
            UserAvatarView(store.user.avatarUrl, size: 80)

            VStack(alignment: .leading, spacing: 4) {
              Text(store.user.name ?? store.user.login)
                .font(.title2)
                .bold()

              Text("@\(store.user.login)")
                .font(.subheadline)
                .foregroundColor(.secondary)

              HStack(spacing: 16) {
                Label("\(store.user.followers ?? 0)", systemImage: "person.2")
                Label(
                  "\(store.user.following ?? 0)",
                  systemImage: "person.crop.circle.badge.checkmark")
              }
              .font(.caption)
              .foregroundColor(.secondary)
            }

            Spacer()
          }
          .padding(.horizontal)

          Divider()
            .padding(.horizontal)

          if store.showLoader {
            HStack {
              Spacer()
              ProgressView()
                .padding()
                .frame(alignment: .center)
              Spacer()
            }
          } else {
            VStack(alignment: .leading) {
              Text(!store.repos.isEmpty ? "Repositories" : "")
                .font(.headline)
                .padding(.horizontal)

              LazyVStack(spacing: 12) {
                ForEach(store.repos.filter { !($0.fork ?? true) }, id: \.id) {
                  repo in
                  Button {
                    store.send(.view(.loadWebviewFor(repo: repo)))
                  } label: {
                    RepoRowView(repo: repo)
                  }
                }
              }
              .padding(.horizontal)
            }
          }
        }
        .padding(.top)
      }
      .navigationTitle("User Details")
      .onAppear {
        store.send(.view(.onAppear))
      }
      .sheet(
        item: $store.scope(
          state: \.destination?.webView, action: \.view.destination.webView)
      ) { webStore in
        WithPerceptionTracking {
          WebViewNavigationStack(
            store: webStore, title: webStore.title,
            confirmationAction: {
              store.send(.view(.openInSafariTapped(webStore.url)))
            },
            cancellationAction: { store.send(.view(.closeButtonTapped)) })
        }
      }
    }
  }
}

#Preview {
  let store = Store(initialState: UserDetailsFeature.State(user: .mockOne)) {
    UserDetailsFeature()
  }
  UserDetailsView(store: store)
}
