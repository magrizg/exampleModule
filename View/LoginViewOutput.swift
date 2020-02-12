//
//  Created by Mikhail G. on 18/04/2019.
//  Copyright © 2019. All rights reserved.
//

protocol LoginViewOutput {

    func viewIsReady()

    func emailChanged(newValue: String?)
    func passwordChanged(newValue: String?)
    
    func loginButtonPressed()
    func forgotPasswordButtonPressed()
    func signUpPressed()
}
