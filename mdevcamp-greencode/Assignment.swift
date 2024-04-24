import MAUL
import SwiftUI

struct Assignment: View {
  var body: some View {
    NavigationView {
      List {
        NavigationLink("Assignment1") {
          Assignment1()
        }
        NavigationLink("Assignment2") {
          Assignment2()
        }
        NavigationLink("Assignment3") {
          Assignment3()
        }
      }
      .listStyle(.plain)
      .navigationTitle("Assignments")
    }
    .withMAULStyle
  }
}

#Preview {
  Assignment()
    .setupMAULForPreviews()
}
