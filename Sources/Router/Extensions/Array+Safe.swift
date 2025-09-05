//
//  Array+Safe.swift
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

extension Array {

	subscript(safe index: Index) -> Element? {
		
		guard
			indices.contains(index)
		else { return nil }

		return self[index]

	}

}
