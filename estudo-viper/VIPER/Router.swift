//
//  Router.swift
//  estudo-viper
//
//  Created by Guilherme Golfetto on 05/11/22.
//

import Foundation
import UIKit

// object
// entry point for application

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry: EntryPoint? {get}
    
    static func start() -> AnyRouter
}

class UserRouter: AnyRouter {
    
    //-----------------------------------------------------------------------
    // MARK: - Public properties
    //-----------------------------------------------------------------------
    
    var entry: EntryPoint?
    
    //-----------------------------------------------------------------------
    // MARK: - Static methods
    //-----------------------------------------------------------------------
    
    static func start() -> AnyRouter {
        let router = UserRouter()
        
        // Assign VIP
        var view: AnyView = UserViewController()
        var presenter: AnyPresenter = UserPresenter()
        var interactor: AnyInteractor = UserInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
        
        return router
    }
}
