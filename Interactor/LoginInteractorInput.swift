//
//  Created by Mikhail G. on 18/04/2019.
//  Copyright © 2019. All rights reserved.
//

import Foundation

protocol LoginInteractorInput {
    func auth(login: String, password: String)
}
