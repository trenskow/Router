//
//  AutohideModifier.swift
//  Router
//
//  Created by Kristian Trenskow on 09/03/2025.
//

import SwiftUI

@MainActor
public struct AutohideModifier: ViewModifier {

	@Environment(\.routerRemainingPathComponents) private var remainingPathComponents

	public func body(content: Content) -> some View {
		if remainingPathComponents.isEmpty {
			content
		} else {
			content
				.hidden()
		}
	}

}

extension View {

	@MainActor
	public func autohide() -> some View {
		self.modifier(AutohideModifier())
	}

}
