//
//  TopLevelEncoder.Encoder.KeyedContainer
//  Router
//
//  Created by Kristian Trenskow on 05/09/2025.
//

extension QueryCoder.TopLevelEncoder.Encoder {

	struct KeyedContainer<Key: CodingKey>: KeyedEncodingContainerProtocol {

		let codingPath: [CodingKey]
		let userInfo: [CodingUserInfoKey : Any]

		var result: Result

		init(
			codingPath: [CodingKey],
			userInfo: [CodingUserInfoKey : Any],
			result: Result
		) {
			self.codingPath = codingPath
			self.userInfo = userInfo
			self.result = result
		}

		mutating func superEncoder() -> any Encoder {
			return QueryCoder.TopLevelEncoder.Encoder(
				codingPath: self.codingPath,
				userInfo: self.userInfo,
				result: result)
		}

		mutating func encodeNil(
			forKey key: Key
		) throws { }

		mutating func nestedContainer<NestedKey>(
			keyedBy keyType: NestedKey.Type,
			forKey key: Key
		) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {

			let result = Result()

			self.result.items[key.stringValue] = .container(result)

			return KeyedEncodingContainer(
				KeyedContainer<NestedKey>(
					codingPath: self.codingPath + [key],
					userInfo: self.userInfo,
					result: result))

		}

		mutating func nestedUnkeyedContainer(
			forKey key: Key
		) -> any UnkeyedEncodingContainer {

			let result = Result()

			self.result.items[key.stringValue] = .container(result)

			return UnkeyedContainer(
				codingPath: self.codingPath + [key],
				userInfo: self.userInfo,
				result: result)

		}

		mutating func superEncoder(
			forKey key: Key
		) -> any Swift.Encoder {
			return QueryCoder.TopLevelEncoder.Encoder(
				codingPath: self.codingPath + [key],
				userInfo: self.userInfo,
				result: self.result)
		}

		mutating func encode(
			_ value: Bool,
			forKey key: Key
		) throws {
			self.result.items[key.stringValue] = .constant(value ? "true" : "false")
		}

		mutating func encode(
			_ value: String,
			forKey key: Key
		) throws {
			self.result.items[key.stringValue] = .constant(value)
		}

		func encode(
			_ value: Double,
			forKey key: Key
		) throws {
			self.result.items[key.stringValue] = .constant("\(value)")
		}

		func encode(
			_ value: Float,
			forKey key: Key
		) throws {
			self.result.items[key.stringValue] = .constant("\(value)")
		}

		func encode(
			_ value: Int,
			forKey key: Key
		) throws {
			self.result.items[key.stringValue] = .constant("\(value)")
		}

		func encode(
			_ value: Int8,
			forKey key: Key
		) throws {
			self.result.items[key.stringValue] = .constant("\(value)")
		}

		func encode(
			_ value: Int16,
			forKey key: Key
		) throws {
			self.result.items[key.stringValue] = .constant("\(value)")
		}

		func encode(
			_ value: Int32,
			forKey key: Key
		) throws {
			self.result.items[key.stringValue] = .constant("\(value)")
		}

		func encode(
			_ value: Int64,
			forKey key: Key
		) throws {
			self.result.items[key.stringValue] = .constant("\(value)")
		}

		func encode(
			_ value: UInt,
			forKey key: Key
		) throws {
			self.result.items[key.stringValue] = .constant("\(value)")
		}

		func encode(
			_ value: UInt8,
			forKey key: Key
		) throws {
			self.result.items[key.stringValue] = .constant("\(value)")
		}

		func encode(
			_ value: UInt16,
			forKey key: Key
		) throws {
			self.result.items[key.stringValue] = .constant("\(value)")
		}

		func encode(
			_ value: UInt32,
			forKey key: Key
		) throws {
			self.result.items[key.stringValue] = .constant("\(value)")
		}

		func encode(
			_ value: UInt64,
			forKey key: Key
		) throws {
			self.result.items[key.stringValue] = .constant("\(value)")
		}

		func encode<T>(
			_ value: T,
			forKey key: Key
		) throws where T : Encodable {

			let result = Result()

			self.result.items[key.stringValue] = .container(result)

			try value.encode(
				to: QueryCoder.TopLevelEncoder.Encoder(
					codingPath: self.codingPath + [key],
					userInfo: self.userInfo,
					result: result))

		}

	}

}
