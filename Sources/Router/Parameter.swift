//
//  Parameter.swift
//  Router
//
//  Created by Kristian Trenskow on 09/03/2025.
//

import SwiftUI

@MainActor
public struct Parameter<Content: View, V: StringRepresentable>: View {

	@Environment(\.routerRemainingPathComponents) private var routerRemainingPathComponents

	private let keyPath: WritableKeyPath<EnvironmentValues, V>
	private let content: () -> Content

	public init(
		_ keyPath: WritableKeyPath<EnvironmentValues, V>,
		@ViewBuilder content: @escaping () -> Content
	) {
		self.content = content
		self.keyPath = keyPath
	}

	public var body: some View {

		if let value = self.routerRemainingPathComponents.first.flatMap(V.init) {
			self.content()
				.environment(keyPath, value)
				.environment(
					\.routerRemainingPathComponents,
					 Array(self.routerRemainingPathComponents.dropFirst()))
		}

	}

}
