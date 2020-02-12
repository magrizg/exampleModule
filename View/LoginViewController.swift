//
//  Created by Mikhail G. on 18/04/2019.
//  Copyright © 2019. All rights reserved.
//

import UIKit

class LoginViewController: ParentViewController, LoginViewInput {
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var output: LoginViewOutput!
    
    private let loginLogo: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "loginHeader"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10.0
        return view
    }()
    private var contentTopConstraint: NSLayoutConstraint!
    private var contentTopLogoConstraint: NSLayoutConstraint!
    private var contentBottomConstraint: NSLayoutConstraint!

    private let headerLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.font = .bnSemiBoldFontWithSize(ofSize: 24.0)
        label.textColor = .bnText
        label.text = "Sign In".localized()
        return label
    }()
    private let emailField: LoginField = {
        let field = LoginField(frame: CGRect.zero)
        field.headerText = "Email".localized()
        field.placeholderText = "Enter email".localized()
        field.isSecured = false
        field.keyboardType = .emailAddress
        return field
    }()
    private let passwordField: LoginField = {
        let field = LoginField(frame: CGRect.zero)
        field.headerText = "Password".localized()
        field.placeholderText = "Enter password".localized()
        field.isSecured = true
        return field
    }()
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In".localized(), for: .normal)
        button.titleLabel?.font = .bnSemiBoldFontWithSize(ofSize: 18.0)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .bnDefaultGray
        button.layer.cornerRadius = 24.0
        return button
    }()
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.bnFadedOrange, for: .normal)
        button.isEnabled = true
        button.setTitle("Forgot password?".localized(), for: .normal)
        button.titleLabel?.font = .bnSemiBoldFontWithSize(ofSize: 18.0)
        return button
    }()
    private let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.bnFadedOrange, for: .normal)
        button.isEnabled = true
        let attributedString = NSMutableAttributedString(string: "Don\'t have an account? Sign Up".localized(), attributes: [
            .font: UIFont.bnMediumFontWithSize(ofSize: 18.0),
            .foregroundColor: UIColor.bnText,
            ])
        attributedString.addAttributes([
            .font: UIFont.bnMediumFontWithSize(ofSize: 18.0),
            .foregroundColor: UIColor.bnFadedOrange,
            ], range: NSRange(location: 23, length: 7))
        
        button.setAttributedTitle(attributedString, for: .normal)
        return button
    }()

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.mg_addViewsAndConstraintsWithFormat(orientation: .horizontal, objects: [0, loginLogo, 0])
        view.mg_addViewsAndConstraintsWithFormat(orientation: .vertical, objects: [0, loginLogo])
        loginLogo.mg_makeConstraintHeight(size: 259.0)
        view.sendSubview(toBack: loginLogo)
        
        view.mg_addViewsAndConstraintsWithFormat(orientation: .horizontal, objects: [0, contentView, 0])
        contentTopConstraint = view.mg_addConstraintsEqualsTop(view: contentView, indent: valueByDevice(defaultValue: 232, oldDeviceValue: 132))
        contentBottomConstraint = view.mg_addConstraintsEqualsBottom(view: contentView, indent: 10)
        
        contentView.mg_addViewsAndMakeConstraintEqualCenters(orientation: .horizontal, view: headerLabel, indent: 0.0)
        
        contentView.mg_addViewsAndConstraintsWithFormat(orientation: .horizontal, objects: [24, emailField, 24])
        emailField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        emailField.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        emailField.delegate = self
        
        contentView.mg_addViewsAndConstraintsWithFormat(orientation: .horizontal, objects: [24, passwordField, 24])
        passwordField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        passwordField.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        passwordField.delegate = self
        
        contentView.mg_addViewsAndConstraintsWithFormat(orientation: .horizontal, objects: [forgotPasswordButton, 24])
        forgotPasswordButton.addTarget(self, action: #selector(pressForgotPassword), for:.touchUpInside)
        
        contentView.mg_addViewsAndConstraintsWithFormat(orientation: .vertical, objects: [valueBy5s(defaultValue: 55, oldDeviceValue: 10.0), headerLabel, valueByDevice(defaultValue: 91, oldDeviceValue: 50), emailField, 17, passwordField, 17, forgotPasswordButton])

        contentView.mg_addViewsAndConstraintsWithFormat(orientation: .horizontal, objects: [24, signupButton, 24])
        contentView.mg_addConstraintsEqualsBottom(view: signupButton, indent: -46)
        signupButton.addTarget(self, action: #selector(pressSignUp), for:.touchUpInside)
        
        contentView.mg_addViewsAndConstraintsWithFormat(orientation: .vertical, objects: [loginButton, 12, signupButton])
        contentView.mg_addViewsAndConstraintsWithFormat(orientation: .horizontal, objects: [24, loginButton, 24])
        loginButton.mg_makeConstraintHeight(size: 48)
        loginButton.addTarget(self, action: #selector(pressButton), for:.touchUpInside)
        
        setMiniLogoHidden(hidden: true)
        
        output.viewIsReady()
    }

    //MARK: Actions
    @objc func pressButton(){
        output.loginButtonPressed()
    }
    
    @objc func pressForgotPassword(){
        output.forgotPasswordButtonPressed()
    }
    
    @objc func pressSignUp(){
        output.signUpPressed()
    }
    
    // MARK: LoginViewInput
    func setupInitialState() {
    }
    
    func setLoginEnabled(isEnabled: Bool) {
        loginButton.isEnabled = isEnabled
        loginButton.backgroundColor = isEnabled ? .bnFadedOrange : .bnDefaultGray
    }
    
    func setShowPasswordError(showError: Bool) {
        passwordField.fieldError = showError ? "Wrong password".localized() : nil
    }
}

extension LoginViewController: LoginFieldDelegate{
    func fieldDidChanged(field: LoginField, value: String?) {
        switch field {
        case emailField:
            output.emailChanged(newValue: value)
            break
        case passwordField:
            output.passwordChanged(newValue: value)
            break
        default: break
        }
    }
}
