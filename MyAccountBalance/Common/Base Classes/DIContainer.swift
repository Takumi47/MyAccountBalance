//
//  DIContainer.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/22.
//

import Foundation

enum DIContainerScope {
    case main, current
}

struct DIComponentKey: Equatable, Hashable {
    var type: Any.Type
    var name: String { "\(type)" }
    
    static func ==(lhs: DIComponentKey, rhs: DIComponentKey) -> Bool {
        lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        ObjectIdentifier(type).hash(into: &hasher)
        name.hash(into: &hasher)
    }
}

struct DIComponent {
    var type: Any.Type
    var name: String { "\(type)" }
    var argumentsType: Any.Type
    var factory: Any
    var persistedInstance: Any?
    weak var container: DIContainer?
}

protocol DIContainerProtocol {
    func register<Component>(type: Component.Type, callback: @escaping (_ resolver: DIContainer) throws -> AnyObject, scope: DIContainerScope)
    func register<Component, Arg1>(type: Component.Type, callback: @escaping (_ resolver: DIContainer, Arg1) throws -> AnyObject, scope: DIContainerScope)
    func register<Component, Arg1, Arg2>(type: Component.Type, callback: @escaping (_ resolver: DIContainer, Arg1, Arg2) throws -> AnyObject, scope: DIContainerScope)
    func register<Component, Arg1, Arg2, Arg3>(type: Component.Type, callback: @escaping (_ resolver: DIContainer, Arg1, Arg2, Arg3) throws -> AnyObject, scope: DIContainerScope)
    func resolve<Component>(type: Component.Type, scope: DIContainerScope) throws -> Component
    func resolve<Component, Arg1>(type: Component.Type, argument: Arg1, scope: DIContainerScope) throws -> Component
    func resolve<Component, Arg1, Arg2>(type: Component.Type, arguments arg1: Arg1, _ arg2: Arg2, scope: DIContainerScope) throws -> Component
    func resolve<Component, Arg1, Arg2, Arg3>(type: Component.Type, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, scope: DIContainerScope) throws -> Component
    func remove<Component>(type: Component.Type, scope: DIContainerScope)
}

class DIContainer: DIContainerProtocol {
    
    // MARK: - Properties
    
    static let shared = DIContainer(key: "main")
    
    let key: String
    var components: [DIComponentKey: DIComponent] = [:]
    
    // MARK: - Initialization
    
    init(key: String) {
        self.key = key
    }
    
    // MARK: - Private Implementation
    
    private func registerDependency<Component, Arguments>(type: Component.Type, callback: @escaping (Arguments) throws -> Any, scope: DIContainerScope) {
        let container = scope == .main ? DIContainer.shared : self
        let key = DIComponentKey(type: type)
        let component = DIComponent(type: type, argumentsType: Arguments.self, factory: callback, container: container)
        container.components[key] = component
    }
    
    private func resolveDependency<Component, Arguments>(type: Component.Type, factory: ((Arguments) throws -> Any) throws -> Any, scope: DIContainerScope) throws -> Component {
        let container = scope == .main ? DIContainer.shared : self
        let key = DIComponentKey(type: type)
        guard let component = container.components[key] else {
            throw XError.noComponentFoundInContainer(type: "\(type)")
        }
        
        if let persisted = component.persistedInstance {
            if let casted = persisted as? Component {
                return casted
            } else {
                throw XError.dependencyResolverInternalError
            }
        }
        
        let dependency: Component = try extractDependency(diComponent: component, callback: factory)
        container.components[key]?.persistedInstance = dependency
        return dependency
    }
    
    private func extractDependency<Component, Factory>(diComponent: DIComponent, callback: (Factory) throws -> Any) throws -> Component {
        guard let factory = diComponent.factory as? Factory, let dependency = try callback(factory) as? Component else {
            throw XError.dependencyResolverArgumentsMismatch
        }
        return dependency
    }
}

// MARK: - Register

extension DIContainer {
    func register<Component>(type: Component.Type, callback: @escaping (DIContainer) throws -> AnyObject, scope: DIContainerScope) {
        registerDependency(type: type, callback: callback, scope: scope)
    }
    
    func register<Component, Arg1>(type: Component.Type, callback: @escaping (DIContainer, Arg1) throws -> AnyObject, scope: DIContainerScope) {
        registerDependency(type: type, callback: callback, scope: scope)
    }
    
    func register<Component, Arg1, Arg2>(type: Component.Type, callback: @escaping (DIContainer, Arg1, Arg2) throws -> AnyObject, scope: DIContainerScope) {
        registerDependency(type: type, callback: callback, scope: scope)
    }
    
    func register<Component, Arg1, Arg2, Arg3>(type: Component.Type, callback: @escaping (DIContainer, Arg1, Arg2, Arg3) throws -> AnyObject, scope: DIContainerScope) {
        registerDependency(type: type, callback: callback, scope: scope)
    }
}

// MARK: - Resolve

extension DIContainer {
    func resolve<Component>(type: Component.Type, scope: DIContainerScope) throws -> Component {
        typealias FactoryType = (DIContainer) throws -> Any
        let dependency = try resolveDependency(type: type, factory: { (factory: FactoryType) in try factory(self) }, scope: scope)
        return dependency
    }
    
    func resolve<Component, Arg1>(type: Component.Type, argument: Arg1, scope: DIContainerScope) throws -> Component {
        typealias FactoryType = ((DIContainer, Arg1)) throws -> Any
        let dependency = try resolveDependency(type: type, factory: { (factory: FactoryType) in try factory((self, argument)) }, scope: scope)
        return dependency
    }
    
    func resolve<Component, Arg1, Arg2>(type: Component.Type, arguments arg1: Arg1, _ arg2: Arg2, scope: DIContainerScope) throws -> Component {
        typealias FactoryType = ((DIContainer, Arg1, Arg2)) throws -> Any
        let dependency = try resolveDependency(type: type, factory: { (factory: FactoryType) in try factory((self, arg1, arg2)) }, scope: scope)
        return dependency
    }
    
    func resolve<Component, Arg1, Arg2, Arg3>(type: Component.Type, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, scope: DIContainerScope) throws -> Component {
        typealias FactoryType = ((DIContainer, Arg1, Arg2, Arg3)) throws -> Any
        let dependency = try resolveDependency(type: type, factory: { (factory: FactoryType) in try factory((self, arg1, arg2, arg3)) }, scope: scope)
        return dependency
    }
}

// MARK: - Remove

extension DIContainer {
    func remove<Component>(type: Component.Type, scope: DIContainerScope) {
        let container = scope == .main ? DIContainer.shared : self
        container.components.removeValue(forKey: DIComponentKey(type: type))
    }
}

