//
//  Created by Mikhail G. on 18/04/2019.
//  Copyright © 2019. All rights reserved.
//
import Foundation

class LoginPresenter: LoginModuleInput, LoginViewOutput, LoginInteractorOutput {

    weak var view: LoginViewInput!
    var interactor: LoginInteractorInput!
    var router: LoginRouterInput!
    
    private var email: String?
    private var password: String?

    func viewIsReady() {
        view.setLoginEnabled(isEnabled: false)
    }
    
    func emailChanged(newValue: String?) {
        email = newValue
        checkFields()
    }
    
    func passwordChanged(newValue: String?) {
        password = newValue
        checkFields()
    }
    
    func loginButtonPressed() {
        view.setShowPasswordError(showError: false)
        if let email = email, let password = password{
            view.showLoading()
            interactor.auth(login: email, password: password)
        }
    }
    
    func forgotPasswordButtonPressed() {
        router.openForgotPassword()
    }
    
    func signUpPressed() {
        router.openRegistration()
    }
    
    func authSuccess() {
        view.hideLoading()
        router.openLogin()
    }
    
    func authError(error: String?) {
        view.hideLoading()
        if let error = error{
            view.showError(error: "\(error) \("Repeat?".localized())") {[weak self] in
                self?.loginButtonPressed()
            }
            return
        }
        view.setShowPasswordError(showError: true)
    }
    
    func checkFields() {
        if let email = email, email.isValidEmail(), password != nil {
            view.setLoginEnabled(isEnabled: true)
        } else {
            view.setLoginEnabled(isEnabled: false)
        }
    }
}
