import MAUL
import SwiftUI

struct Assignment1: View {
  @State var vehicle = false
  @State var temperature = false

  var body: some View {
    VStack(spacing: 0) {
      ScrollView {
        Image("car")
          .resizable()
          .scaledToFit()
          .padding(.top, -.MAUL.XXXL)

        Group {
          GroupBox {
            Toggle(isOn: $vehicle) {
              Text("Vehicle")
                .maulFontStyle(.body1)
                .foregroundColor(.MAUL.Text.secondary)
            }
            .toggleStyle(.maul())

            Spacer.MAUL.S()

            HStack {
              Text("Doors closed")
                .font(.MAUL.bold(ofSize: 24))
                .foregroundColor(.MAUL.Text.primary)

              Spacer()

              Text("Unlocked")
                .font(.MAUL.regular(ofSize: 16))
                .foregroundColor(.MAUL.Semantic.warning)
            }
          }
          .groupBoxStyle(.maulCard())

          GroupBox {
            Toggle(isOn: $temperature) {
              Text("Target temperature")
                .font(.MAUL.regular(ofSize: 16))
                .foregroundColor(.MAUL.Text.secondary)
            }
            .toggleStyle(.maul())

            HStack {
              Text("22 ºC")
                .font(.MAUL.bold(ofSize: 24))
                .foregroundColor(.MAUL.Text.primary)

              Spacer()

              Text("Climate")
                .font(.MAUL.regular(ofSize: 16))
                .foregroundColor(.MAUL.Text.secondary)
            }
          }
          .groupBoxStyle(.maulCard())

          GroupBox {
            HStack {
              Text("Next plan")
                .font(.MAUL.regular(ofSize: 16))
                .foregroundColor(.MAUL.Text.secondary)

              Spacer()
            }
            HStack {
              Text("Monday morning")
                .font(.MAUL.bold(ofSize: 24))
                .foregroundColor(.MAUL.Text.primary)

              Spacer()

              Text("Mondey 8:00")
                .font(.MAUL.regular(ofSize: 16))
                .foregroundColor(.MAUL.Text.secondary)
            }
          }
          .groupBoxStyle(.maulCard())

        }
        .padding(.horizontal, .MAUL.S)
      }
    }
    .navigationTitle("Phantom")
    .navigationBarTitleDisplayMode(.large)
    .background(Color.MAUL.Background.primary)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Image(systemName: "bell.badge.fill")
      }
    }
  }
}

#Preview {
  NavigationView {
    Assignment1()
  }
  .setupMAULForPreviews()
}
