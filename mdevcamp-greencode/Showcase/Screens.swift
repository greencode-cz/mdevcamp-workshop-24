import Foundation
import SwiftUI

struct Screen<Content>: View where Content: View {
  let title: String
  let description: String?
  let content: Content

  init(_ title: String, _ description: String? = nil, content: Content) {
    self.title = title
    self.description = description
    self.content = content
  }

  var body: some View {
    NavigationLink(destination: content) {
      VStack(alignment: .leading, spacing: 5) {
        Text(title)
        if let description = description {
          Text(description)
            .padding(.leading)
            .foregroundStyle(.tertiary)
        }
      }
    }
  }
}
