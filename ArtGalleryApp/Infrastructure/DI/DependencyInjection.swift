//
//  DependencyInjection.swift
//  ArtGalleryApp
//
//  Created by Ari Fajrianda Alfi on 16/09/23.
//

public protocol InjectionKey {
    associatedtype Value
    static var currentValue: Self.Value { get set }
}

public struct InjectedValue {
    private static var current = InjectedValue()
    
    public static subscript<K>(key: K.Type) -> K.Value where K: InjectionKey {
        get { key.currentValue }
        set { key.currentValue = newValue}
    }
    
    public static subscript<T>(_ keyPath: WritableKeyPath<InjectedValue, T>) -> T {
        get { current[keyPath: keyPath] }
        set { current[keyPath: keyPath] = newValue }
    }
}

@propertyWrapper
public struct Injected<T> {
    private let keyPath: WritableKeyPath<InjectedValue, T>
    public var wrappedValue: T {
        get { InjectedValue[keyPath] }
        set { InjectedValue[keyPath] = newValue }
    }
    
    public init(_ keyPath: WritableKeyPath<InjectedValue, T>) {
        self.keyPath = keyPath
    }
}
