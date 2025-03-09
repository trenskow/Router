//
//  Mount.swift
//  Router
//
//  Created by Kristian Trenskow on 09/03/2025.
//

import SwiftUI

@MainActor
public struct Mount<Content: View>: View {

	@Environment(\.routerRemainingPathComponents) var routerRemainingPathComponents

	private let mountPoint: String?
	private let content: () -> Content

	public init(
		_ mountPoint: String? = nil,
		@ViewBuilder content: @escaping () -> Content
	) {
		self.mountPoint = mountPoint
		self.content = content
	}

	public var body: some View {

		if self.mountPoint == self.routerRemainingPathComponents.first {
			self.content()
				.environment(
					\.routerRemainingPathComponents,
					 Array(self.routerRemainingPathComponents.dropFirst()))
		}

	}

}
