import JSON
import C7

extension JSON {
    var integerValue: Int? {
        get {
            if let v = doubleValue {
                return Int(v)
            }
            return nil
        }
    }
}

public protocol JSONSource {
    func asJSON() -> JSON?
}

extension JSON: JSONSource {
    public func asJSON() -> JSON? {
        return self
    }
}

extension Data: JSONSource {
    public func asJSON() -> JSON? {
        do {
            return try JSONParser().parse(data: self)
        }
        catch {
            return nil
        }
    }
}

extension String: JSONSource {
    public func asJSON() -> JSON? {
        return Data(self).asJSON()
    }
}
