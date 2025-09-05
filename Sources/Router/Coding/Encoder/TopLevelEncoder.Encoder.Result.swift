//
//  TopLevelEncoder.Encoder.Result.swift
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

extension QueryCoder.TopLevelEncoder.Encoder {

	class Result {

		enum ItemTypeContainer {
			case constant(String)
			case container(Result)
		}

		var items: [String: ItemTypeContainer] = [:]

	}

}

extension QueryCoder.TopLevelEncoder.Encoder.Result {

	func finalize() -> [String: QueryCoder.ItemType] {
		return self.items.reduce([:]) { result, element in
			var result = result
			switch element.value {
			case .constant(let value):
				result[element.key] = .constant(value)
				break
			case .container(let value):
				result[element.key] = .container(value.finalize())
				break
			}
			return result
		}
	}

}
