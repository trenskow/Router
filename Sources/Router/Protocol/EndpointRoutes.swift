//
//  EndpointRoutes.swift
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

import SwiftUI

@MainActor
public protocol EndpointRoutes: Sendable {

	func mount(
		at pathComponent: String,
		endpoint: MountPoint
	) -> Self

	func mount<Content: View>(
		at pathComponent: String,
		@ViewBuilder content: @escaping () -> Content
	) -> Self

	func mount<Content: View, Parameter: Decodable>(
		at pathComponent: String,
		_ type: Parameter.Type,
		content: @escaping (Parameter) -> Content
	) -> Self

	func onNotFound(
		@ViewBuilder view: () -> some View
	) -> Self

}
