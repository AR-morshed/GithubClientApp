//
//  UserAvatarView.swift
//  GithubClientApp
//
//  Created by Arman Morshed on 11/6/25.
//

import SwiftUI

struct UserAvatarView: View {
  let urlString: String?
  let size: CGFloat

  init(_ urlString: String?, size: CGFloat) {
    self.urlString = urlString
    self.size = size
  }

  var body: some View {
    Group {
      if let urlString, let url = URL(string: urlString) {
        AsyncImage(url: url) { phase in
          switch phase {
          case .empty:
            ProgressView()
              .frame(width: size, height: size)

          case .success(let image):
            image
              .resizable()
              .scaledToFill()
              .frame(width: size, height: size)
              .clipShape(Circle())

          case .failure(_):
            placeholder

          @unknown default:
            placeholder
          }
        }
      } else {
        placeholder
      }
    }
  }

  var placeholder: some View {
    Image(systemName: "person.crop.circle.fill")
      .resizable()
      .scaledToFit()
      .frame(width: size, height: size)
      .foregroundColor(.gray)
  }
}
