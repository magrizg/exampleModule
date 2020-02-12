//
//  Created by Mikhail G. on 18/04/2019.
//  Copyright © 2019. All rights reserved.
//

class LoginInteractor: LoginInteractorInput {
    let authModule: AuthModuleInput
    weak var output: LoginInteractorOutput!
    
    init(with authModule: AuthModuleInput){
        self.authModule = authModule
    }
    
    func auth(login: String, password: String){
        authModule.auth(with: login, password: password) {[weak self] (success, error) in
           self?.authCompletion(success: success, error: error)
        }
    }
    
    func authCompletion(success: Bool, error: String?){
        if success && error == nil{
            output.authSuccess()
            return
        }
        output.authError(error: error)
    }
}
