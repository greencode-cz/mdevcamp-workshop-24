import SwiftUI
import MAUL

struct ButtonScreen: View {

  @State private var buttonSize = 0

  var body: some View {
    let button = Button("Button") {
      print("Edit button was tapped")
    }

    let buttonImageText = Button {
      print("Edit button was tapped")
    } label: {
      HStack(spacing: .MAUL.XXS) {
        Image.MAUL.heart
          .resizable()
          .frame(width: 20, height: 20)
        Text("Button")
      }
    }

    let buttonImage = Button {
      print("Edit button was tapped")
    } label: {
      Image.MAUL.heart
        .resizable()
        .frame(width: 20, height: 20)
    }

    let view = VStack {
      switch buttonSize {
      case 0:
        VStack(spacing: .MAUL.XXS) {
          HStack {
            Text("style/state").frame(width: 100)
            Text("enabled/pressed").frame(maxWidth: .infinity)
            Text("disabled").frame(maxWidth: .infinity)
          }

          HStack {
            Text("Primary").frame(width: 100)
            button
              .buttonStyle(.maulPrimary(layout: .standard))
            button
              .buttonStyle(.maulPrimary(layout: .standard))
              .disabled(true)
          }

          HStack {
            Text("Primary").frame(width: 100)
            buttonImageText
              .buttonStyle(.maulPrimary(layout: .standard))
            buttonImageText
              .buttonStyle(.maulPrimary(layout: .standard))
              .disabled(true)
          }

          HStack {
            Text("Secondary").frame(width: 100)
            button
              .buttonStyle(.maulSecondary(layout: .standard))
            button
              .buttonStyle(.maulSecondary(layout: .standard))
              .disabled(true)
          }

          HStack {
            Text("Secondary").frame(width: 100)
            button
              .buttonStyle(.maulSecondary(layout: .standard))
            buttonImageText
              .buttonStyle(.maulSecondary(layout: .standard))
              .disabled(true)
          }

          HStack {
            Text("Tertiary").frame(width: 100)
            button
              .buttonStyle(.maulTertiary(layout: .standard))
            button
              .buttonStyle(.maulTertiary(layout: .standard))
              .disabled(true)
          }

          HStack {
            Text("Tertiary").frame(width: 100)
            buttonImageText
              .buttonStyle(.maulTertiary(layout: .standard))
            buttonImageText
              .buttonStyle(.maulTertiary(layout: .standard))
              .disabled(true)
          }

          HStack {
            Text("Outline").frame(width: 100)
            button
              .buttonStyle(.maulOutline(layout: .standard))
            button
              .buttonStyle(.maulOutline(layout: .standard))
              .disabled(true)
          }

          HStack {
            Text("Outline").frame(width: 100)
            buttonImageText
              .buttonStyle(.maulOutline(layout: .standard))
            buttonImageText
              .buttonStyle(.maulOutline(layout: .standard))
              .disabled(true)
          }
        }
        .frame(width: 800)
      case 1:
        VStack(spacing: .MAUL.XXS) {
          HStack {
            Text("style/state").frame(width: 100)
            Text("enabled/pressed").frame(maxWidth: .infinity)
            Text("disabled").frame(maxWidth: .infinity)
          }

          HStack {
            Text("Primary").frame(width: 100)
            button
              .buttonStyle(.maulPrimary(layout: .full))
            button
              .buttonStyle(.maulPrimary(layout: .full))
              .disabled(true)
          }

          HStack {
            Text("Primary").frame(width: 100)
            buttonImageText
              .buttonStyle(.maulPrimary(layout: .full))
            buttonImageText
              .buttonStyle(.maulPrimary(layout: .full))
              .disabled(true)
          }

          HStack {
            Text("Secondary").frame(width: 100)
            button
              .buttonStyle(.maulSecondary(layout: .full))
            button
              .buttonStyle(.maulSecondary(layout: .full))
              .disabled(true)
          }

          HStack {
            Text("Secondary").frame(width: 100)
            buttonImageText
              .buttonStyle(.maulSecondary(layout: .full))
            buttonImageText
              .buttonStyle(.maulSecondary(layout: .full))
              .disabled(true)
          }

          HStack {
            Text("Tertiary").frame(width: 100)
            button
              .buttonStyle(.maulTertiary(layout: .full))
            button
              .buttonStyle(.maulTertiary(layout: .full))
              .disabled(true)
          }

          HStack {
            Text("Tertiary").frame(width: 100)
            buttonImageText
              .buttonStyle(.maulTertiary(layout: .full))
            buttonImageText
              .buttonStyle(.maulTertiary(layout: .full))
              .disabled(true)

          }

          HStack {
            Text("Outline").frame(width: 100)
            button
              .buttonStyle(.maulOutline(layout: .full))
            button
              .buttonStyle(.maulOutline(layout: .full))
              .disabled(true)
          }

          HStack {
            Text("Outline").frame(width: 100)
            buttonImageText
              .buttonStyle(.maulOutline(layout: .full))
            buttonImageText
              .buttonStyle(.maulOutline(layout: .full))
              .disabled(true)

          }
        }.frame(width: 800)
      case 2:
        VStack(alignment: .leading, spacing: .MAUL.XXS) {
          HStack {
            Text("style/state").frame(width: 150)
            Text("enabled/pressed").frame(width: 100)
            Text("icon+text").frame(width: 100)
            Text("disabled").frame(width: 100)
          }

          HStack {
            Text("Primary").frame(width: 150)
            button
              .buttonStyle(.maulPrimary(layout: .compact))
              .frame(width: 100)
            buttonImageText
              .buttonStyle(.maulPrimary(layout: .compact))
              .frame(width: 100)
            button
              .buttonStyle(.maulPrimary(layout: .compact))
              .disabled(true)
              .frame(width: 100)
          }

          HStack {
            Text("Secondary").frame(width: 150)
            button
              .buttonStyle(.maulSecondary(layout: .compact))
              .frame(width: 100)
            buttonImageText
              .buttonStyle(.maulSecondary(layout: .compact))
              .frame(width: 100)
            button
              .buttonStyle(.maulSecondary(layout: .compact))
              .disabled(true)
              .frame(width: 100)
          }

          HStack {
            Text("Tertiary").frame(width: 150)
            button
              .buttonStyle(.maulTertiary(layout: .compact))
              .frame(width: 100)
            buttonImageText
              .buttonStyle(.maulTertiary(layout: .compact))
              .frame(width: 100)
            button
              .buttonStyle(.maulTertiary(layout: .compact))
              .disabled(true)
              .frame(width: 100)
          }

          HStack {
            Text("Outline").frame(width: 150)
            button
              .buttonStyle(.maulOutline(layout: .compact))
              .frame(width: 100)
            buttonImageText
              .buttonStyle(.maulOutline(layout: .compact))
              .frame(width: 100)
            button
              .buttonStyle(.maulOutline(layout: .compact))
              .disabled(true)
              .frame(width: 100)
          }

          HStack {
            Text("FAB Primary").frame(width: 150)
            button
              .buttonStyle(.maulFABPrimary(layout: .compact))
              .frame(width: 100)
            buttonImageText
              .buttonStyle(.maulFABPrimary(layout: .compact))
              .frame(width: 100)
            button
              .buttonStyle(.maulFABPrimary(layout: .compact))
              .disabled(true)
              .frame(width: 100)
          }

          HStack {
            Text("FAB Secondary").frame(width: 150)
            button
              .buttonStyle(.maulFABSecondary(layout: .compact))
              .frame(width: 100)
            buttonImageText
              .buttonStyle(.maulFABSecondary(layout: .compact))
              .frame(width: 100)
            button
              .buttonStyle(.maulFABSecondary(layout: .compact))
              .disabled(true)
              .frame(width: 100)
          }
        }
      case 3:
        VStack(alignment: .leading, spacing: .MAUL.XXS) {
          HStack {
            Text("style/state").frame(width: 150)
            Text("enabled/pressed").frame(width: 100)
            Text("disabled").frame(width: 100)
          }

          HStack {
            Text("Primary").frame(width: 150)
            buttonImage
              .buttonStyle(.maulPrimary(layout: .icon))
              .frame(width: 100)
            buttonImage
              .buttonStyle(.maulPrimary(layout: .icon))
              .disabled(true)
              .frame(width: 100)
          }

          HStack {
            Text("Secondary").frame(width: 150)
            buttonImage
              .buttonStyle(.maulSecondary(layout: .icon))
              .frame(width: 100)
            buttonImage
              .buttonStyle(.maulSecondary(layout: .icon))
              .disabled(true)
              .frame(width: 100)
          }

          HStack {
            Text("Tertiary").frame(width: 150)
            buttonImage
              .buttonStyle(.maulTertiary(layout: .icon))
              .frame(width: 100)
            buttonImage
              .buttonStyle(.maulTertiary(layout: .icon))
              .disabled(true)
              .frame(width: 100)
          }

          HStack {
            Text("Outline").frame(width: 150)
            buttonImage
              .buttonStyle(.maulOutline(layout: .icon))
              .frame(width: 100)
            buttonImage
              .buttonStyle(.maulOutline(layout: .icon))
              .disabled(true)
              .frame(width: 100)
          }

          HStack {
            Text("FAB Primary").frame(width: 150)
            buttonImage
              .buttonStyle(.maulFABPrimary(layout: .icon))
              .frame(width: 100)
            buttonImage
              .buttonStyle(.maulFABPrimary(layout: .icon))
              .disabled(true)
              .frame(width: 100)
          }

          HStack {
            Text("FAB Secondary").frame(width: 150)
            buttonImage
              .buttonStyle(.maulFABSecondary(layout: .icon))
              .frame(width: 100)
            buttonImage
              .buttonStyle(.maulFABSecondary(layout: .icon))
              .disabled(true)
              .frame(width: 100)
          }
        }
      default:
        Text("No more")
      }
    }.padding()

    VStack {
      Picker("", selection: $buttonSize) {
        Text("standart").tag(0)
        Text("full").tag(1)
        Text("compact").tag(2)
        Text("icon").tag(3)
      }
      .padding(.horizontal, .MAUL.S)
      .pickerStyle(SegmentedPickerStyle())

      ScrollView {
        ScrollView(.horizontal) {
          view
            .background(Color.MAUL.Background.primary)
            .environment(\.colorScheme, .light)
          view
            .background(Color.MAUL.Background.primary)
            .environment(\.colorScheme, .dark)
        }
      }
    }
  }
}

struct ButtonScreen_Previews: PreviewProvider {
  static var previews: some View {
    ButtonScreen()
      .setupMAULForPreviews()
  }
}
