//
//  Created by Mikhail G. on 18/04/2019.
//  Copyright © 2019. All rights reserved.
//
import Foundation

protocol LoginViewInput: BaseViewInput {
    func setupInitialState()
    
    func setLoginEnabled(isEnabled: Bool)
    func setShowPasswordError(showError: Bool)
}
