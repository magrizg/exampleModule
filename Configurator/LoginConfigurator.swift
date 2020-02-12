//
//  Created by Mikhail G. on 18/04/2019.
//  Copyright © 2019. All rights reserved.
//

import UIKit

class LoginModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? LoginViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: LoginViewController) {

        let router = LoginRouter()
        router.transitionHandler = viewController
        
        let presenter = LoginPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = LoginInteractor.init(with: AuthModule())
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
