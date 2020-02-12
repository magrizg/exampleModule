//
//  Created by Mikhail G. on 18/04/2019.
//  Copyright © 2019. All rights reserved.
//

import Foundation

protocol LoginInteractorOutput: class {
    func authError(error: String?)
    func authSuccess()
}
