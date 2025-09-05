//
//  TopLevelEncoder.Encoder.swift

//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

extension QueryCoder.TopLevelEncoder {

	struct Encoder: Swift.Encoder {

		let codingPath: [CodingKey]
		let userInfo: [CodingUserInfoKey : Any]

		let result: Result

		init(
			codingPath: [CodingKey],
			userInfo: [CodingUserInfoKey : Any],
			result: Result
		) {
			self.codingPath = codingPath
			self.userInfo = userInfo
			self.result = result
		}

		func container<Key>(
			keyedBy type: Key.Type
		) -> KeyedEncodingContainer<Key> where Key : CodingKey {
			return KeyedEncodingContainer(
				KeyedContainer<Key>(
					codingPath: self.codingPath,
					userInfo: self.userInfo,
					result: result))
		}
		
		func unkeyedContainer() -> any UnkeyedEncodingContainer {
			return UnkeyedContainer(
				codingPath: self.codingPath,
				userInfo: self.userInfo,
				result: self.result)
		}
		
		func singleValueContainer() -> any SingleValueEncodingContainer {
			return SingleValueContainer(
				codingPath: self.codingPath,
				userInfo: self.userInfo,
				result: self.result)
		}
		
	}

}
