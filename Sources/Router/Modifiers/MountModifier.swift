//
//  MountModifier.swift
//  Router
//
//  Created by Kristian Trenskow on 09/03/2025.
//

import SwiftUI

@MainActor
public struct MountModifier: ViewModifier {

	@Environment(\.routerRemainingPathComponents) private var remainingPathComponents

	private var mountPoint: String?

	public init(
		_ mountPoint: String? = nil
	) {
		self.mountPoint = mountPoint
	}

	public func body(content: Content) -> some View {
		if mountPoint == self.remainingPathComponents.first {
			content
		} else {
			content
				.hidden()
		}
	}

}

extension View {

	@MainActor
	public func mount(
		_ mountPoint: String? = nil
	) -> some View {
		self.modifier(MountModifier(mountPoint))
	}

}
