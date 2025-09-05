//
//  URL+Components.swift
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

import Foundation

extension URL {

	var components: URLComponents? {
		return URLComponents(
			url: self,
			resolvingAgainstBaseURL: true)
	}

}
