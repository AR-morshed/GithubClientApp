//
//  UserListView.swift
//  GithubClientApp
//
//  Created by Arman Morshed on 9/6/25.
//

import ComposableArchitecture
import SwiftUI

public struct UserListView: View {
  @Perception.Bindable var store: StoreOf<UserListFeature>

  public var body: some View {
    WithPerceptionTracking {
      Text("User List")
    }
    .ignoresSafeArea()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}
