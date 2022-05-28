
import Foundation

extension UserDefaults {
    open func setStruct<T: Codable>(_ value: T?, forKey defaultName: String) {
        let data = try? APIEncoder().encode(value)
        set(data, forKey: defaultName)
    }

    open func structData<T>(_ type: T.Type, forKey defaultName: String) -> T? where T: Decodable {
        guard let encodedData = data(forKey: defaultName) else {
            return nil
        }
        do {
            return try APIDecoder().decode(type, from: encodedData)
        } catch {
            return nil
        }
    }

    open func setStructArray<T: Codable>(_ value: [T], forKey defaultName: String) {
        let data = value.map { try? APIEncoder().encode($0) }

        set(data, forKey: defaultName)
    }

    open func structArrayData<T>(_ type: T.Type, forKey defaultName: String) -> [T] where T: Decodable {
        guard let encodedData = array(forKey: defaultName) as? [Data] else {
            return []
        }

        return encodedData.compactMap {
            do {
                return try APIDecoder().decode(type, from: $0)
            } catch {
                return nil
            }
        }
    }
}
