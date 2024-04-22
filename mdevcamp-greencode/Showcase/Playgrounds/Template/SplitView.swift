//
//  SplitView.swift
//  SplitView
//
//  Created by Grigory Avdyushin on 20/05/2020.
//  Copyright © 2020 Grigory Avdyushin. All rights reserved.
//

import SwiftUI

public class SliderControlViewModel: ObservableObject {

  @Published public var current: CGFloat = 0
  @Published public var previous: CGFloat = 0

  @Published public var isMax = false
  @Published public var isMin = false

  public var middle: CGFloat
  public var range: ClosedRange<CGFloat>

  public init(middle: CGFloat = 0.3, range: ClosedRange<CGFloat> = 0.2...0.8) {
    precondition(range.lowerBound >= 0, "Range lower bound must be positive")
    precondition(range.upperBound >= 0, "Range upper bound must be positive")
    precondition(range.lowerBound < middle && range.upperBound > middle, "Middle value must be in range: \(range)")

    self.middle = middle
    self.range = range
  }
}

struct SliderControl<Content: View>: View {

  @ObservedObject var viewModel: SliderControlViewModel

  var geometry: GeometryProxy
  let content: Content

  public init(
    viewModel: SliderControlViewModel,
    geometry: GeometryProxy,
    @ViewBuilder content: () -> Content) {
      self.viewModel = viewModel
      self.content = content()
      self.geometry = geometry
    }

  var body: some View {
    VStack { content }
      .offset(y: geometry.size.height * (0.5 - viewModel.middle) + viewModel.current)
      .gesture(
        DragGesture()
          .onChanged(onDragChanged)
          .onEnded(onDragEnded)
      )
  }

  fileprivate var maxLimit: CGFloat {
    geometry.size.height * (viewModel.middle - viewModel.range.upperBound)
  }

  fileprivate var minLimit: CGFloat {
    geometry.size.height * (viewModel.middle - viewModel.range.lowerBound)
  }

  fileprivate func onDragChanged(_ gesture: DragGesture.Value) {
    let height = viewModel.previous + gesture.translation.height

    viewModel.current = max(maxLimit, min(minLimit, height))
    viewModel.isMax = viewModel.current == maxLimit
    viewModel.isMin = viewModel.current == minLimit
  }

  fileprivate func onDragEnded(_ gesture: DragGesture.Value) {
    viewModel.previous = viewModel.current
  }
}

public struct SplitView<TopContent: View, BottomContent: View>: View {

  @ObservedObject public var viewModel: SliderControlViewModel

  public var topView: TopContent
  public var bottomView: BottomContent

  public init(
    viewModel: SliderControlViewModel,
    @ViewBuilder topView: () -> TopContent,
    @ViewBuilder bottomView: () -> BottomContent) {

      self.topView = topView()
      self.bottomView = bottomView()
      self.viewModel = viewModel
    }

  public var body: some View {
    GeometryReader { geometry in
      ZStack {
        VStack {
          Group {
            self.topView
              .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
          }
          Group {
            self.bottomView
              .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
              .frame(height: geometry.size.height * self.viewModel.middle - self.viewModel.current)
          }
        }
        SliderControl(viewModel: self.viewModel, geometry: geometry) {
          Group {
            Rectangle()
              .frame(height: 10)
              .foregroundColor(Color.MAUL.Text.tertiary)
              .overlay(
                Capsule()
                  .frame(width: 25, height: 5)
                  .foregroundColor(.MAUL.Text.quartenary)
              )
          }
        }
      } // ZStack
    } // GeometryReader
  }
}
