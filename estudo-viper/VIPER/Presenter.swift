//
//  Presenter.swift
//  estudo-viper
//
//  Created by Guilherme Golfetto on 05/11/22.
//

import Foundation

// object
// protocol
// ref to interactor, router, view

enum FetchError: Error {
    case failed
}

protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set }
    
    func interactorDidFetchUser(with result: Result<[User], Error>)
}

class UserPresenter: AnyPresenter {
    
    //-----------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------
    
    var view: AnyView?
    
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getUsers()
        }
    }
    
    //-----------------------------------------------------------------------
    // MARK: - Private methods
    //-----------------------------------------------------------------------
    
    func interactorDidFetchUser(with result: Result<[User], Error>) {
        switch result {
        case .success(let user):
            view?.update(with: user)
        case .failure:
            view?.update(with: "Something went wrong")
        }
    }
    
}
