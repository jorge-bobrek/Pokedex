//
//  PickerView.swift
//  LingoDex
//
//  Created by Jorge Bobrek on 31/12/24.
//

import SwiftUI

struct PickerView<T: Hashable, Content: View>: View {
    @State private var showPicker: Bool = false
    @Binding var selected: T
    let items: [T]
    let direction: Direction
    let content: (T) -> Content

    var body: some View {
        VStack(spacing: 0) {
            if direction == .down {
                selector()
                picker()
            } else {
                picker()
                selector()
            }
        }
        .foregroundStyle(.primary)
        .borderBackground(cornerRadius: 4)
        .frame(height: 36, alignment: direction == .down ? .top : .bottom)
        .onTapBackground(enabled: showPicker) {
            withAnimation(.snappy(duration: 0.15)) {
                showPicker.toggle()
            }
        }
    }

    @ViewBuilder func picker() -> some View {
        if showPicker {
            VStack(spacing: 0) {
                ForEach(items, id: \.self) { item in
                    Button {
                        withAnimation(.snappy(duration: 0.15)) {
                            selected = item
                            showPicker.toggle()
                        }
                    } label: {
                        content(item)
                            .padding(direction == .down ? .bottom : .top, 4)
                    }
                }
            }
        }
    }

    @ViewBuilder func selector() -> some View {
        Button {
            withAnimation(.snappy(duration: 0.15)) {
                showPicker.toggle()
            }
        } label: {
            content(selected)
                .padding(.vertical, 4)
        }
    }

    enum Direction {
        case up
        case down
    }
}
