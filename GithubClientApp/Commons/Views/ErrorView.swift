//
//  ErrorView.swift
//  GithubClientApp
//
//  Created by Arman Morshed on 12/6/25.
//

import SwiftUI

struct ErrorView: View {
  let title: String
  let message: String
  var retryAction: (() -> Void)? = nil

  var body: some View {
    VStack(spacing: 16) {
      Image(systemName: "person.3.fill")
        .resizable()
        .scaledToFit()
        .frame(width: 80, height: 80)
        .foregroundColor(.gray.opacity(0.6))

      Text(title)
        .font(.title2.bold())
        .multilineTextAlignment(.center)

      Text(message)
        .font(.body)
        .foregroundColor(.secondary)
        .multilineTextAlignment(.center)
        .padding(.horizontal, 32)

      if let retryAction = retryAction {
        Button(action: retryAction) {
          Text("Try Again")
            .padding(.horizontal, 24)
            .padding(.vertical, 10)
            .background(Color.accentColor)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding(.top, 8)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .padding()
  }
}

#Preview {
  ErrorView(
    title: "No Users Found",
    message:
      "Looks like we couldn’t find any users. Please check your internet or try again."
  ) {
    print("Retry tapped")
  }
}
