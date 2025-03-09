# Router

An URL based view router for SwiftUI.

## Description

This router uses URLs to determine what to display when. It's a replacement for `NavigationStack` that uses an URL instead of the Swift type system. It is made to mimic the behavior of most web frameworks making it easier to streamline URL handling in SwiftUI as in the web framework.

It automatically handles deep links and navigates to the right screen for a given URL.

## Usage

Below is an example of how it is used.

This code will show a button with a text saying "Go to user". When the button is pressed the router will navigate to the URL `https://example.com/users/myusername`. The `UserView` will then be displayed with the username "myusername".

Deep linking is handled automatically and the `UserView` will be displayed when the URL is `https://example.com/users/myusername`.

> The `UserView` will also be displayed when the URL is `https://example.com/users/myusername/otherpath`.

````swift
// AppView.swift

import SwiftUI
import Router

struct AppView: View {
	var body: some View {
		Router(
			baseURL: URL(string: "https://example.com")!
		) {

			Text("This is a view before routing") // This will always be displayed

			Mount("users") { // Rendered when current URL is `https://example.com/users/...`

				Text("This displays whenever the URL starts with `/users/")

				Parameter(\.userIdentifier) {
					UserView()
						.autohide() // Hide whenever route is not exact (eg. `https://example.com/users/myusername/picture/`)
				}

				Mount {
					Text("No user selected.")
				}

			}

			Mount { // Rendered when current URL is `https://example.com/`.
				RootView()
					.autohide() // Hide whenever route is not exact (eg. `https://example.com/users/`)
			}

			Text("This is a view after routing") // This will always be displayed

		}
	}
}
````

````swift
// RootView.swift

import SwiftUI
import Router

struct RootView: View {

	@Environment(\.navigator) private var navigator

	var body: View {
		Button {
			self.navigator?.navigate(to: "./users/myusername")
		} label: {
			Text("Go to user")
		}
	}

}
````

````swift
// UserView.swift

import SwiftUI
import Router

enum UserIdentifier: StringRepresentable {

	case id(Int)
	case username(String)

	init(stringValue: String) {
		if let id = Int(stringValue: stringValue) {
			self = .id(id)
		} else {
			self = .username(stringValue)
		}
	}

}

struct UserView: View {

	@Environment(\.userIdentifier) private var userIdentifier

	var body: some View {

		if let userIdentifier = self.userIdentifier {
			switch userIdentifier {
			case .id(let id): Text("id: \(id)")
			case .username(let usernanme): Text("username: \(username)")
			}
		} else {
			Text("Error: Could not decode user identifier.")
		}

	}

}

struct UserIdentifierKey: EnvironmentKey {
	static let defaultValue: UserIdentifier? = nil
}

extension EnvironmentValues {
	var userIdentifier: UserIdentifier? {
		get { self[UserIdentifierKey.self] }
		set { self[UserIdentifierKey.self] = newValue }
	}
}
````

## Proof of Concept

This code is proof of concept at the current state and is just to experiment with the routing format.

# LICENSE

See license in LICENSE
