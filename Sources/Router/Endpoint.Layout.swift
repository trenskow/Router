//
//  EndpointLayout.swift
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

import SwiftUI

extension Endpoint {

	@MainActor
	public struct Layout<Layout: EndpointLayout>: MountPoint, EndpointRoutes, EndpointInternal, Sendable {

		var routes: [String : MountPoint] = [:]
		var notFound: AnyView? = nil

		public let layout: Layout

		public init(
			_ layout: Layout.Type
		) {
			self.layout = layout.init()
		}

		public func handles(
			pathComponents: [String],
			queryItems: [URLQueryItem]
		) -> Bool {
			return self._handles(
				pathComponents: pathComponents,
				queryItems: queryItems)
		}

		public func view(
			for pathComponents: [String],
			in urlComponents: URLComponents
		) throws -> AnyView {
			return AnyView(self.layout.layout(
				content: try self._view(
					for: pathComponents,
					in: urlComponents)))

		}

		public func mount(
			at pathComponent: String,
			endpoint: MountPoint
		) -> Self {
			return self._mount(
				at: pathComponent,
				endpoint: endpoint)
		}

		public func mount<Content: View>(
			at pathComponent: String,
			@ViewBuilder content: @escaping () -> Content
		) -> Self {
			return self._mount(
				at: pathComponent,
				content: content)
		}

		public func mount<Content: View, Parameter: Decodable>(
			at pathComponent: String,
			_ type: Parameter.Type,
			content: @escaping (Parameter) -> Content
		) -> Self {
			return self._mount(
				at: pathComponent,
				type,
				content: content)
		}

		public func onNotFound(
			view: () -> some View
		) -> Self {
			return self._onNotFound(
				view: AnyView(view()))
		}

	}

}
