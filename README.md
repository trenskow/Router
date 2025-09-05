Router
----

Router is a URL router framework for SwiftUI that can use query strings to pass data between views.

# How it works

Currently this is work in progress so more information will be available as work progress.

Currently it supports telliing the system which URLs it is able to handle and then navigate to the views handling that URL when opened.

Below you can see an example of the current API.

````swift
import SwiftUI
import Router

struct RootLayoutView<Content: View>: View {

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

struct RootLayout: EndpointLayout {

	func layout(
		content: AnyView
	) -> some View {
		RootLayoutView {
			content
		}
	}

}

struct Greeting: Codable, Hashable {
	let greeting: String
}

struct GreetView: View {

	@Environment(\.navigator) var navigator: Navigator?

	var body: some View {
		Button {
			try? self.navigator?.push(
				relativePath: "/content/greet",
				data: Greeting(
					greeting: "Hello, World!"))
		} label: {
			Text("Say Hello?")
		}
		.transition(.offset(CGSize(width: -50, height: 0)))
	}

}

struct GreeterView: View {

	let data: Greeting

	init(
		data: Greeting
	) {
		self.data = data
	}

	var body: some View {
		VStack {
			Text(data.greeting)
		}
		.transition(.offset(CGSize(width: -50, height: 0)))
	}

}

@main
struct RouterTestApp: RouterApp {

	static let baseURL = URL(string: "https://kristians.work/")!
	static let initialRelativePath: String = "/home"

	@State var navigationStack: [URL] = []

	var router: Router {
		return Router(
			baseUrl: Self.baseURL,
			root: Endpoint.Layout(RootLayout.self)
				// Mount an endpoint at `/content`
				.mount(
					at: "content",
					endpoint: Endpoint()
						// Mount a view with data at `/content/greet`.
						.mount(
							at: "greet",
							Greeting.self,
							content: { data in
								GreeterView(
									data: data)
							}))
				// Mount the greet view at `/home`
				.mount(
					at: "home"
				) {
					GreetView()
				}
				// What to render when url is not found.
				.onNotFound {
					Text("Not found")
				},
			navigationStack: self.$navigationStack)
	}

	func navigate(to url: URL) {
		self.navigationStack
			.append(url)
	}

}

````

# License

See license in LICENSE.
