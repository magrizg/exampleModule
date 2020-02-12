//
//  Created by Mikhail G. on 18/04/2019.
//  Copyright © 2019. All rights reserved.
//

import SafariServices

class LoginRouter: RouterBase, LoginRouterInput {
    static let kFromLoginToMainTabBar = "FromLoginToMainTabBar"
    static let kFromLoginToForgotPassword = "FromLoginToForgotPassword"
    var safaryController: SFSafariViewController?
    
    func openLogin(){
        perform(segueIdentifier: LoginRouter.kFromLoginToMainTabBar)
    }
    
    func openForgotPassword() {
        perform(segueIdentifier: LoginRouter.kFromLoginToForgotPassword)
    }

    func openRegistration(){
        if let url = URL(string: NetworkManager.sharedInstance.signUpUrl()) {
            safaryController = SFSafariViewController.init(url: url)
            transitionHandler.present(safaryController!, animated: true, completion: nil)
        }
    }
}
