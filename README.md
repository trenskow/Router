Router
----

Router is a URL router framework for SwiftUI that can use query strings to pass data between views.

# How it works

Currently this is work in progress so more information will be available as work progress.

Currently it supports telliing the system which URLs it is able to handle and then navigate to the views handling that URL when opened.

Below you can see an example of the current API.

````swift
//
//  RouterTestApp.swift
//  RouterTest
//
//  Created by Kristian Trenskow on 05/09/2025.
//

import SwiftUI
import Router

@MainActor
struct RootLayoutView<Content: View>: View, Sendable {

	@Environment(\.urlComponents) var urlComponents

	let content: () -> Content

	init(
		content: @escaping () -> Content
	) {
		self.content = content
	}

	var body: some View {
		VStack(
			spacing: 10
		) {
			Text("Layout")
			self.content()
			if let urlComponents, let url = urlComponents.url {
				Text("Current URL: \(url.absoluteString)")
					.multilineTextAlignment(.center)
			}
		}
	}

}

@MainActor
struct RootLayout: EndpointLayout, Sendable {

	init() { }

	func layout(
		content: AnyView
	) -> some View {
		RootLayoutView {
			content
		}
	}

}

@MainActor
struct Greeting: Codable, Hashable, Sendable {
	let greeting: String
}

@MainActor
struct GreetView: View {

	@Environment(\.navigator) var navigator: Navigator?

	var body: some View {
		Button {
			try? self.navigator?.navigate(
				to: "/content/greet",
				with: Greeting(
					greeting: "Hello, World!"))
		} label: {
			VStack {
				Text("Say Hello?")
			}
		}
	}

}

@MainActor
struct GreeterView: View {

	@Environment(\.navigator) var navigator: Navigator?

	let data: Greeting

	init(
		data: Greeting
	) {
		self.data = data
	}

	var body: some View {
		VStack {
			Text(data.greeting)
			Button {
				self.navigator?.back()
			} label: {
				Text("Go Back")
			}
		}
	}

}

@main
struct RouterTestApp: RouterApp {

	static let baseURL = URL(string: "https://kristians.work/")!
	static let initialRelativePath: String = "/home"

	@MainActor
	let root = Endpoint.Layout(RootLayout.self)
		// First we mount `/content`
		.mount(
			at: "content",
			endpoint: Endpoint()
				// Mount `/content/greet`
				.mount(
					at: "greet",
					Greeting.self,
					content: { data in
						GreeterView(
							data: data)
					}))
		// Then we mount `/home`
		.mount(
			at: "home"
		) {
			GreetView()
		}
		// View to display when URL was not found
		.onNotFound {
			Text("Not found")
		}

}
````

# License

See license in LICENSE.
