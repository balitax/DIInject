// 
// DependencyContainer.swift
// 
// Created by Agus Cahyono on 2025.
// 
// MIT License
// 
// Copyright (c) 2025 Agus Cahyono
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
import Foundation

public final class DependencyContainer: IDependencyContainer {

    // MARK: - Properties
    private var services: [ObjectIdentifier: () -> Any] = [:]
    private var singletons: [ObjectIdentifier: Any] = [:]
    public static let shared = DependencyContainer()

    // MARK: - Initializer
    private init() {}

    // MARK: - Methods
    public func register<T>(_ type: T.Type, scope: DependencyScope, factory: @escaping () -> T) {
        switch scope {
        case .singleton:
            services[ObjectIdentifier(type)] = { [weak self] in
                let key = ObjectIdentifier(type)
                if let existing = self?.singletons[key] as? T {
                    return existing
                }
                let instance = factory()
                self?.singletons[key] = instance
                return instance
            }
        case .transient:
            services[ObjectIdentifier(type)] = factory
        }
    }

    /// Resolves a service of the specified type.
    /// If the service is not registered, it will throw an error.
    /// - Parameter type: The type of the service to resolve.
    /// - Returns: The resolved service instance.
    /// - Throws: An error if the service is not registered.
    public func resolve<T>(_ type: T.Type) -> T? {
        guard let factory = services[ObjectIdentifier(type)] else {
            print("⚠️ Service not found for type: \(type)")
            return nil
        }
        return factory() as? T
    }
}

// MARK: - Convenience Extension
extension DependencyContainer {
    /// Registers a service with a specified scope and factory.
    /// - Parameter type: The type of the service to register.
    /// - Parameter scope: The scope of the service (singleton or transient).
    /// - Parameter factory: The factory function to create the service instance.
    public func register<T>(_ scope: DependencyScope = .singleton, _ factory: @autoclosure @escaping () -> T) {
        register(T.self, scope: scope, factory: factory)
    }
}

// MARK: - Thread Safe Sendable
extension DependencyContainer: @unchecked Sendable { }
